!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'operaciones auxiliares' stamp: 'CJF 8/28/2023 21:59:14'!
TimesToDivide: aNaturalNumber
	^aNaturalNumber ! !

!I class methodsFor: 'operaciones auxiliares' stamp: 'JFH 8/24/2023 21:57:25'!
restateA: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: 'descripciones de error' stamp: 'CJF 9/3/2023 17:56:34'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^I].
	self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: 'descripciones de error' stamp: 'CJF 8/28/2023 22:03:02'!
NoPuedoDividir
	^'No puedo dividir a I'! !

!I class methodsFor: 'descripciones de error' stamp: 'CJF 9/3/2023 17:55:10'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !

!I class methodsFor: 'descripciones de error' stamp: 'CJF 8/28/2023 21:49:30'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^ 'Numeros negativos no soportados'! !


!I class methodsFor: 'operaciones aritmeticas' stamp: 'CJF 8/27/2023 16:27:38'!
* aNaturalNumber
	^ aNaturalNumber! !

!I class methodsFor: 'operaciones aritmeticas' stamp: 'JFH 8/24/2023 21:03:01'!
+ aNaturalNumber
	^ aNaturalNumber next! !

!I class methodsFor: 'operaciones aritmeticas' stamp: 'CJF 8/28/2023 21:50:38'!
- aNAturalNumber
	^ self error: self descripcionDeErrorDeNumerosNegativosNoSoportados ! !

!I class methodsFor: 'operaciones aritmeticas' stamp: 'JFH 8/24/2023 20:50:42'!
next
	^II! !


!I class methodsFor: 'comparacion' stamp: 'CJF 9/3/2023 17:35:33'!
< aNaturalNumber 
	aNaturalNumber = I ifTrue: [^false].
	aNaturalNumber ifNil: [^false].
	^true.! !


!I class methodsFor: 'acceso' stamp: 'CJF 9/3/2023 19:14:57'!
previous
	^nil! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operaciones auxiliares' stamp: 'CJF 9/3/2023 17:05:47'!
TimesToDivide: aNaturalNumber
	aNaturalNumber = self ifTrue: [^I].
	^I + (aNaturalNumber - self / self ).! !

!II class methodsFor: 'operaciones auxiliares' stamp: 'JFH 8/24/2023 21:55:42'!
restateA: aNaturalNumber
	^aNaturalNumber previous - self previous .! !


!II class methodsFor: 'descripciones de error' stamp: 'CJF 8/28/2023 22:09:23'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'! !


!II class methodsFor: 'operaciones aritmeticas' stamp: 'CJF 8/27/2023 18:54:57'!
* aNaturalNumber
	^ aNaturalNumber + ( (self previous) * aNaturalNumber ).! !

!II class methodsFor: 'operaciones aritmeticas' stamp: 'JFH 8/24/2023 21:17:25'!
+ aNaturalNumber
	^ self previous + aNaturalNumber next.! !

!II class methodsFor: 'operaciones aritmeticas' stamp: 'CJF 8/27/2023 19:48:29'!
- aNaturalNumber

	^aNaturalNumber restateA: self.! !

!II class methodsFor: 'operaciones aritmeticas' stamp: 'CJF 9/3/2023 18:10:33'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I.].
	self < aNaturalNumber ifTrue: [ ^ self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	^aNaturalNumber TimesToDivide: self.! !

!II class methodsFor: 'operaciones aritmeticas' stamp: 'CJF 8/28/2023 21:55:03'!
next
	next ifNotNil: [ ^next ].
	next :=	 II createChildNamed: self name, 'I'.
	next previous: self.
	^next! !


!II class methodsFor: 'comparacion' stamp: 'CJF 9/3/2023 17:53:28'!
< aNaturalNumber 
	aNaturalNumber ifNil: [^false].
	^self previous < aNaturalNumber previous .! !


!II class methodsFor: 'acceso' stamp: 'JFH 8/24/2023 21:21:31'!
previous
	^previous ! !

!II class methodsFor: 'acceso' stamp: 'JFH 8/24/2023 21:21:04'!
previous: aNaturalNumber
	previous := aNaturalNumber ! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'CJF 9/3/2023 19:19:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'CJF 9/3/2023 19:19:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'CJF 9/3/2023 19:19:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!