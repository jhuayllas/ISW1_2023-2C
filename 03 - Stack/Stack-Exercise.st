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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'CJF 9/18/2023 16:03:10'!
test02PrefixNoMatchReturnEmpty

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
	instanceVariableNames: 'current'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!OOStack methodsFor: 'initialization' stamp: 'CJF 9/18/2023 15:48:39'!
initialize
	current := OOStackEmptyElement new.! !



!OOStack methodsFor: 'observation' stamp: 'CJF 9/18/2023 15:52:25'!
isEmpty
	^current size isZero.! !

!OOStack methodsFor: 'observation' stamp: 'CJF 9/18/2023 15:51:34'!
size
	^current size.! !

!OOStack methodsFor: 'observation' stamp: 'CJF 9/18/2023 15:51:48'!
top
	^current top.! !


!OOStack methodsFor: 'actions' stamp: 'CJF 9/18/2023 15:50:05'!
pop
	| element |
	element := current top.
	current := current pop.
	^element.
	! !

!OOStack methodsFor: 'actions' stamp: 'CJF 9/18/2023 15:51:12'!
push: anElement
	current := OOStackWithElement put: anElement over: current.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'CJF 9/17/2023 23:08:51'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'previous element size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStackEmptyElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackEmptyElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyElement methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:56:35'!
pop
	self error: OOStack stackEmptyErrorDescription.! !

!OOStackEmptyElement methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:56:48'!
size
	^0.! !

!OOStackEmptyElement methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:57:10'!
top
	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStackWithElement category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackWithElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:57:47'!
pop
	^previous.! !

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:58:22'!
put: anElement over: anotherElement
	element := anElement.
	previous := anotherElement.! !

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:58:40'!
size
	^1 + previous size.! !

!OOStackWithElement methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:58:55'!
top
	^element.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackWithElement class' category: 'Stack-Exercise'!
OOStackWithElement class
	instanceVariableNames: ''!

!OOStackWithElement class methodsFor: 'as yet unclassified' stamp: 'CJF 9/18/2023 15:59:40'!
put: anElement over: anotherElement.
	^self new put: anElement over: anotherElement.! !


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
