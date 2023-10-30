!classDefinition: #LoggerHeadingPositionTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LoggerHeadingPositionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LoggerHeadingPositionTest methodsFor: 'as yet unclassified' stamp: 'camila 10/27/2023 20:00:11'!
east

	^ MarsRoverHeadingEast ! !

!LoggerHeadingPositionTest methodsFor: 'as yet unclassified' stamp: 'camila 10/27/2023 20:00:20'!
north

	^ MarsRoverHeadingNorth ! !

!LoggerHeadingPositionTest methodsFor: 'as yet unclassified' stamp: 'camila 10/27/2023 20:00:30'!
south

	^ MarsRoverHeadingSouth ! !

!LoggerHeadingPositionTest methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 20:57:18'!
test01MarsRoverNewWithEmptyLog

	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	logger :=MarsRoverLogger with: marsRover  follow: (OrderedCollection with: $h with:$p).
	
	self assert: (logger printMarsRoverLog ) equals: OrderedCollection new.! !

!LoggerHeadingPositionTest methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 20:57:31'!
test02MarsRoverMovesForwardAndRotatesEast

	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	logger :=MarsRoverLogger with: marsRover  follow: (OrderedCollection with: $h with:$p).
	marsRover process: 'fr'.
	
	self assert: (logger printMarsRoverLog ) equals: (OrderedCollection with: 1@2 with: 'East').! !

!LoggerHeadingPositionTest methodsFor: 'as yet unclassified' stamp: 'camila 10/27/2023 20:00:37'!
west

	^ MarsRoverHeadingWest ! !


!classDefinition: #LoggerHeadingTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LoggerHeadingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LoggerHeadingTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:42:40'!
test01NewMarsRoverWithEmptyLog
	| marsRover logger resLogger |
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	logger :=MarsRoverLogger with: marsRover  follow: {$h} .
	
	resLogger := logger printMarsRoverLog.
	
	self assert: (logger printMarsRoverLog ) equals: OrderedCollection new.! !

!LoggerHeadingTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:43:29'!
test02MarsRoverRotatesLeftLogsWest
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	logger :=MarsRoverLogger with: marsRover  follow: {$h}.
	
	marsRover process: 'l'.
	
	self assert: (logger printMarsRoverLog ) equals: (OrderedCollection with: 'West').
	self assert: (marsRover isAt: 1@1 heading: self west).! !

!LoggerHeadingTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:46:05'!
test03MarsRoverRotatesRightLogsEast
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	logger :=MarsRoverLogger with: marsRover  follow: {$h}.
	
	marsRover process: 'r'.
	
	self assert: (logger printMarsRoverLog ) equals: (OrderedCollection with: 'East').
	self assert: (marsRover isAt: 1@1 heading: self east).! !

!LoggerHeadingTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:46:14'!
test04MarsRoverRotatesNorthLogsNorth
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self east. 
	logger :=MarsRoverLogger with: marsRover  follow: {$h}.
	
	marsRover process: 'l'.
	
	self assert: (logger printMarsRoverLog ) equals: (OrderedCollection with: 'North').
	self assert: (marsRover isAt: 1@1 heading: self north).! !

!LoggerHeadingTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:46:18'!
test05MarsRoverRotatesSouthLogsSouth
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	logger :=MarsRoverLogger with: marsRover  follow: {$h}.
	
	marsRover process: 'rf'.
	
	self assert: (logger printMarsRoverLog ) equals: (OrderedCollection with: 'East').
	self assert: (marsRover isAt: 2@1 heading: self east).! !


!LoggerHeadingTest methodsFor: 'heading' stamp: 'camila 10/27/2023 19:20:29'!
east

	^ MarsRoverHeadingEast ! !

!LoggerHeadingTest methodsFor: 'heading' stamp: 'camila 10/27/2023 19:20:36'!
north

	^ MarsRoverHeadingNorth ! !

!LoggerHeadingTest methodsFor: 'heading' stamp: 'camila 10/27/2023 19:20:43'!
south

	^ MarsRoverHeadingSouth ! !

!LoggerHeadingTest methodsFor: 'heading' stamp: 'camila 10/27/2023 19:20:55'!
west

	^ MarsRoverHeadingWest ! !


