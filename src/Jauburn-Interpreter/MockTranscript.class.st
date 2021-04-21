Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'stream'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #showing }
MockTranscript >> contents [ 
	^ stream contents
]

{ #category : #showing }
MockTranscript >> cr [ 

	stream << Character cr.

	
]

{ #category : #showing }
MockTranscript >> initialize [

	stream := String new writeStream
]

{ #category : #showing }
MockTranscript >> show: anObject [ 

	stream << anObject

	
]
