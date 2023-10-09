!classDefinition: #TestMarsRover category: 'MarsRover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: 'initialPosition initialDirection marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestMarsRover methodsFor: 'set up' stamp: 'camila 10/8/2023 23:17:04'!
setUp
	
	initialPosition:= 0@0.
	initialDirection:= Norte new.
	marsRover := MarsRover at: initialPosition withDirection: initialDirection.! !


!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test01NewMarsRoverIsInValidPosition
		
	
	self assert: (marsRover isInPosition: initialPosition pointingTo: initialDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test02MoveForwardIncrementsAxisY
	

	|    aStringOfCommands finalPointAfterCommands |
	
	
	aStringOfCommands := 'f'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition + (0@1).
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: initialDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test03MoveBackwardDecrementsAxisY
	

	|    aStringOfCommands finalPointAfterCommands |
	
	
	aStringOfCommands := 'b'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition - (0@1).
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: initialDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test04RotateLeftChangesDirectionFromNorteToOeste
	

	|    aStringOfCommands finaDirectionAfterCommands |
	
	
	aStringOfCommands := 'l'.
	marsRover processCommands: aStringOfCommands.
	
	finaDirectionAfterCommands := Oeste new.
	
	self assert:( marsRover isInPosition: initialPosition pointingTo: finaDirectionAfterCommands). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test05RotateRightChangesDirectionFromNorteToEste
	

	|    aStringOfCommands finaDirectionAfterCommands |
	
	
	aStringOfCommands := 'r'.
	marsRover processCommands: aStringOfCommands.
	
	finaDirectionAfterCommands := Este new.
	
	self assert:( marsRover isInPosition: initialPosition pointingTo: finaDirectionAfterCommands). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test06InvalidCommand
	

	|    aStringOfCommands |
	
	aStringOfCommands := 'p'.
	
	self should: [marsRover processCommands: aStringOfCommands.] 
		raise: Error  
		withExceptionDo: [ :anError | 
						self assert: anError messageText equals: MarsRover invalidCommandError.
						self assert: (marsRover isInPosition:  initialPosition pointingTo: initialDirection) ]. 
	
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test07TwoForwardCommands
	

	|    aStringOfCommands finalPointAfterCommands |
	
	aStringOfCommands := 'ff'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition + (0@2).
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: initialDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test08ForwardBackwardEnNorte
	

	|    aStringOfCommands finalPointAfterCommands |
	
	aStringOfCommands := 'fb'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition + (0@0).
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: initialDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test09TwoLeftForwardCommandsDecrementsYaxisOneAndPointToSur

	|  aStringOfCommands finalPointAfterCommands finalDirection |
	
	aStringOfCommands := 'llf'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition - (0@1).
	finalDirection := Sur new.
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: finalDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test10ThreeLeftOneForwardCommandsIncrementsXaxisOneAndPointToEste

	|  aStringOfCommands finalPointAfterCommands finalDirection |
	
	aStringOfCommands := 'lllf'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition + (1@0).
	finalDirection := Este new.
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: finalDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test11CompleteRotationOneForwardIncrementsYaxisAndInitialDirection

	|  aStringOfCommands finalPointAfterCommands finalDirection |
	
	aStringOfCommands := 'llllf'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition + (0@1).
	finalDirection := Norte new.
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: finalDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test12TwoRrightOneForwardDecrementsYaxisAndPointToSur
	

	|    aStringOfCommands finalPointAfterCommands finalDirection |
	
	aStringOfCommands := 'rrf'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := initialPosition - (0@1).
	finalDirection := Sur new.
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: finalDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test13MultipleRotationsAndMovementsEndsPointingToEste

	| aStringOfCommands finalPointAfterCommands finalDirection |
	
	aStringOfCommands := 'rlfrb'.
	marsRover processCommands: aStringOfCommands.
	
	finalPointAfterCommands := (-1@1).
	finalDirection := Este new.
	
	self assert:( marsRover isInPosition: finalPointAfterCommands pointingTo: finalDirection). ! !

!TestMarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 23:17:04'!
test14ExecuteUntilInvalidCommand

	|  aStringOfCommands finalPointAfterCommands finalDirection |
	
	aStringOfCommands := 'rlfrbzl'.
	
	finalPointAfterCommands := (-1@1).
	finalDirection := Este new.
	
	self should: [marsRover processCommands: aStringOfCommands.] 
		raise: Error  
		withExceptionDo: [ :anError | 
						self assert: anError messageText equals: MarsRover invalidCommandError.
						self assert: (marsRover isInPosition:  finalPointAfterCommands 
											pointingTo: finalDirection) ]. ! !


!classDefinition: #CardinalDirections category: 'MarsRover'!
Object subclass: #CardinalDirections
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirections methodsFor: 'movement' stamp: 'camila 10/8/2023 22:48:20'!
executeMoveBackwardFor: aMarsRover

	self subclassResponsibility! !

!CardinalDirections methodsFor: 'movement' stamp: 'camila 10/8/2023 22:31:43'!
executeMoveForwardFor: aMarsRover

	self subclassResponsibility! !

!CardinalDirections methodsFor: 'movement' stamp: 'camila 10/8/2023 22:52:14'!
rotateLeftFor: aMarsRover

	self subclassResponsibility! !

!CardinalDirections methodsFor: 'movement' stamp: 'camila 10/8/2023 22:54:28'!
rotateRightFor: aMarsRover

	self subclassResponsibility! !


!classDefinition: #Este category: 'MarsRover'!
CardinalDirections subclass: #Este
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Este methodsFor: 'movement' stamp: 'camila 10/8/2023 22:48:33'!
executeMoveBackwardFor: aMarsRover

	aMarsRover moveBackwardPointingEste ! !

!Este methodsFor: 'movement' stamp: 'camila 10/8/2023 22:34:12'!
executeMoveForwardFor: aMarsRover
	aMarsRover moveFowardPointingEste ! !

!Este methodsFor: 'movement' stamp: 'camila 10/8/2023 22:52:30'!
rotateLeftFor: aMarsRover
	aMarsRover  rotateLeftFromEsteToNorte ! !

!Este methodsFor: 'movement' stamp: 'camila 10/8/2023 22:54:43'!
rotateRightFor: aMarsRover
	aMarsRover rotateRightFromEsteToSur ! !


!classDefinition: #Norte category: 'MarsRover'!
CardinalDirections subclass: #Norte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Norte methodsFor: 'movement' stamp: 'camila 10/8/2023 22:48:43'!
executeMoveBackwardFor: aMarsRover

	aMarsRover moveBackwardPointingNorte ! !

!Norte methodsFor: 'movement' stamp: 'camila 10/8/2023 22:32:46'!
executeMoveForwardFor: aMarsRover
	aMarsRover moveForwardPointingNorte ! !

!Norte methodsFor: 'movement' stamp: 'camila 10/8/2023 22:52:41'!
rotateLeftFor: aMarsRover
	aMarsRover rotateLeftFromNorteToOeste ! !

!Norte methodsFor: 'movement' stamp: 'camila 10/8/2023 22:54:53'!
rotateRightFor: aMarsRover

	aMarsRover rotateRightFromNorteToEste ! !


!classDefinition: #Oeste category: 'MarsRover'!
CardinalDirections subclass: #Oeste
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Oeste methodsFor: 'movement' stamp: 'camila 10/8/2023 22:48:54'!
executeMoveBackwardFor: aMarsRover
aMarsRover moveBackwardPointingOeste ! !

!Oeste methodsFor: 'movement' stamp: 'camila 10/8/2023 22:34:25'!
executeMoveForwardFor: aMarsRover
	aMarsRover moveFowardPointingOeste ! !

!Oeste methodsFor: 'movement' stamp: 'camila 10/8/2023 22:52:52'!
rotateLeftFor: aMarsRover
	aMarsRover rotateLeftFromOesteToSur ! !

!Oeste methodsFor: 'movement' stamp: 'camila 10/8/2023 22:55:03'!
rotateRightFor: aMarsRover

	aMarsRover rotateRightFromOesteToNorte ! !


!classDefinition: #Sur category: 'MarsRover'!
CardinalDirections subclass: #Sur
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!Sur methodsFor: 'movement' stamp: 'camila 10/8/2023 22:49:04'!
executeMoveBackwardFor: aMarsRover

	aMarsRover moveBackwardPointingSur ! !

!Sur methodsFor: 'movement' stamp: 'camila 10/8/2023 22:34:36'!
executeMoveForwardFor: aMarsRover
	aMarsRover moveFowardPointingSur ! !

!Sur methodsFor: 'movement' stamp: 'camila 10/8/2023 22:53:02'!
rotateLeftFor: aMarsRover
	aMarsRover rotateLeftFromSurToEste ! !

!Sur methodsFor: 'movement' stamp: 'camila 10/8/2023 22:55:14'!
rotateRightFor: aMarsRover

	aMarsRover rotateRightFromSurToOeste ! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'currentPosition currentDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'camila 10/5/2023 20:34:07'!
initializeAt: anInitialPosition withDirection: anInitialDirection 

	currentPosition := anInitialPosition.
	currentDirection := anInitialDirection.! !


!MarsRover methodsFor: 'movement' stamp: 'camila 10/8/2023 22:36:44'!
moveBackward
	currentDirection executeMoveBackwardFor: self.! !

!MarsRover methodsFor: 'movement' stamp: 'camila 10/8/2023 22:35:21'!
moveFoward
	currentDirection executeMoveForwardFor: self.! !

!MarsRover methodsFor: 'movement' stamp: 'camila 10/8/2023 22:51:55'!
rotateLeft
	currentDirection rotateLeftFor: self.! !

!MarsRover methodsFor: 'movement' stamp: 'camila 10/8/2023 22:54:18'!
rotateRight
	currentDirection rotateRightFor: self.! !


!MarsRover methodsFor: 'testing' stamp: 'camila 10/8/2023 22:47:47'!
isInPosition: aPosition pointingTo: aDirection 
	^currentPosition = aPosition and: (currentDirection class = aDirection class).! !


!MarsRover methodsFor: 'process commands' stamp: 'camila 10/8/2023 21:44:04'!
processCharCommand: aCharCommand
		aCharCommand = $f ifTrue: [^self moveFoward].
		aCharCommand = $b ifTrue: [^self moveBackward.].
		aCharCommand = $l ifTrue: [^self rotateLeft].
		aCharCommand = $r ifTrue: [^self rotateRight].
		self error: MarsRover invalidCommandError.! !

!MarsRover methodsFor: 'process commands' stamp: 'camila 10/8/2023 21:45:46'!
processCommands: aStringOfCommands 

	aStringOfCommands ifEmpty: [^self].
	
	aStringOfCommands do: [:aCommand | self processCharCommand: aCommand.].
	
	
	! !


!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:36:06'!
moveBackwardPointingEste
	
	^currentPosition := currentPosition - (1@0).! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:35:38'!
moveBackwardPointingNorte
	^currentPosition := currentPosition - (0@1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:36:20'!
moveBackwardPointingOeste
	
	^currentPosition := currentPosition + (1@0)! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:35:54'!
moveBackwardPointingSur
	
	^currentPosition := currentPosition + (0@1).! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:32:34'!
moveForwardPointingNorte
	^currentPosition := currentPosition + (0@1)! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:34:02'!
moveFowardPointingEste

	^currentPosition := currentPosition + (1@0)! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:33:32'!
moveFowardPointingOeste
^currentPosition := currentPosition - (1@0)! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:33:46'!
moveFowardPointingSur
	
	^currentPosition := currentPosition - (0@1).! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:51:37'!
rotateLeftFromEsteToNorte
	^currentDirection := Norte new! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:51:03'!
rotateLeftFromNorteToOeste
	^ currentDirection := Oeste new! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:51:13'!
rotateLeftFromOesteToSur
	^currentDirection := Sur new! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:51:27'!
rotateLeftFromSurToEste
	^currentDirection := Este new! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:53:39'!
rotateRightFromEsteToSur

	^currentDirection := Sur new! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:53:28'!
rotateRightFromNorteToEste

	^currentDirection  := Este new! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:53:59'!
rotateRightFromOesteToNorte

^currentDirection := Norte new.! !

!MarsRover methodsFor: 'movement - private' stamp: 'camila 10/8/2023 22:53:50'!
rotateRightFromSurToOeste

	^currentDirection := Oeste new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'instance creation' stamp: 'camila 10/5/2023 20:34:36'!
at: anInitialPosition withDirection: anInitialDirection 
	
	^self new initializeAt:anInitialPosition  withDirection: anInitialDirection ! !

!MarsRover class methodsFor: 'instance creation' stamp: 'camila 10/8/2023 21:21:40'!
invalidCommandError
	^'Invalid command input'.! !
