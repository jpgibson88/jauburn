"
Just a place to house a few sample programs
"
Class {
	#name : #JbSamplePrograms,
	#superclass : #Object,
	#category : #'Jauburn-Interpreter-SamplePrograms'
}

{ #category : #'sample programs' }
JbSamplePrograms class >> gcd [
	"self run: #squareRoot"

	^ 'var num1 = input("Enter first number");
		var num2 = input("Enter second number");
		var calculateGcd = 
			function (a, b) 
			{ if (a == 0) 
			  {  
			    return b; 
			  }
			  return calculateGcd(mod(b, a), a); 
			};
		
		var result = calculateGcd(num1, num2);
		print(result);'
]

{ #category : #'sample programs' }
JbSamplePrograms class >> noFunctions [
	"self run: #noFunctions"

	^'var x = 1;
var y = 10 * x - 1;
if (y == 9) { 
   x = 16;
}
'
]

{ #category : #utilities }
JbSamplePrograms class >> run: method [
	"Look at sample programs for examples of using this method."

	^JbInterpreter new run: (self perform: method)
]

{ #category : #'sample programs' }
JbSamplePrograms class >> squareRoot [
	"self run: #squareRoot"

	^ 'var number = input("Enter a number");
		var x = number;
		var count = 1; 
		var limit = 1 / 1000;
		var root = 0;
		var distance = 0;
		var continue = true;
		println( concat("Number entered: ", number));
			
		while (continue)
		{ 
			println(concat("Run number: ", count));
			
			root = 1 / 2 * (x + (number / x));
			distance = abs(root - x);
			if (distance < limit) 
			{ 
				continue = false;
			}
			else 
			{ 
				var intermediate = concat("Intermediate root: ", root);
				println(intermediate);
				println("");
			}
			x = root;
			count = count + 1;
		}
		var result = concat("The root of ", number);
		result = concat(result, " is ");
		result = concat(result, root);
		print(result);
		'
]
