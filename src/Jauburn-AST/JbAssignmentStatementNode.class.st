Class {
	#name : #JbAssignmentStatementNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #api }
JbAssignmentStatementNode >> executeIn: environment [ 
	environment lookupAt: identifier put: (expression evaluateIn: environment).
]

{ #category : #accessing }
JbAssignmentStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbAssignmentStatementNode >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
JbAssignmentStatementNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbAssignmentStatementNode >> identifier: anObject [
	identifier := anObject
]
