package xynoplex_test

// The failures a program outside the SDK makes, as its tests and its own
// sign-in code do.

import (
	"errors"
	"fmt"
	"net/http"
	"testing"

	xynoplex "github.com/Xynoplex/sdk/go"
)

func TestASignInErrorMadeWithTheIssuersStatusIsItsAnswerAndOneMadeWithoutIsNone(t *testing.T) {
	var answered xynoplex.Error
	if !errors.As(fmt.Errorf("renewing: %w", xynoplex.NewSignInError(xynoplex.SignInErrorCodeExchange, "invalid_grant", http.StatusBadRequest)), &answered) {
		t.Fatal("a sign-in error is no xynoplex.Error")
	}
	if status, ok := answered.Status(); !ok || status != http.StatusBadRequest {
		t.Errorf("the issuer's answer has the status %d, %v", status, ok)
	}
	if answered.ErrorCode() != string(xynoplex.SignInErrorCodeExchange) || answered.Error() != "invalid_grant" {
		t.Errorf("the issuer's answer is %q: %q", answered.ErrorCode(), answered.Error())
	}

	unanswered := &xynoplex.SignInError{Code: xynoplex.SignInErrorCodeExchange, Message: "the network is down"}
	if status, ok := unanswered.Status(); ok {
		t.Errorf("a sign-in nobody answered has the status %d", status)
	}
}
