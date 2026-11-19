package xynolog

import (
	"go/ast"
	"go/parser"
	"go/token"
	"maps"
	"os"
	"path/filepath"
	"slices"
	"strconv"
	"strings"
	"testing"
)

// declaredStates is each ConnectionState state.go declares, read from its
// source, so a state the package gains is one the census reads.
func declaredStates(t *testing.T) []ConnectionState {
	t.Helper()
	file, err := parser.ParseFile(token.NewFileSet(), "state.go", nil, 0)
	if err != nil {
		t.Fatal(err)
	}
	var states []ConnectionState
	for _, decl := range file.Decls {
		group, ok := decl.(*ast.GenDecl)
		if !ok || group.Tok != token.CONST {
			continue
		}
		for _, spec := range group.Specs {
			value := spec.(*ast.ValueSpec)
			if kind, ok := value.Type.(*ast.Ident); !ok || kind.Name != "ConnectionState" {
				continue
			}
			for _, written := range value.Values {
				literal, ok := written.(*ast.BasicLit)
				if !ok || literal.Kind != token.STRING {
					t.Fatalf("a ConnectionState is not written as a string: %T", written)
				}
				name, err := strconv.Unquote(literal.Value)
				if err != nil {
					t.Fatal(err)
				}
				states = append(states, ConnectionState(name))
			}
		}
	}
	if len(states) == 0 {
		t.Fatal("state.go declares no ConnectionState")
	}
	return states
}

// TestEachStateMayBecomeWhatTheProtocolSaysItMay holds allowed to the graph
// protocol/contract/TRANSPORT-HTTP.md § Connection lifecycle draws. A
// transition the document adds or drops, a state it draws that the package
// does not declare, and a state the package declares that it does not draw
// each fail here.
func TestEachStateMayBecomeWhatTheProtocolSaysItMay(t *testing.T) {
	document, err := os.ReadFile(filepath.Join("..", "protocol", "contract", "TRANSPORT-HTTP.md"))
	if err != nil {
		t.Fatal(err)
	}
	blocks := strings.Split(string(document), "```\n")
	at := slices.IndexFunc(blocks, func(block string) bool { return strings.HasPrefix(block, "initial ") })
	if at < 0 {
		t.Fatal("the document no longer draws the graph where this test reads it")
	}
	declared := declaredStates(t)
	named := func(name string) ConnectionState {
		state := ConnectionState(strings.TrimSpace(name))
		if !slices.Contains(declared, state) {
			t.Fatalf("the document draws %q, which state.go does not declare", state)
		}
		return state
	}
	graph := map[ConnectionState]map[ConnectionState]bool{}
	for _, line := range strings.Split(strings.TrimSuffix(blocks[at], "\n"), "\n") {
		from, to, ok := strings.Cut(line, "→")
		if !ok {
			t.Fatalf("%q draws no transition", line)
		}
		source := named(from)
		if _, drawn := graph[source]; drawn {
			t.Fatalf("%q draws %s twice", line, source)
		}
		targets := map[ConnectionState]bool{}
		if strings.TrimSpace(to) != "(terminal)" {
			for _, name := range strings.Split(to, "|") {
				targets[named(name)] = true
			}
		}
		graph[source] = targets
	}
	if drawn := slices.Sorted(maps.Keys(graph)); !slices.Equal(drawn, slices.Sorted(slices.Values(declared))) {
		t.Fatalf("the document draws %v; state.go declares %v", drawn, declared)
	}
	for _, from := range declared {
		for _, to := range declared {
			if allowed(from, to) != graph[from][to] {
				t.Errorf("%s to %s allowed: %v; the document says %v", from, to, allowed(from, to), graph[from][to])
			}
		}
	}
}
