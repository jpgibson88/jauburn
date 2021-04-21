Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #running }
JbInterpreterTest >> testAbs [
	self interpret: 'var x = abs(100);'.
	self assert: (interpreter environment at: 'x') equals: 100.
	
	self interpret: 'var y = abs(-50);'.
	self assert: (interpreter environment at: 'y') equals: 50.
	
	self interpret: 'var i = abs(0);'.
	self assert: (interpreter environment at: 'i') equals: 0.
]

{ #category : #running }
JbInterpreterTest >> testAssignmentStatementAssignsValue [

	self interpret: 'var z = 0;'.
	self interpret: 'z = 10;'.
	self assert: (interpreter environment at: 'z') equals: 10.
	
]

{ #category : #running }
JbInterpreterTest >> testConcat [
	self interpret: 'var x = concat("this is ", "a prompt");'.
	self assert: (interpreter environment at: 'x') equals: 'this is a prompt'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
	self interpret: 'var x = 6;var y = 10-x;'.
	self assert: (interpreter environment at: 'y') equals: 4.
	
	self interpret: 'var x = 6;var y = 12/x;'.
	self assert: (interpreter environment at: 'y') equals: 2.
	self interpret: 'var x = -6;'.
	self assert: (interpreter environment at: 'x') equals: -6
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #running }
JbInterpreterTest >> testEqualOperatorReturnsFalseIfFalse [

	self interpret: 'var x = 0 == 1;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 10 == 88;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "aString" == "aDifferentString";'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 42;var y = "banana";var z = x == y;'. 
	self assert: (interpreter environment at: 'z') equals: false.

	

]

{ #category : #running }
JbInterpreterTest >> testEqualOperatorReturnsTrueIfTrue [

	self interpret: 'var x = 10 == 10;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 88 == 88;'. 
	self deny: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = "aString" == "aString";'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 42;var y = 42;var z = x == y;'. 
	self assert: (interpreter environment at: 'z') equals: true.

	

]

{ #category : #running }
JbInterpreterTest >> testFunctionCallCallsFunction [

	self interpret: 'var z = 0;'.
	

	self interpret: 'var func = function () {z = 10;};'.
	self interpret: 'func();'. 
	self assert: (interpreter environment at: 'z') equals: 10.	

	

]

{ #category : #running }
JbInterpreterTest >> testFunctionCallPassesArguments [

	self interpret: 'var z = 0;'.
	self interpret: 'var func = function (a, b, c) {z = a + b + c;};'.
	self interpret: 'func(5, 3, 2);'. 
	self assert: (interpreter environment at: 'z') equals: 10.	
		
	self interpret: 'var z = "";'.
	self interpret: 'var func = function (s) {z = s;};'.
	self interpret: 'func("a string");'. 
	self assert: (interpreter environment at: 'z') equals: 'a string'.	
		
	

	

]

{ #category : #running }
JbInterpreterTest >> testFunctionClosure [

	self interpret: 'var make_counter = function() { var count = 0; return function() { count = count + 1; return count; }; };'.
	self interpret: 'var c1 = make_counter();'.
	self interpret: 'var c2 = make_counter();'.
	self interpret: 'c1();'. 
	self interpret: 'c1();'.
	self interpret: 'var x = c1();'.
	self interpret: 'var y = c2();'.
	self assert: (interpreter environment at: 'x') equals: 3.	
	self assert: (interpreter environment at: 'y') equals: 1.	

	

]

{ #category : #running }
JbInterpreterTest >> testFunctionEvaluationAddsFunctionToEnvironment [

	| f |
	self interpret: 'var func = function (x) {return 2 * x;};'.
	f := interpreter environment at: 'func'.
	self assert: f class equals: JbFunction .

	

]

{ #category : #running }
JbInterpreterTest >> testGreaterOrEqualOperatorReturnsFalseIfFalse [

	self interpret: 'var x = 9 >= 10;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 50 >= 88;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 50 >= 88;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "aString" >= "bString";'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = -100;var y = 42;var z = x >= y;'. 
	self assert: (interpreter environment at: 'z') equals: false.

	

]

{ #category : #running }
JbInterpreterTest >> testGreaterOrEqualOperatorReturnsTrueIfTrue [

	self interpret: 'var x = 11 >= 10;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 11 >= 11;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 100 >= 88;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 88 >= 88;'. 
	self deny: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = "cString" >= "bString";'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "bString" >= "bString";'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 100;var y = 42;var z = x >= y;'. 
	self assert: (interpreter environment at: 'z') equals: true.

	


	

]

{ #category : #running }
JbInterpreterTest >> testGreaterThanOperatorReturnsFalseIfFalse [

	self interpret: 'var x = 9 > 10;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 88 > 88;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 88 > 88;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "aString" > "bString";'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = -100;var y = 42;var z = x > y;'. 
	self assert: (interpreter environment at: 'z') equals: false.

	

]

{ #category : #running }
JbInterpreterTest >> testGreaterThanOperatorReturnsTrueIfTrue [

	self interpret: 'var x = 11 > 10;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 89 > 88;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 88 > 88;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 100;var y = 42;var z = x > y;'. 
	self assert: (interpreter environment at: 'z') equals: true.

	

]

{ #category : #running }
JbInterpreterTest >> testInput [
	| mi |
	mi := MockInput new.
	interpreter input: mi.
	self interpret: 'var x = input("this is a prompt");'.
	self assert: (interpreter environment at: 'x') equals: 'test'
]

{ #category : #running }
JbInterpreterTest >> testLength [
	self interpret: 'var x = length("1234567890");'.
	self assert: (interpreter environment at: 'x') equals: 10.
	
	self interpret: 'var y = length("potato");'.
	self assert: (interpreter environment at: 'y') equals: 6.
]

{ #category : #running }
JbInterpreterTest >> testLessOrEqualOperatorReturnsFalseIfFalse [

	self interpret: 'var x = 11 <= 10;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 100 <= 88;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 89 <= 88;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "cString" <= "bString";'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 100;var y = 42;var z = x <= y;'. 
	self assert: (interpreter environment at: 'z') equals: false.

	

]

{ #category : #running }
JbInterpreterTest >> testLessOrEqualOperatorReturnsTrueIfTrue [

	self interpret: 'var x = 10 <= 11;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 11 <= 11;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 11 <= 11;'. 
	self deny: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = "aString" <= "bString";'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "bString" <= "bString";'. 
	self assert: (interpreter environment at: 'x') equals: true.
		
	self interpret: 'var x = 42;var y = 42;var z = x <= y;'. 
	self assert: (interpreter environment at: 'z') equals: true.
	
	self interpret: 'var x = 41;var y = 41;var z = x <= y;'. 
	self assert: (interpreter environment at: 'z') equals: true.

	

]

{ #category : #running }
JbInterpreterTest >> testLessThanOperatorReturnsFalseIfFalse [

	self interpret: 'var x = 11 < 10;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 88 < 88;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 88 < 88;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "bString" < "bString";'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 100;var y = 42;var z = x < y;'. 
	self assert: (interpreter environment at: 'z') equals: false.

	

]

{ #category : #running }
JbInterpreterTest >> testLessThanOperatorReturnsTrueIfTrue [

	self interpret: 'var x = 10 < 11;'. 
	self assert: (interpreter environment at: 'x') equals: true.
		
	self interpret: 'var x = 11 < 11;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 41;var y = 42;var z = x < y;'. 
	self assert: (interpreter environment at: 'z') equals: true.
	

	

]

{ #category : #running }
JbInterpreterTest >> testMod [
	self interpret: 'var x = mod(100, 10);'.
	self assert: (interpreter environment at: 'x') equals: 0.
	
	self interpret: 'var y = mod(17, 5);'.
	self assert: (interpreter environment at: 'y') equals: 2.
	
	self interpret: 'var i = mod(-10, 3);'.
	self assert: (interpreter environment at: 'i') equals: 2.

]

{ #category : #running }
JbInterpreterTest >> testNot [
	self interpret: 'var x = not(true);'.
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var y = not(false);'.
	self assert: (interpreter environment at: 'y') equals: true.
	
	self interpret: 'var i = not(10 == 10);'.
	self assert: (interpreter environment at: 'i') equals: false.
	
	self interpret: 'var j = not(10 != 10);'.
	self assert: (interpreter environment at: 'j') equals: true.
]

{ #category : #running }
JbInterpreterTest >> testNotEqualOperatorReturnsFalseIfFalse [

	self interpret: 'var x = 10 != 10;'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 88 != 88;'. 
	self deny: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = "aString" != "aString";'. 
	self assert: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = 42;var y = 42;var z = x != y;'. 
	self assert: (interpreter environment at: 'z') equals: false.

	

]

{ #category : #running }
JbInterpreterTest >> testNotEqualOperatorReturnsTrueIfTrue [

	self interpret: 'var x = 0 != 1;'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 10 != 88;'. 
	self deny: (interpreter environment at: 'x') equals: false.
	
	self interpret: 'var x = "aString" != "aDifferentString";'. 
	self assert: (interpreter environment at: 'x') equals: true.
	
	self interpret: 'var x = 42;var y = "banana";var z = x != y;'. 
	self assert: (interpreter environment at: 'z') equals: true.

	

]

{ #category : #running }
JbInterpreterTest >> testPrint [
	| mt |
	mt := MockTranscript new.
	interpreter transcript: mt.
	self interpret: 'print (42);'.
	self assert: mt contents equals: '42'.
		
	mt := MockTranscript new.
	interpreter transcript: mt.
	self interpret: 'print ("monkey");'.
	self assert: mt contents equals: '''monkey'''.
]

{ #category : #running }
JbInterpreterTest >> testPrintln [
	| mt |
	mt := MockTranscript new.
	interpreter transcript: mt.
	self interpret: 'println (42);'.
	self assert: (mt contents at: 3) equals: Character cr.

]

{ #category : #running }
JbInterpreterTest >> testReturnStatementReturnsValue [

	self interpret: 'var func = function (a, b, c) {return a + b + c;};'.
	self interpret: 'var z = func(5, 3, 2);'. 
	self assert: (interpreter environment at: 'z') equals: 10.	
		
	

	

]

{ #category : #running }
JbInterpreterTest >> testStringToNumber [
	self interpret: 'var x = stringToNumber("1234");'.
	self assert: (interpreter environment at: 'x') equals: 1234.
	
	self interpret: 'var y = stringToNumber(-2354);'.
	self assert: (interpreter environment at: 'y') equals: -2354.
	
	self interpret: 'var i = stringToNumber(0);'.
	self assert: (interpreter environment at: 'i') equals: 0.

]

{ #category : #running }
JbInterpreterTest >> testUnaryNegationOperatorNegatesNumber [

	self interpret: 'var x = 99;var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: -99.
	self interpret: 'var x = -5;var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: 5.
	self interpret: 'var x = 0;var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: 0.
	self interpret: 'var x = "99";var y = - x;'.
	self assert: (interpreter environment at: 'y') equals: -99.
	self interpret: 'var z = - 10;'.
	self assert: (interpreter environment at: 'z') equals: -10.
	

]

{ #category : #running }
JbInterpreterTest >> testWhileLoopSumsValues [
	self interpret: 'var x = 1;'.
	self interpret: 'var sum = 0;'.
	self interpret: 'while(x <= 10) { sum = sum + x; x = x + 1; }'.
	self assert: (interpreter environment at: 'sum') equals: 55.

]
