Class {
	#name : #JbReturnException,
	#superclass : #Error,
	#instVars : [
		'returnValue'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #accessing }
JbReturnException >> returnValue [
	^ returnValue
]

{ #category : #accessing }
JbReturnException >> returnValue: value [
	returnValue := value
]
