"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'transcript',
		'input'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #primitives }
JbInterpreter >> absBinding [
 ^ #abs -> [ :num| num abs .] 
						
						






]

{ #category : #primitives }
JbInterpreter >> concatBinding [
 ^ #concat -> [ :s1 :s2 | s1 asString , s2 asString.] 
						
						






]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
	self initializeEnvBindings 
]

{ #category : #initialization }
JbInterpreter >> initializeEnvBindings [
	^ (self class selectors select: [ :each | each endsWith: 'Binding' ]) 
		do: [ :s |
			| binding primitive |
			binding := self perform: s.
			primitive := JbPrimitive new block: binding value.
			environment at: binding key put: primitive ]
]

{ #category : #accessing }
JbInterpreter >> input [
	^ input ifNil: [ UIManager default ]
]

{ #category : #accessing }
JbInterpreter >> input: anObject [
	input := anObject
]

{ #category : #primitives }
JbInterpreter >> inputBinding [
 ^ #input -> [ :e | self input request: e initialAnswer: ''. ] 
						
						






]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #primitives }
JbInterpreter >> lengthBinding [
 ^ #length -> [ :s | s size. ] 
						
						






]

{ #category : #primitives }
JbInterpreter >> modBinding [
 ^ #mod-> [ :a :b | a asNumber \\ b asNumber .] 
						
						






]

{ #category : #primitives }
JbInterpreter >> notBinding [
 ^ #not -> [ :arg | arg not ] 
						
						






]

{ #category : #primitives }
JbInterpreter >> printBinding [

^ #print -> [:value | self transcript show: value printString]
]

{ #category : #primitives }
JbInterpreter >> printlnBinding [

^ #println -> [:value | self transcript show: value printString; cr]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #primitives }
JbInterpreter >> stringToNumberBinding [
 ^ #stringToNumber -> [ :s| s asNumber ] 
						
						






]

{ #category : #accessing }
JbInterpreter >> transcript [
	^ transcript ifNil: [ Transcript ]
]

{ #category : #accessing }
JbInterpreter >> transcript: anObject [
	transcript := anObject
]
