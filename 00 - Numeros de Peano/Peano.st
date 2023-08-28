!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'CJF 8/27/2023 16:27:38'!
* aNaturalNumber
	^ aNaturalNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 21:03:01'!
+ aNaturalNumber
	^ aNaturalNumber next! !

!I class methodsFor: 'as yet unclassified' stamp: 'CJF 8/27/2023 19:45:05'!
- aNAturalNumber! !

!I class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:11:35'!
< aNaturalNumber 
	aNaturalNumber ifNil: [^false].
	aNaturalNumber = I ifTrue: [^false].
	^true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 20:50:42'!
next
	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:13:07'!
previous
	^nil! !

!I class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 21:57:25'!
restateA: aNaturalNumber
	^aNaturalNumber previous.! !


!I class methodsFor: 'nil' stamp: 'CJF 8/28/2023 00:44:43'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^I].
	^nil.! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'CJF 8/27/2023 18:54:57'!
* aNaturalNumber
	^ aNaturalNumber + ( (self previous) * aNaturalNumber ).! !

!II class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 21:17:25'!
+ aNaturalNumber
	^ self previous + aNaturalNumber next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'CJF 8/27/2023 19:48:29'!
- aNaturalNumber

	^aNaturalNumber restateA: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:17:42'!
/ aNaturalNumber
	( self = aNaturalNumber | self < aNaturalNumber ) ifTrue: [^I].
	^ ((self - aNaturalNumber ) / aNaturalNumber ) next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:07:37'!
< aNaturalNumber 
	self previous < aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 21:30:28'!
next
	next ifNotNil: [ ^next ].
	next :=	 self cloneNamed: self name, 'I'.
	next previous: self.
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 21:21:31'!
previous
	^previous ! !

!II class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 21:21:04'!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!II class methodsFor: 'as yet unclassified' stamp: 'JFH 8/24/2023 21:55:42'!
restateA: aNaturalNumber
	^aNaturalNumber previous - self previous .! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'CJF 8/28/2023 01:18:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:03'!
* aNaturalNumber
	^ aNaturalNumber + ( (self previous) * aNaturalNumber ).! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:03'!
+ aNaturalNumber
	^ self previous + aNaturalNumber next.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:03'!
- aNaturalNumber

	^aNaturalNumber restateA: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:03'!
/ aNaturalNumber
	( self = aNaturalNumber | self < aNaturalNumber ) ifTrue: [^I].
	^ ((self - aNaturalNumber ) / aNaturalNumber ) next.

"	|temp temp1|
	temp1 := self - aNaturalNumber .
	
	temp1 ifNotNil:  [ 
			temp := ( self - aNaturalNumber ) / aNaturalNumber.
			temp ifNotNil: [ ^temp next ].
		 ].
	^I."
	! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:03'!
< aNaturalNumber 
	self previous < aNaturalNumber previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:03'!
next
	next ifNotNil: [ ^next ].
	next :=	 self cloneNamed: self name, 'I'.
	next previous: self.
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:03'!
previous
	^previous ! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:04'!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!III class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:04'!
restateA: aNaturalNumber
	^aNaturalNumber previous - self previous .! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'CJF 8/28/2023 01:18:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:04'!
* aNaturalNumber
	^ aNaturalNumber + ( (self previous) * aNaturalNumber ).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:04'!
+ aNaturalNumber
	^ self previous + aNaturalNumber next.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:04'!
- aNaturalNumber

	^aNaturalNumber restateA: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:04'!
/ aNaturalNumber
	( self = aNaturalNumber | self < aNaturalNumber ) ifTrue: [^I].
	^ ((self - aNaturalNumber ) / aNaturalNumber ) next.

"	|temp temp1|
	temp1 := self - aNaturalNumber .
	
	temp1 ifNotNil:  [ 
			temp := ( self - aNaturalNumber ) / aNaturalNumber.
			temp ifNotNil: [ ^temp next ].
		 ].
	^I."
	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:05'!
< aNaturalNumber 
	self previous < aNaturalNumber previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:05'!
next
	next ifNotNil: [ ^next ].
	next :=	 self cloneNamed: self name, 'I'.
	next previous: self.
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:05'!
previous
	^previous ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:05'!
previous: aNaturalNumber
	previous := aNaturalNumber ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CJF 8/28/2023 01:09:05'!
restateA: aNaturalNumber
	^aNaturalNumber previous - self previous .! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'CJF 8/28/2023 01:18:16'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!