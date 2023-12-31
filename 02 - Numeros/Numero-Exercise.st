!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:17'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:16'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'CJF 9/13/2023 20:18:15'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'CJF 9/14/2023 15:04:57'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:15'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:15'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:15'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:15'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:15'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:15'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:15'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:15'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:15'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'CJF 9/13/2023 20:18:15'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'CJF 9/13/2023 20:18:15'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!
!Entero commentStamp: '<historical>' prior: 0!
Entero with: 2!


!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
* aMultiplier 

	^aMultiplier multiplicarEntero: self.
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
+ anAdder 
	^anAdder sumarEntero: self. 
	
	 
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
- aSubtrahend 
	^aSubtrahend restateAEsteEntero: self.
	"(aSubtrahend isKindOf: Fraccion) ifTrue: [
		^Fraccion with: ((self value * aSubtrahend denominator ) - aSubtrahend  numerator) over: aSubtrahend denominator].
	^ self class with: value - aSubtrahend integerValue."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
/ aDivisor 
	^ aDivisor dividirAEsteEntero: self.
	"(aDivisor isKindOf: Fraccion) ifTrue: [^ Fraccion with:(self value * aDivisor denominator) over:(aDivisor numerator)].
	^Fraccion with: self over: aDivisor"! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:12'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
divideA: numeroADividir
	"^ numeroADividir divideA: self.
	(aDivisor isKindOf: Fraccion) ifTrue: [^ Fraccion with:(self value * aDivisor denominator) over:(aDivisor numerator)].
	^Fraccion with: self over: aDivisor"! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
dividirAEstaFraccion: fraccionQueQuieroDividir
^ Fraccion with: (fraccionQueQuieroDividir numerator )  over: (fraccionQueQuieroDividir denominator * self value).
	"^ Fraccion with: (self numerator )  over: (self denominator * aDivisor value) " ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:12'!
dividirAEsteEntero: enteroQueQuieroDividir 
	^Fraccion with: enteroQueQuieroDividir over: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/14/2023 14:58:07'!
fibonacci
	self subclassResponsibility.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:12'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:12'!
multiplicarEntero: aMultiplier 
	
	^self class with: value * aMultiplier integerValue.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
multiplicarFraccion: aMultiplier 
	
	^aMultiplier multiplicarEntero: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
restateAEstaFraccion: fraccionAlQueHayQueRestar
^Fraccion with:  fraccionAlQueHayQueRestar numerator - (fraccionAlQueHayQueRestar denominator *  self )  over:  fraccionAlQueHayQueRestar denominator. 
"^Fraccion with:  self numerator - (self denominator * aSubtrahend value )  over:  self denominator "! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
restateAEsteEntero: enteroAlQueHayQueRestar
^  self class with: enteroAlQueHayQueRestar integerValue -  value.
"^ self class with: value - aSubtrahend integerValue."! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:13'!
sumarEntero: anAdder
	
	^self class with: value + anAdder integerValue.
	
	 
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:12'!
sumarFraccion: anAdder
	
	^anAdder sumarEntero: self. 
	
	 
! !


!Entero methodsFor: 'comparing' stamp: 'CJF 9/13/2023 20:18:13'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'CJF 9/13/2023 20:18:13'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'CJF 9/13/2023 20:18:13'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'CJF 9/13/2023 20:18:13'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'CJF 9/13/2023 20:18:13'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:13'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:12'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:13'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'CJF 9/13/2023 20:18:14'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'CJF 9/14/2023 15:00:53'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].

	aValue < 0 ifTrue: [ ^EnteroNegativo new initalizeWith: aValue].	
	aValue = 0 ifTrue: [ ^EnteroCero new initalizeWith: aValue ].
	aValue = 1 ifTrue: [ ^EnteroUno new initalizeWith: aValue ].	
	^ElRestoDeLosEnteros new initalizeWith: aValue.
	"^self new initalizeWith: aValue"! !


!classDefinition: #ElRestoDeLosEnteros category: 'Numero-Exercise'!
Entero subclass: #ElRestoDeLosEnteros
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!ElRestoDeLosEnteros methodsFor: 'as yet unclassified' stamp: 'CJF 9/14/2023 14:52:56'!
fibonacci
	| one two |

	one := Entero with: 1.
	two := Entero with: 2.

	^ (self - one) fibonacci + (self - two) fibonacci.! !