!classDefinition: #LoggerPositionTest category: 'MarsRover-WithHeading'!
TestCase subclass: #LoggerPositionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:47:04'!
test01NewMarsRoverWithEmptyLog
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north. 
	logger :=MarsRoverLogger with: marsRover follow: {$p} .
	
	self assert: (logger printMarsRoverLog ) equals: OrderedCollection new.! !

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:47:29'!
test02MarsRoverMovesToNorthLogsNewPosition
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	logger := MarsRoverLogger with: marsRover  follow: {$p}.
	
	marsRover process: 'f'.
	
	self assert: (logger printMarsRoverLog) equals: (OrderedCollection with: 1@2).
	self assert: (marsRover isAt: 1@2 heading: self north) 
	! !

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:54:46'!
test03MarsRoverMovesToNorthTwice
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	logger := MarsRoverLogger with: marsRover  follow: {$p}.
	
	marsRover process: 'ff'.
	
	self assert: (logger printMarsRoverLog) equals: (OrderedCollection with: 1@2 with: 1@3 ).
	self assert: (marsRover isAt: 1@3 heading: self north) 
	! !

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:54:54'!
test04MarsRoverMovesBackward
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	logger := MarsRoverLogger with: marsRover  follow: {$p}.
	
	marsRover process: 'b'.
	
	self assert: (logger printMarsRoverLog) equals: (OrderedCollection with: 1@0).
	self assert: (marsRover isAt: 1@0 heading: self north) 
	! !

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:54:59'!
test05MarsRoverRotatesLeftIsntLogged
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	logger := MarsRoverLogger with: marsRover  follow: {$p}.
	
	marsRover process: 'l'.
	
	self assert: (logger printMarsRoverLog) equals: (OrderedCollection new).
	self assert: (marsRover isAt: 1@1 heading: self west) 
	! !

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:55:04'!
test06MarsRoverRotatesRightIsntLogged
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	logger := MarsRoverLogger with: marsRover  follow: {$p}.
	
	marsRover process: 'r'.
	
	self assert: (logger printMarsRoverLog) equals: (OrderedCollection new).
	self assert: (marsRover isAt: 1@1 heading: self east) 
	! !

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:55:09'!
test07MarsRoverMovesForwardHeadingEastIsLogged
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	logger := MarsRoverLogger with: marsRover  follow: {$p}.
	
	marsRover process: 'rf'.
	
	self assert: (logger printMarsRoverLog) equals: (OrderedCollection with: 2@1 ).
	self assert: (marsRover isAt: 2@1 heading: self east) 
	! !

!LoggerPositionTest methodsFor: 'testing' stamp: 'camila 10/29/2023 20:55:14'!
test08MarsRoverMovesForwardHeadingWestIsLogged
	| marsRover logger|
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	logger := MarsRoverLogger with: marsRover  follow: {$p}.
	
	marsRover process: 'lf'.
	
	self assert: (logger printMarsRoverLog) equals: (OrderedCollection with: 0@1 ).
	self assert: (marsRover isAt: 0@1 heading: self west) 
	! !


!LoggerPositionTest methodsFor: 'heading' stamp: 'camila 10/26/2023 20:40:32'!
east

	^ MarsRoverHeadingEast ! !

!LoggerPositionTest methodsFor: 'heading' stamp: 'camila 10/26/2023 20:40:42'!
north

	^ MarsRoverHeadingNorth ! !

!LoggerPositionTest methodsFor: 'heading' stamp: 'camila 10/26/2023 20:40:56'!
south

	^ MarsRoverHeadingSouth ! !

!LoggerPositionTest methodsFor: 'heading' stamp: 'camila 10/26/2023 20:41:07'!
west

	^ MarsRoverHeadingWest ! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head logger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'camila 10/29/2023 19:45:07'!
initializeAt: aPosition heading: aHeadingType

	position := XXX with: aPosition.
	head := XXX with: (aHeadingType for: self) .! !


!MarsRover methodsFor: 'heading' stamp: 'camila 10/29/2023 20:06:25'!
headEast
	
	head updateAndLog: [:aHeading | MarsRoverHeadingEast for: self].
	"head := MarsRoverHeadingEast for: self"
	! !

!MarsRover methodsFor: 'heading' stamp: 'camila 10/29/2023 20:07:19'!
headNorth
	head updateAndLog: [:aHeading | MarsRoverHeadingNorth for: self].
	"head := MarsRoverHeadingNorth for: self" ! !

!MarsRover methodsFor: 'heading' stamp: 'camila 10/29/2023 20:08:18'!
headSouth
	head updateAndLog: [:aHeading | MarsRoverHeadingSouth for: self].
	"head := MarsRoverHeadingSouth for: self"! !

!MarsRover methodsFor: 'heading' stamp: 'camila 10/29/2023 19:50:40'!
headWest
	head updateAndLog: [  :aHead | MarsRoverHeadingWest for: self].
	"head := MarsRoverHeadingWest for: self" ! !

!MarsRover methodsFor: 'heading' stamp: 'camila 10/29/2023 19:47:36'!
rotateLeft
	
	(head objectValue) rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'camila 10/29/2023 20:05:45'!
