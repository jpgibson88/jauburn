Class {
	#name : #JbReturnStatementNode,
	#superclass : #Object,
	#instVars : [
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbReturnStatementNode >> executeIn: environment [

	| returnValue |
	returnValue := expression evaluateIn: environment.
	(JbReturnException new returnValue: returnValue) signal
	
	
	
	"(expression evaluateIn: environment)."
]

{ #category : #accessing }
JbReturnStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbReturnStatementNode >> expression: anObject [
	expression := anObject
]
