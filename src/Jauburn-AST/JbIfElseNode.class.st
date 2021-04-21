Class {
	#name : #JbIfElseNode,
	#superclass : #JbIfNode,
	#instVars : [
		'falseStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIfElseNode >> executeIn: environment [
	(condition evaluateIn: environment) 
		ifTrue: [ super executeIn: environment ]
		ifFalse: 	[ falseStatements  do: [ :each | each executeIn: environment ] ]
]

{ #category : #accessing }
JbIfElseNode >> falseStatements [
	^ falseStatements
]

{ #category : #accessing }
JbIfElseNode >> falseStatements: anObject [
	falseStatements := anObject
]
