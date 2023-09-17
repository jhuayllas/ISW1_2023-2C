!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:52:13'!
test01IfPrefixNotInStackReturnEmpty

	| sentenceFinder  sentenceStack prefixToFind |
	
	sentenceStack := OOStack new.
	sentenceStack push: 'winter is coming'.
	sentenceStack push: 'winning is everything'.
	sentenceStack push: 'Winter is here'.
	
	prefixToFind := 'test'.
	sentenceFinder := SentenceFinderByPrefix with: sentenceStack andPrefix:prefixToFind .
	
	self assert: sentenceFinder find.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:52:00'!
test02IfPrefixInStackReturnAllThatMatch

	| sentenceFinder  sentenceStack prefixToFind |
	
	sentenceStack := OOStack new.
	sentenceStack push: 'winter is coming'.
	sentenceStack push: 'winning is everything'.
	sentenceStack push: 'Winter is here'.
	
	prefixToFind := 'Wint'.
	sentenceFinder := SentenceFinderByPrefix with: sentenceStack andPrefix:prefixToFind .
	
	self assert: sentenceFinder find.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:50:42'!
test03EmptyPrefixReturnError

	| sentenceFinder  sentenceStack prefixToFind |
	
	sentenceStack := OOStack new.
	sentenceStack push: 'winter is coming'.
	sentenceStack push: 'winning is everything'.
	sentenceStack push: 'Winter is here'.
	
	prefixToFind := ''.
	sentenceFinder := SentenceFinderByPrefix with: sentenceStack andPrefix:prefixToFind .
	
	
	self assert: sentenceFinder find.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:51:13'!
test04PrefixWithBlanksReturnError

	| sentenceFinder  sentenceStack prefixToFind |
	
	sentenceStack := OOStack new.
	sentenceStack push: 'winter is coming'.
	sentenceStack push: 'winning is everything'.
	sentenceStack push: 'Winter is here'.
	
	prefixToFind := 'winter is nice'.
	sentenceFinder := SentenceFinderByPrefix with: sentenceStack andPrefix:prefixToFind .
	
	
	self assert: sentenceFinder find.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:51:44'!
test05StackOrderIsPreserved

	| sentenceFinder  sentenceStack prefixToFind |
	
	sentenceStack := OOStack new.
	sentenceStack push: 'winter is coming'.
	sentenceStack push: 'winning is everything'.
	sentenceStack push: 'Winter is here'.
	
	prefixToFind := 'winte'.
	sentenceFinder := SentenceFinderByPrefix with: sentenceStack andPrefix:prefixToFind .
	
	
	self assert: sentenceFinder find.! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'camila 9/17/2023 20:07:01'!
stackElement
	^stack! !


!OOStack methodsFor: 'initialization' stamp: 'camila 9/17/2023 19:23:22'!
initialize
	stack := OrderedCollection new.
	state := StateVacio new! !

!OOStack methodsFor: 'initialization' stamp: 'camila 9/17/2023 20:01:49'!
initializeWith: oldStack
	oldStack isEmpty ifTrue:
	 [	state := StateVacio new.
		stack := OrderedCollection new. ].
	
	state := StateConCosas new.
	stack := oldStack.! !


!OOStack methodsFor: 'signals' stamp: 'camila 9/15/2023 22:25:05'!
signalCantPopEmptyStack
	self error: self class stackEmptyErrorDescription 
! !


!OOStack methodsFor: 'observation' stamp: 'camila 9/17/2023 20:21:38'!
isEmpty
	"^state isEmpty ."
	^stack isEmpty! !

!OOStack methodsFor: 'observation' stamp: 'camila 9/15/2023 22:14:13'!
size
	^stack size! !

!OOStack methodsFor: 'observation' stamp: 'camila 9/17/2023 20:34:13'!
top
	^state topFromThisStack: stack.
	"stack isEmpty ifTrue:  [^self signalCantPopEmptyStack].
	stack isEmpty ifFalse: [^stack last]." 
	 ! !


!OOStack methodsFor: 'actions' stamp: 'camila 9/17/2023 20:31:22'!
pop
	| topElement |
	topElement := state popFromThisStack: stack.
	
	stack isEmpty ifTrue: [state := StateVacio new.].
	^topElement
	
	"stack isEmpty ifTrue:  [^self signalCantPopEmptyStack].
	stack isEmpty ifFalse: [^stack removeLast]. "
	
	
	! !

!OOStack methodsFor: 'actions' stamp: 'camila 9/17/2023 19:24:46'!
push: aValue
	stack add: aValue.
	state := StateConCosas new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !



!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'StringStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:42:43'!
initialize
	StringStack := OOStack new.! !


!classDefinition: #StackState category: 'Stack-Exercise'!
Object subclass: #StackState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #StateConCosas category: 'Stack-Exercise'!
StackState subclass: #StateConCosas
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StateConCosas methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 19:24:07'!
isEmpty
	^false! !

!StateConCosas methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:23:14'!
popFromThisStack: stack
^stack removeLast .
	"| elem |
	   elem := stackSaved removeLast.
	   stackSaved = OOStack with: stackSaved stackElement
	   ^elem"! !

!StateConCosas methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 19:48:39'!
topFromThisStack: stack
	^stack last 
	"stack isEmpty ifFalse: [^stack removeLast]."! !


!classDefinition: #StateVacio category: 'Stack-Exercise'!
StackState subclass: #StateVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StateVacio methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 19:23:54'!
isEmpty
	^true! !

!StateVacio methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 19:33:17'!
popFromThisStack: stack
	stack signalCantPopEmptyStack .
	"^signalCantPopEmptyStack"! !

!StateVacio methodsFor: 'as yet unclassified' stamp: 'camila 9/17/2023 20:34:43'!
topFromThisStack: stack
	^stack signalCantPopEmptyStack .
	"^signalCantPopEmptyStack"! !
