Class {
	#name : #MockInput,
	#superclass : #Object,
	#instVars : [
		'prompt'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #initialization }
MockInput >> initialize [

	prompt := String new writeStream
]

{ #category : #showing }
MockInput >> request: aString initialAnswer: initialAnswer [
	^ 'test'
	

	
]
