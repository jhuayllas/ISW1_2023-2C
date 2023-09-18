!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:52'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:52'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:51'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:52'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:52'!
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

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:52'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:51'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:51'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:51'!
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

!OOStackTest methodsFor: 'test' stamp: 'CJF 9/17/2023 23:08:52'!
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
	instanceVariableNames: 'stackWithSentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 11:51:54'!
setUp
	stackWithSentences := OOStack new.
	stackWithSentences push: 'winter is coming'.
	stackWithSentences push: 'winning is everything'.
	stackWithSentences push: 'Winter is here'.
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 12:00:02'!
test01IfPrefixNotInStackReturnEmpty

	| sentencesFinder sentencesFounded |
	
	sentencesFinder := SentenceFinderByPrefix find: 'test' on: stackWithSentences .
	
	sentencesFounded := sentencesFinder find.
	
	self assert: sentencesFounded isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 12:00:21'!
test02IfPrefixInStackReturnAllThatMatch

	| sentenceFinder  sentencesFounded |
	
	sentenceFinder := SentenceFinderByPrefix find: 'test' on: stackWithSentences .
	
	sentencesFounded := sentenceFinder find.
	
	self assert: sentencesFounded isEmpty.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 11:54:28'!
test03EmptyPrefixReturnError

	self should: [ SentenceFinderByPrefix find: '' on: stackWithSentences ] 
		raise: Error withExceptionDo:[
		:anError | self assert: anError messageText equals: SentenceFinderByPrefix emptyErrorDescription].
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 11:55:22'!
test04PrefixWithBlanksReturnError

	self should: [ SentenceFinderByPrefix find: 'wint er' on: stackWithSentences ] raise: Error withExceptionDo: [ 
		:anError | self assert: anError messageText equals: SentenceFinderByPrefix blanksInPrefixErrorDescription] .
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 11:57:18'!
test05StackOrderIsPreserved

	| sentenceFinder |
	
	sentenceFinder := SentenceFinderByPrefix find: 'Wint' on: stackWithSentences.
	
	sentenceFinder find.
	
	self assert: stackWithSentences pop equals: 'Winter is here'.
	self assert: stackWithSentences pop equals: 'winning is everything'.
	self assert: stackWithSentences pop equals: 'winter is coming'.
	self assert: stackWithSentences isEmpty .! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 11:59:00'!
test06FindIsCaseSensitive

	| sentenceFinder   sentencesFounded |
	stackWithSentences push: 'wint'.
	stackWithSentences push: 'winT'.
	stackWithSentences push: 'wInt'.
	sentenceFinder := SentenceFinderByPrefix find: 'Wint' on: stackWithSentences .
	sentencesFounded := sentenceFinder find.
	self assert: sentencesFounded size = 1.! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 11:59:46'!
test07SentencesFindedAreSentencesInStack

	| sentenceFinder sentencesFounded |
	
	sentenceFinder := SentenceFinderByPrefix find: 'win' on: stackWithSentences .
	
	sentencesFounded := sentenceFinder find.
	
	self assert: sentencesFounded size = 2.
	self assert: 'winning is everything' equals: (sentencesFounded at:1).
	self assert: 'winter is coming' equals: (sentencesFounded at:2)! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'private' stamp: 'CJF 9/17/2023 23:08:51'!
stackElement
	^stack! !


!OOStack methodsFor: 'initialization' stamp: 'CJF 9/17/2023 23:08:51'!
initialize
	stack := OrderedCollection new.
	state := StateVacio new! !

!OOStack methodsFor: 'initialization' stamp: 'CJF 9/17/2023 23:08:51'!
initializeWith: oldStack
	oldStack isEmpty ifTrue:
	 [	state := StateVacio new.
		stack := OrderedCollection new. ].
	
	state := StateConCosas new.
	stack := oldStack.! !


!OOStack methodsFor: 'signals' stamp: 'CJF 9/17/2023 23:08:51'!
signalCantPopEmptyStack
	self error: self class stackEmptyErrorDescription 
! !


!OOStack methodsFor: 'observation' stamp: 'CJF 9/17/2023 23:08:51'!
isEmpty
	"^state isEmpty ."
	^stack isEmpty! !

!OOStack methodsFor: 'observation' stamp: 'CJF 9/17/2023 23:08:51'!
size
	^stack size! !

!OOStack methodsFor: 'observation' stamp: 'CJF 9/17/2023 23:08:51'!
top
	^state topFromThisStack: stack.
	"stack isEmpty ifTrue:  [^self signalCantPopEmptyStack].
	stack isEmpty ifFalse: [^stack last]." 
	 ! !