rotateRight
	
	(head objectValue) rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'camila 10/29/2023 20:05:22'!
isAt: aPosition heading: aHeadingType

	^(position isValue: aPosition) and: [ (head  objectValue) isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'camila 10/29/2023 20:55:38'!
moveBackward
	
	(head objectValue) moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'camila 10/29/2023 19:43:42'!
moveEast

	position updateAndLog:[:aPosition|  aPosition + (1@0)].
	"position := position + (1@0)"! !

!MarsRover methodsFor: 'moving' stamp: 'camila 10/29/2023 20:04:28'!
moveForward
	
	(head objectValue) moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'camila 10/29/2023 19:33:04'!
moveNorth
	position updateAndLog: [ :aPosition| aPosition + (0@1)].
	"position := position + (0@1)"! !

!MarsRover methodsFor: 'moving' stamp: 'camila 10/29/2023 19:43:10'!
moveSouth
	position updateAndLog:[:aPosition|  aPosition + (0@-1)].
	"position := position + (0@-1)"! !

!MarsRover methodsFor: 'moving' stamp: 'camila 10/29/2023 19:43:57'!
moveWest
	position updateAndLog:[:aPosition|  aPosition + (-1@0)].
	"position := position + (-1@0)"! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'log and update' stamp: 'camila 10/29/2023 20:03:24'!
addLogger: aLogger 
	position addLogger: aLogger.
	head addLogger: aLogger .! !

!MarsRover methodsFor: 'log and update' stamp: 'camila 10/29/2023 20:18:42'!
addLogger: aLogger follow: collectionOfAttributes

	collectionOfAttributes do: [:anAttributeToFollow | 
		anAttributeToFollow = $p ifTrue: [position addLogger: aLogger].
		anAttributeToFollow = $h ifTrue: [head addLogger: aLogger ].
		]
! !

!MarsRover methodsFor: 'log and update' stamp: 'camila 10/27/2023 19:56:46'!
moveAndLogPositionMovement: aBlock
	aBlock value.
	logger ifNotNil: [logger logPosition: position]. 
	! !

!MarsRover methodsFor: 'log and update' stamp: 'camila 10/27/2023 19:48:46'!
rotateAndLog: aBlock 
	aBlock value.
	logger ifNotNil: [logger logHeading: head]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'camila 10/29/2023 20:53:58'!
value

	self subclassResponsibility! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'camila 10/29/2023 20:53:58'!
value
	^'East'.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'camila 10/29/2023 20:53:58'!
value
	^ 'North'.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'camila 10/29/2023 20:53:58'!
value
	^ 'South'.! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'camila 10/29/2023 20:53:59'!
value
	^'West'.! !


!classDefinition: #MarsRoverLogger category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLogger
	instanceVariableNames: 'marsRover log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 20:41:56'!
initializeWith: aMarsRover follow: attributesToFollow 
	marsRover := aMarsRover .
	log := OrderedCollection new.
	aMarsRover addLogger: self follow: attributesToFollow .
	! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 20:53:59'!
log: anObjectValue 
	log add: (anObjectValue value)
	! !

!MarsRoverLogger methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 20:43:46'!
printMarsRoverLog

	^log.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLogger class' category: 'MarsRover-WithHeading'!
MarsRoverLogger class
	instanceVariableNames: ''!

!MarsRoverLogger class methodsFor: 'instance creation' stamp: 'camila 10/29/2023 20:43:14'!
with: aMarsRover follow: attributesToFollow 
	^self new initializeWith: aMarsRover follow: attributesToFollow ! !


!classDefinition: #XXX category: 'MarsRover-WithHeading'!
Object subclass: #XXX
	instanceVariableNames: 'position objectValue loggers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!XXX methodsFor: 'initialization' stamp: 'camila 10/29/2023 19:36:08'!
initializeWith: aPosition 
	
	objectValue := aPosition.
	loggers := OrderedCollection new.! !


!XXX methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 19:35:45'!
addLogger: aLogger 
	loggers add: aLogger.! !

!XXX methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 19:42:22'!
isValue: aPosition 
	^aPosition = objectValue! !

!XXX methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 19:47:47'!
objectValue
	^objectValue! !

!XXX methodsFor: 'as yet unclassified' stamp: 'camila 10/29/2023 19:53:40'!
updateAndLog: aBlock 
	objectValue := aBlock value: objectValue.
	loggers do: [:aLogger | aLogger log: objectValue].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'XXX class' category: 'MarsRover-WithHeading'!
XXX class
	instanceVariableNames: ''!

!XXX class methodsFor: 'instance creation' stamp: 'camila 10/29/2023 19:14:53'!
with: aPosition 
	^self new initializeWith: aPosition ! !