!classDefinition: #EnteroCero category: 'Numero-Exercise'!
Entero subclass: #EnteroCero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroCero methodsFor: 'as yet unclassified' stamp: 'CJF 9/14/2023 15:01:38'!
fibonacci
	^ Entero with: 1.! !


!classDefinition: #EnteroNegativo category: 'Numero-Exercise'!
Entero subclass: #EnteroNegativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroNegativo methodsFor: 'as yet unclassified' stamp: 'CJF 9/14/2023 14:39:47'!
fibonacci
	self error: Entero negativeFibonacciErrorDescription
! !


!classDefinition: #EnteroUno category: 'Numero-Exercise'!
Entero subclass: #EnteroUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!EnteroUno methodsFor: 'as yet unclassified' stamp: 'CJF 9/14/2023 15:01:50'!
fibonacci
	^Entero with: 1! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
* aMultiplier 
	^aMultiplier multiplicarFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
+ anAdder 
	
	^anAdder sumarFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
- aSubtrahend 
	
	^aSubtrahend restateAEstaFraccion: self.
	"End of block expected ->| newNumerator newDenominator |
	
	(aSubtrahend isKindOf: Entero) ifTrue: [
		^Fraccion with:  self numerator - (self denominator * aSubtrahend value )  over:  self denominator ].
	
	newNumerator := (numerator * aSubtrahend denominator) - (denominator * aSubtrahend numerator).
	newDenominator := denominator * aSubtrahend denominator.
	
	^newNumerator / newDenominator "
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
/ aDivisor 
	^aDivisor dividirAEstaFraccion: self.
	"(aDivisor isKindOf: Entero) ifTrue: [^ Fraccion with: (self numerator )  over: (self denominator * aDivisor value)  ].
	^(numerator * aDivisor denominator) / (denominator * aDivisor numerator)"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
dividirAEstaFraccion: fraccionQueQuieroDividir
^(fraccionQueQuieroDividir numerator *  denominator) / (fraccionQueQuieroDividir denominator *  numerator)
"^(numerator * aDivisor denominator) / (denominator * aDivisor numerator)"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
dividirAEsteEntero: enteroQueSeQuiereDividir
^ Fraccion with:(enteroQueSeQuiereDividir value *  denominator) over: numerator.
"^ Fraccion with:(self value * aDivisor denominator) over:(aDivisor numerator)	"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
multiplicarEntero: aMultiplier
	
	^Fraccion with:(self numerator *aMultiplier value )  over: (self denominator )! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
multiplicarFraccion: aMultiplier 

	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator).
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
restateAEstaFraccion: fraccionALaQueQuieroRestar

| newNumerator newDenominator |
	
	newNumerator := (fraccionALaQueQuieroRestar numerator *  denominator) - (fraccionALaQueQuieroRestar denominator *  numerator).
	newDenominator := fraccionALaQueQuieroRestar denominator *  denominator.
	
	^newNumerator / newDenominator

"| newNumerator newDenominator |
	
	newNumerator := (numerator * aSubtrahend denominator) - (denominator * aSubtrahend numerator).
	newDenominator := denominator * aSubtrahend denominator.
	
	^newNumerator / newDenominator "! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
restateAEsteEntero: enteroAlQueHayQueRestar
^Fraccion with: ((enteroAlQueHayQueRestar *  denominator ) -   numerator) over:  denominator
"^Fraccion with: ((self value * aSubtrahend denominator ) - aSubtrahend  numerator) over: aSubtrahend denominator"! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
sumarEntero: anAdder
	^Fraccion with: ((self denominator * anAdder value)  + self numerator) over: (self denominator). ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'CJF 9/13/2023 20:18:14'!
sumarFraccion: anAdder 
	
	| newNumerator newDenominator |

	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator.! !


!Fraccion methodsFor: 'comparing' stamp: 'CJF 9/13/2023 20:18:14'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'CJF 9/13/2023 20:18:14'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'CJF 9/13/2023 20:18:14'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'CJF 9/13/2023 20:18:14'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'CJF 9/13/2023 20:18:14'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:14'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:14'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'CJF 9/13/2023 20:18:14'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'CJF 9/13/2023 20:18:14'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'CJF 9/13/2023 20:18:14'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