!OOStack methodsFor: 'actions' stamp: 'CJF 9/17/2023 23:08:51'!
pop
	| topElement |
	topElement := state popFromThisStack: stack.
	
	stack isEmpty ifTrue: [state := StateVacio new.].
	^topElement
	
	"stack isEmpty ifTrue:  [^self signalCantPopEmptyStack].
	stack isEmpty ifFalse: [^stack removeLast]. "
	
	
	! !

!OOStack methodsFor: 'actions' stamp: 'CJF 9/17/2023 23:08:51'!
push: aValue
	stack add: aValue.
	state := StateConCosas new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'CJF 9/17/2023 23:08:51'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'StringStack prefixToFind stackWithSentences foundedSentences stackToRestore'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'CJF 9/18/2023 09:13:18'!
initializeFind: prefix on: stack 

	prefixToFind := prefix.
	stackWithSentences := stack.
	stackToRestore := OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'finder' stamp: 'CJF 9/18/2023 01:28:06'!
find
	foundedSentences := OrderedCollection new.
	self findAllSentencesByPrefix.
	self restoreStack.
	^foundedSentences.! !


!SentenceFinderByPrefix methodsFor: 'finder - private' stamp: 'CJF 9/18/2023 00:38:34'!
findAllSentencesByPrefix
	stackWithSentences size timesRepeat: [ self ifStackTopBeginsWithPrefix].! !

!SentenceFinderByPrefix methodsFor: 'finder - private' stamp: 'CJF 9/18/2023 01:27:28'!
ifStackTopBeginsWithPrefix
	|sentence|
	sentence := stackWithSentences pop.
	stackToRestore push: sentence .
	(sentence beginsWith: prefixToFind) ifTrue: [foundedSentences add: sentence ].! !

!SentenceFinderByPrefix methodsFor: 'finder - private' stamp: 'CJF 9/18/2023 09:16:40'!
restoreStack
	stackToRestore size timesRepeat: [ stackWithSentences push: stackToRestore pop].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'instance creation' stamp: 'CJF 9/18/2023 01:04:57'!
find: prefix on: stackWithSentences 
	self assertNotEmpty: prefix. 
	self assertWithBlanks: prefix.
	^self new initializeFind: prefix on: stackWithSentences ! !


!SentenceFinderByPrefix class methodsFor: 'assertions' stamp: 'CJF 9/18/2023 00:52:14'!
assertNotEmpty: prefix 
	(prefix isEmpty) ifTrue: [ self error: self emptyErrorDescription ].! !

!SentenceFinderByPrefix class methodsFor: 'assertions' stamp: 'CJF 9/18/2023 01:18:10'!
assertWithBlanks: prefix 
	(prefix includesSubString: ' ') ifTrue: [ self error: self blanksInPrefixErrorDescription]! !


!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'CJF 9/18/2023 01:19:06'!
blanksInPrefixErrorDescription
	^'Blanks spaces in prefix provided'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'CJF 9/18/2023 00:53:31'!
emptyErrorDescription
	^'Prefix provided is empty'! !


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

!StateConCosas methodsFor: 'as yet unclassified' stamp: 'CJF 9/17/2023 23:08:52'!
isEmpty
	^false! !

!StateConCosas methodsFor: 'as yet unclassified' stamp: 'CJF 9/17/2023 23:08:52'!
popFromThisStack: stack
^stack removeLast .
	"| elem |
	   elem := stackSaved removeLast.
	   stackSaved = OOStack with: stackSaved stackElement
	   ^elem"! !

!StateConCosas methodsFor: 'as yet unclassified' stamp: 'CJF 9/17/2023 23:08:52'!
topFromThisStack: stack
	^stack last 
	"stack isEmpty ifFalse: [^stack removeLast]."! !


!classDefinition: #StateVacio category: 'Stack-Exercise'!
StackState subclass: #StateVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StateVacio methodsFor: 'as yet unclassified' stamp: 'CJF 9/17/2023 23:08:52'!
isEmpty
	^true! !

!StateVacio methodsFor: 'as yet unclassified' stamp: 'CJF 9/17/2023 23:08:52'!
popFromThisStack: stack
	stack signalCantPopEmptyStack .
	"^signalCantPopEmptyStack"! !

!StateVacio methodsFor: 'as yet unclassified' stamp: 'CJF 9/17/2023 23:08:52'!
topFromThisStack: stack
	^stack signalCantPopEmptyStack .
	"^signalCantPopEmptyStack"! !
