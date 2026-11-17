#!/usr/bin/env node
import {readFileSync} from 'node:fs';
import {dirname,resolve} from 'node:path';
import {fileURLToPath} from 'node:url';
import ts from 'typescript';
import {writeOrCheck} from '../lib/committed-source.mjs';
const root=resolve(dirname(fileURLToPath(import.meta.url)),'../../..');
const path='typescript/sdk/src/state/lib/search-pipeline.ts';
const source=ts.createSourceFile(path,readFileSync(resolve(root,path),'utf8'),ts.ScriptTarget.Latest,true);
const fail=message=>{throw Error(message);};
const found=source.statements.filter(node=>ts.isInterfaceDeclaration(node)&&node.name.text==='SearchState');
if(found.length!==1||found[0].heritageClauses||found[0].typeParameters?.length!==1||found[0].typeParameters[0].name.text!=='T')fail('SearchState is no plain generic record');
const fields=found[0].members.map(member=>{
 if(!ts.isPropertySignature(member)||!ts.isIdentifier(member.name)||!member.type||member.questionToken||member.modifiers?.length)fail('unread search-state member');
 const type=member.type;
 const native=type.kind===ts.SyntaxKind.BooleanKeyword?'Bool':ts.isArrayTypeNode(type)&&ts.isTypeReferenceNode(type.elementType)&&type.elementType.typeName.getText(source)==='T'&&!type.elementType.typeArguments?'[value]':fail('unread search-state property type');
 return [member.name.text,native];
});
const accessor=name=>'searchState'+name[0].toUpperCase()+name.slice(1);
writeOrCheck(root,resolve(root,'haskell/sdk/generated/Xynolog/Internal/Generated/SearchState.hs'),`-- Generated from ${path}; do not edit.
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.SearchState where
import Data.Aeson (FromJSON(..), ToJSON(..), withObject, object, (.:), (.=))
data SearchState value = SearchState { ${fields.map(([name,type])=>`${accessor(name)} :: ${type}`).join(', ')} } deriving (Eq, Show)
instance FromJSON value => FromJSON (SearchState value) where
  parseJSON = withObject "SearchState" (\\fields -> SearchState ${fields.map(([name],index)=>`${index===0?'<$>':'<*>'} fields .: ${JSON.stringify(name)}`).join(' ')})
instance ToJSON value => ToJSON (SearchState value) where
  toJSON state = object [${fields.map(([name])=>`${JSON.stringify(name)} .= ${accessor(name)} state`).join(', ')}]
`,process.argv.includes('--check'));
const markPath='typescript/sdk/src/state/flows/mark-state-unit.ts';
const markSource=ts.createSourceFile(markPath,readFileSync(resolve(root,markPath),'utf8'),ts.ScriptTarget.Latest,true);
const pending=markSource.statements.filter(node=>ts.isInterfaceDeclaration(node)&&node.name.text==='PendingAnnotation');
if(pending.length!==1||pending[0].typeParameters||pending[0].heritageClauses)fail('PendingAnnotation changed its record shape');
const pendingFields=pending[0].members.map(member=>{
 if(!ts.isPropertySignature(member)||!ts.isIdentifier(member.name)||!member.type||member.questionToken||member.modifiers?.length)fail('unread pending-annotation member');
 const type=member.type;
 let native;
 if(ts.isTypeReferenceNode(type)&&type.typeName.getText(markSource)==='Motivation'&&!type.typeArguments)native='Motivation';
 else if(ts.isUnionTypeNode(type)&&type.types.length===2&&type.types.some(value=>ts.isTypeReferenceNode(value)&&value.typeName.getText(markSource)==='Selector'&&!value.typeArguments)&&type.types.some(value=>ts.isArrayTypeNode(value)&&ts.isTypeReferenceNode(value.elementType)&&value.elementType.typeName.getText(markSource)==='Selector'&&!value.elementType.typeArguments))native='AnnotationSelector';
 else fail('unread pending-annotation property type');
 return [member.name.text,native];
});
const pendingAccessor=name=>'pendingAnnotation'+name[0].toUpperCase()+name.slice(1);
writeOrCheck(root,resolve(root,'haskell/sdk/generated/Xynolog/Internal/Generated/PendingAnnotation.hs'),`-- Generated from ${markPath}; do not edit.
{-# LANGUAGE OverloadedStrings #-}
module Xynolog.Internal.Generated.PendingAnnotation where
import Data.Aeson (FromJSON(..), ToJSON(..), withObject, object, (.:), (.=))
import Xynolog.Types (AnnotationSelector, Motivation)
data PendingAnnotation = PendingAnnotation { ${pendingFields.map(([name,type])=>`${pendingAccessor(name)} :: ${type}`).join(', ')} } deriving (Eq, Show)
instance FromJSON PendingAnnotation where
  parseJSON = withObject "PendingAnnotation" (\\fields -> PendingAnnotation ${pendingFields.map(([name],index)=>`${index===0?'<$>':'<*>'} fields .: ${JSON.stringify(name)}`).join(' ')})
instance ToJSON PendingAnnotation where
  toJSON pending = object [${pendingFields.map(([name])=>`${JSON.stringify(name)} .= ${pendingAccessor(name)} pending`).join(', ')}]
`,process.argv.includes('--check'));
