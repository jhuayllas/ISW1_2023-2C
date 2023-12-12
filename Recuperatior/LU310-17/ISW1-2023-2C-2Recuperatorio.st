!classDefinition: #MineFieldTest category: 'ISW1-2023-2C-2Recuperatorio'!
TestCase subclass: #MineFieldTest
	instanceVariableNames: 'randoms'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!MineFieldTest methodsFor: 'test - battle field' stamp: 'cc 12/11/2023 19:55:15'!
test41FirstTeamMustBeInFirstRow
	
	self 
		should: [ MineField extent: 2@2 elements: #() randomizingWith: self 
				firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 1@2 }) 
				secondTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 2@1 }). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField  invalidStartingPositionErrorDescription.
	
	! !

!MineFieldTest methodsFor: 'test - battle field' stamp: 'cc 12/11/2023 20:04:44'!
test42SecondTeamMustBeInLastRow
	
	self 
		should: [ MineField extent: 2@2 elements: #() randomizingWith: self 
				firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 2@1 }) 
				secondTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 1@1 }). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField  invalidStartingPositionErrorDescription.
	
	! !

!MineFieldTest methodsFor: 'test - battle field' stamp: 'cc 12/11/2023 21:18:37'!
test43PlayersMoveCorrectly
	
	| battleField |
	battleField :=MineField extent: 3@3 elements: #() 
				randomizingWith: self 
				firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 1@1 }) 
				secondTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 3@3 }). 
				
	battleField movePlayerUp.
	self assert: ((battleField lastMovedPlayer) isPlayerAt: 1@2).
	
	battleField movePlayerDown.
	self assert: ((battleField lastMovedPlayer) isPlayerAt: 3@2).
				
	
	! !

!MineFieldTest methodsFor: 'test - battle field' stamp: 'cc 12/11/2023 21:42:31'!
test44FourPlayersMoveCorrectly
	
	| battleField |
	battleField :=MineField extent: 3@3 elements: #() 
				randomizingWith: self 
				firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 1@1. BayonetPlayer lives:1  aPosition: 2@1  }) 
				secondTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 3@3. BayonetPlayer lives:1  aPosition: 2@3  }). 
				
	battleField movePlayerUp.
	self assert: ((battleField lastMovedPlayer) isPlayerAt: 1@2).
	
	battleField movePlayerDown.
	self assert: ((battleField lastMovedPlayer) isPlayerAt: 3@2).
				
	battleField movePlayerUp.
	self assert: ((battleField lastMovedPlayer) isPlayerAt: 2@2).
	
	battleField movePlayerDown.
	self assert: ((battleField lastMovedPlayer) isPlayerAt: 2@2).
	
	! !


!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 20:35:47'!
isPlayerAt22: mineField

	^ (mineField firstTeam)  firstPlayer isPlayerAt: 1@2! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 20:34:53'!
isPlayerAt: mineField

	^ (mineField firstTeam)  firstPlayer isPlayerAt: 1@1! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test01BoardExtentXMustBeGreaterOrEqualTo2

	"No hago una aserción de creación inválida de instancia porque no agregaría mucho valor - Hernan"
	self 
		should: [ MineField extent: 1@2 
			elements: #() 
			randomizingWith: self 
			firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 1@1 }) 
			secondTeam: (PlayerTeam withPlayers: {}) ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidBoardExtentErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test02BoardExtentYMustBeGreaterOrEqualTo2

	self 
		should: [ MineField extent: 2@1 
			elements: #() 
			randomizingWith: self 
			firstTeam: {BayonetPlayer lives:1  aPosition: 1@1 } 
			secondTeam: (PlayerTeam withPlayers: {})  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidBoardExtentErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test03PlayerMustStartAtRow1

	self 
		should: [ MineField extent: 2@2 
			elements: #() 
			randomizingWith: self 
			firstTeam: (PlayerTeam withPlayers:{BayonetPlayer lives:1  aPosition: 1@2 }) 
			secondTeam: (PlayerTeam withPlayers: {})  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test04PlayerLivesMustBeStrictlyPositive

	self 
		should: [ MineField extent: 2@2 
			elements: #() 
			randomizingWith: self 
			firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:0  aPosition: 1@1 } )
			secondTeam: (PlayerTeam withPlayers: {})  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: PlayerTeam invalidPlayerWithInvalidLivesErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test05PlayerLivesMustBeInteger

	self 
		should: [ MineField extent: 2@2 
			elements: #() 
			randomizingWith: self 
			firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1.5  aPosition: 1@1 }) 
			secondTeam: (PlayerTeam withPlayers: {})  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: PlayerTeam invalidPlayerWithInvalidLivesErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test06PlayerMustStartInsideBoard

	self 
		should: [ MineField extent: 2@2 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers:{BayonetPlayer lives:1  aPosition: 0@1 }) secondTeam: (PlayerTeam withPlayers: {})  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription.
		
	self 
		should: [ MineField extent: 2@2 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers:{BayonetPlayer lives:1  aPosition: 3@1 }) secondTeam: (PlayerTeam withPlayers: {})  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription 
		! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test07PlayerMustStartAtAnEmptyPosition

	self 
		should: [ MineField extent: 2@2 elements: { LowPowerMine at: 1@1 } randomizingWith: self firstTeam: (PlayerTeam withPlayers:{BayonetPlayer lives:1  aPosition: 1@1 }) secondTeam: (PlayerTeam withPlayers: {}) ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription.
		
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 21:43:44'!
test08PlayerCanMoveUp

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: #() randomizingWith: self 
				firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1  aPosition: 1@1 }) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerUp.
	
	self deny: (self isPlayerAt: mineField).
	self assert: (self isPlayerAt22: mineField).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 21:43:56'!
test09PlayerCanMoveLeft

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 2@1 }) secondTeam:(PlayerTeam withPlayers: {}) .
	
	mineField movePlayerLeft.
	
	self deny: (mineField isPlayerAt: 2@1).
	self assert: (self isPlayerAt: mineField).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 21:44:01'!
test10PlayerCanMoveRight

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1 }) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight.
	
	self deny: (self isPlayerAt: mineField).
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 21:29:35'!
test11PlayerCanMoveDown

	| mineField |
	
	mineField :=  MineField extent: 2@3 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1 }) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerUp; movePlayerDown.
	
	self assert: (self isPlayerAt: mineField).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 20:34:02'!
test12PlayerStaysOnBoardWhenMovingDown

	| mineField |
	
	mineField :=  MineField extent: 2@3 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1 }) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerDown.
	
	self assert: (self isPlayerAt: mineField).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 20:34:02'!
test13PlayerStaysOnBoardWhenMovingLeft

	| mineField |
	
	mineField :=  MineField extent: 2@3 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerLeft.
	
	self assert: (self isPlayerAt: mineField).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test14PlayerStaysOnBoardWhenMovingRight

	| mineField |
	
	mineField :=  MineField extent: 2@3 elements: #() randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 2@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test15PlayerLoosesLiveWhenStepsIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: { LowPowerMine at: 2@1 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam:(PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test16LowPowerMineExplotesOnlyOnce

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: { LowPowerMine at: 2@1 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test17PlayerLoosesLiveWhenStepsIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 2@2 elements: { HighPowerMine at: 2@1 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight.
	
	self assert: mineField playerLives equals: 0.
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test18HighPowerMineExplotesOnlyOnce

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 2@2 elements: { HighPowerMine at: 2@1 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:3 aPosition: 1@1}) secondTeam:(PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 20:35:22'!
test19PlayerFliesWhenSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(-1 1).
	mineField :=  MineField extent: 2@2 elements: { HighPowerMine at: 2@1 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:3 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight.
	
	self assert: (self isPlayerAt22: mineField)! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test20PlayerDoesNotMoveWhenFliesOutOfBoardSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(10 10).
	mineField :=  MineField extent: 2@2 elements: { HighPowerMine at: 2@1 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1)! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test21PlayerDoesNotLooseLiveWhenWearingLightArmorAndSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. LowPowerMine at: 2@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test22PlayerDoesNotLooseLiveWhenWearingLightArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 5@5 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. HighPowerMine at: 2@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 2@2)
	
	
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test23PlayerFliesHalfWhenWearingLightArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 5@5 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. HighPowerMine at: 2@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 3@3)
	
	
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test24HeavyArmorCanUsedTwiceWhenSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField 
		extent: 3@3 
		elements: { 
			ArmorRack at: 2@1 with: HeavyArmor new. 
			LowPowerMine at: 2@2.
			LowPowerMine at: 1@2 } 
		randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerUp; movePlayerLeft.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test24PlayerDoesNotLooseLiveWhenWearingHeavyArmorAndSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. LowPowerMine at: 2@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test26PlayerDoesNotLooseLifeNorFliesWhenWearingHeavyArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 2@2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. HighPowerMine at: 2@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 2@2)
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 20:35:21'!
test27ArmorIsWeardOnlyOnce

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. 
		HighPowerMine at: 2@2 .
		LowPowerMine at: 1@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerUp; movePlayerDown; movePlayerLeft; movePlayerUp.
	
	self assert: mineField playerLives equals: 1.
	self assert: (self isPlayerAt22: mineField)
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test28WhenPlayerSteppsIntoFirstTunnelHoleAppearsInOther

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 elements: { Tunnel at: 2@1 and: 2@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@2)
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test29WhenPlayerSteppsIntoSecondTunnelHoleAppearsInOther

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 elements: { Tunnel at: 2@1 and: 2@2 } randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:2 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1)
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'HAW 12/7/2023 22:58:26'!
test30FieldElementsCanNotSharePosition

	self assertCannotSharePositionsFor: { LowPowerMine at: 2@2. HighPowerMine at: 2@3. HighPowerMine at: 2@3.} ! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'HAW 12/4/2023 12:17:22'!
test31TunnelDoesNotSharePositionForFirstHole

	self assertCannotSharePositionsFor: { Tunnel at: 2@2 and: 3@3. LowPowerMine at: 2@2. } 
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'HAW 12/4/2023 12:17:32'!
test32TunnelDoesNotSharePositionWithSecondHole

	self assertCannotSharePositionsFor: { Tunnel at: 2@2 and: 3@3. Tunnel at: 1@2 and: 3@3. } 
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 20:02:07'!
test33PlayerWinsWhenAtTopRowAndLeftLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: {} randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers:{}).
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self assert: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test34PlayerDoesNotWinWhenAtTopRowButWithoutLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: {LowPowerMine at: 1@2} randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test35PlayerDoesNotWinWhenNotAtTopRow

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: {} randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	
	self deny: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test36GameIsOverWhenNoLivesLeft

	| mineField |
	
	mineField :=  MineField extent: 2@2 elements: {LowPowerMine at: 2@1} randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	mineField movePlayerRight.
	
	self assert: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test37CannotMoveWhenGameIsOver

	| mineField |
	
	mineField :=  MineField extent: 3@3 elements: {LowPowerMine at: 2@2} randomizingWith: self firstTeam: (PlayerTeam withPlayers: {BayonetPlayer lives:1 aPosition: 1@1}) secondTeam: (PlayerTeam withPlayers: {}) .
	mineField movePlayerRight;movePlayerUp.
	
	self 
		assertIsOverWhenMoving: [mineField movePlayerUp ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerDown ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerRight ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerLeft ] in: mineField
		
	! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'HAW 12/4/2023 12:00:12'!
test38TunnelMustHaveDifferentHoles

	self 
		should: [ Tunnel at: 1@1 and: 1@1 ]
		raise: Error
		withMessageText: Tunnel holesMustBeAtDifferentPositionsErrorDescription! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'HAW 12/4/2023 12:16:11'!
test39TunnelErrorsWhenAskForExitingFromInvalidHole

	| tunnel |
	
	tunnel := Tunnel at: 1@1 and: 2@2.
	
	self 
		should: [ tunnel exitWhenEnteringAt: 3@3 ]
		raise: Error
		withMessageText: Tunnel invalidHoleErrorDescription! !

!MineFieldTest methodsFor: 'tests - mine field' stamp: 'cc 12/11/2023 19:41:36'!
test40ElementsMustBeInsideBoard

	self
		should: [ MineField extent: 2@2 elements: { LowPowerMine at: 3@3 } randomizingWith: self firstTeam: {} secondTeam: (PlayerTeam withPlayers: {})  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField fieldElementsMustBeInsideBoardErrorDescription! !


!MineFieldTest methodsFor: 'random simulation' stamp: 'HAW 11/27/2023 19:19:32'!
nextInteger: aMaxValue

	| random |
	
	random := randoms peek.
	randoms next.
	
	^random! !

!MineFieldTest methodsFor: 'random simulation' stamp: 'HAW 11/27/2023 20:03:52'!
randomPositionIncrementsAre: aCollectionOfRandoms 
	
	randoms := ReadStream on: (aCollectionOfRandoms collect: [ :aPosition | aPosition + 4 ])! !


!MineFieldTest methodsFor: 'assertions' stamp: 'cc 12/11/2023 19:41:36'!
assertCannotSharePositionsFor: elements

	self
		should: [ MineField 
			extent: 3@3 
			elements: elements
			randomizingWith: self firstTeam: {} secondTeam: {}. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField fieldElementsShouldNotSharePositionsErrorDescription! !

!MineFieldTest methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:58:37'!
assertIsOverWhenMoving: aMovingBlock in: aMineField

	self 
		should: aMovingBlock 
		raise:  Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MineField gameIsOverErrorDescription.
			self assert: (aMineField isPlayerAt: 2@2) ]. 
	! !


!classDefinition: #PlayerTeamTest category: 'ISW1-2023-2C-2Recuperatorio'!
TestCase subclass: #PlayerTeamTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!PlayerTeamTest methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:10:39'!
test01TeamCannotStartWithPlayerWithNoLives
self 
		should: [ PlayerTeam withPlayers: {BayonetPlayer lives: 0 aPosition: 1@1 }.]
		raise: Error - MessageNotUnderstood 
		withMessageText: (PlayerTeam invalidPlayerWithInvalidLivesErrorDescription).! !

!PlayerTeamTest methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:10:39'!
test02TeamCannotStartWithPlayerWithNegativeLives
	self 
		should: [ PlayerTeam withPlayers: {BayonetPlayer lives: -1 aPosition: 1@1 }.]
		raise: Error - MessageNotUnderstood 
		withMessageText: (PlayerTeam invalidPlayerWithInvalidLivesErrorDescription).! !

!PlayerTeamTest methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:10:39'!
test03TeamCannotStartWithPlayerWithNonIntegerLives
	self 
		should: [ PlayerTeam withPlayers: {BayonetPlayer lives: 1.5 aPosition: 1@1 }.]
		raise: Error - MessageNotUnderstood 
		withMessageText: (PlayerTeam invalidPlayerWithInvalidLivesErrorDescription ).! !

!PlayerTeamTest methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:12:18'!
test04TeamCannotStartWithPlayersInSamePosition
	self 
		should: [ PlayerTeam withPlayers: {BayonetPlayer lives: 1 aPosition: 1@1. BayonetPlayer lives: 2 aPosition: 1@1  }.]
		raise: Error - MessageNotUnderstood 
		withMessageText: (PlayerTeam positionsCannotBeTheSameForPlayersErrorDescription ).! !

!PlayerTeamTest methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:16:41'!
test05TeamIsCreatedWithValidPlayersWithValidLives

	| team |
	team := PlayerTeam withPlayers: {BayonetPlayer lives: 1 aPosition: 1@1. BayonetPlayer lives: 2 aPosition: 1@2  }.
	self assert: (team totalTeamLivesIs: 3).! !


!classDefinition: #Armor category: 'ISW1-2023-2C-2Recuperatorio'!
Object subclass: #Armor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:37'!
defendFromHighPowerMine: aHighPowerMine in: aMineField

	self subclassResponsibility! !

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:41'!
defendFromLowPowerMine: aLowPowerMine in: aMineField

	self subclassResponsibility! !


!Armor methodsFor: 'flying' stamp: 'HAW 12/4/2023 09:35:05'!
flyingThroughtTheAirStep: aMineField

	^ (aMineField nextInteger: 7) - 4 @ ((aMineField nextInteger: 7) - 4)! !


!classDefinition: #HeavyArmor category: 'ISW1-2023-2C-2Recuperatorio'!
Armor subclass: #HeavyArmor
	instanceVariableNames: 'usedTimesWithLowPowerMine'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!HeavyArmor methodsFor: 'defend from mine' stamp: 'HAW 11/27/2023 20:04:16'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	aMineField armorUsed.
	^0@0! !

!HeavyArmor methodsFor: 'defend from mine' stamp: 'HAW 12/2/2023 20:38:07'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	usedTimesWithLowPowerMine := usedTimesWithLowPowerMine + 1.
	usedTimesWithLowPowerMine = 2 ifTrue: [ aMineField armorUsed ]! !


!HeavyArmor methodsFor: 'initialization' stamp: 'HAW 12/2/2023 20:38:26'!
initialize

	super initialize.
	usedTimesWithLowPowerMine := 0.! !


!classDefinition: #LightArmor category: 'ISW1-2023-2C-2Recuperatorio'!
Armor subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!LightArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:28'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	| step |
	
	aMineField armorUsed.
	step := (self flyingThroughtTheAirStep: aMineField) // 2.
	
	^step
! !

!LightArmor methodsFor: 'defend from mine' stamp: 'HAW 11/28/2023 10:21:42'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	aMineField armorUsed! !


!classDefinition: #NoArmor category: 'ISW1-2023-2C-2Recuperatorio'!
Armor subclass: #NoArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!NoArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 11:00:16'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	| step |
	
	aMineField decreasePlayerLives; decreasePlayerLives.
	step := self flyingThroughtTheAirStep: aMineField.
	
	^step
	! !

!NoArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 11:00:16'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	aMineField decreasePlayerLives ! !


!classDefinition: #BayonetPlayer category: 'ISW1-2023-2C-2Recuperatorio'!
Object subclass: #BayonetPlayer
	instanceVariableNames: 'lives position armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!BayonetPlayer methodsFor: 'initialization' stamp: 'cc 12/11/2023 17:28:33'!
initializeLives: aNumberOfLives 
	
	lives := aNumberOfLives.! !

!BayonetPlayer methodsFor: 'initialization' stamp: 'cc 12/11/2023 17:42:23'!
initializeLives: aNumberOfLives position: aStartingPosition 

	lives := aNumberOfLives.
	position := aStartingPosition.
	armor := NoArmor new.! !


!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:55:40'!
armorUsed
	armor := NoArmor new! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:37:22'!
currentPosition
	^position! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:30:11'!
decreasePlayerLives
	lives := lives - 1! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:46:46'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	^armor defendFromHighPowerMine: aHighPowerMine in: aMineField.! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:48:58'!
equipArmor: anArmor 
	armor := anArmor! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:34:51'!
isPlayerAt: aPosition 
	^position = aPosition ! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:14:30'!
isSharingPositionWith: aPlayer 
	^aPlayer isPlayerAt: position! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:29:43'!
isStillAlive
	^ lives > 0! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:31:05'!
livesLeft
	^ lives! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:35:32'!
moveToPosition: newPosition 
	position := newPosition ! !

!BayonetPlayer methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 17:43:53'!
steppedIntoLowPowerMine: aLowPowerMine in: aMineField 
	armor defendFromLowPowerMine: aLowPowerMine in: aMineField.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BayonetPlayer class' category: 'ISW1-2023-2C-2Recuperatorio'!
BayonetPlayer class
	instanceVariableNames: ''!

!BayonetPlayer class methodsFor: 'instance creation' stamp: 'cc 12/11/2023 17:33:16'!
lives: aNumberOfLives aPosition: aStartingPosition 
	^self new initializeLives: aNumberOfLives position: aStartingPosition. ! !


!classDefinition: #FieldElement category: 'ISW1-2023-2C-2Recuperatorio'!
Object subclass: #FieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!FieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField

	self subclassResponsibility! !


!classDefinition: #EmptyFieldElement category: 'ISW1-2023-2C-2Recuperatorio'!
FieldElement subclass: #EmptyFieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!EmptyFieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	! !


!classDefinition: #NotEmptyFieldPosition category: 'ISW1-2023-2C-2Recuperatorio'!
FieldElement subclass: #NotEmptyFieldPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:40'!
isAt: aPosition

	self subclassResponsibility! !

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:12'!
isSharingPositionWith: aFieldElement

	self subclassResponsibility! !


!classDefinition: #ArmorRack category: 'ISW1-2023-2C-2Recuperatorio'!
NotEmptyFieldPosition subclass: #ArmorRack
	instanceVariableNames: 'position armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!ArmorRack methodsFor: 'initialization' stamp: 'HAW 11/27/2023 20:00:21'!
initializeAt: aPosition with: anArmor
	
	position := aPosition.
	armor := anArmor ! !


!ArmorRack methodsFor: 'position testing' stamp: 'HAW 11/27/2023 19:28:56'!
isAt: aPosition

	^position = aPosition ! !

!ArmorRack methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:26:10'!
isInsideBoardOf: anExtent 
	
	^position between: 1@1 and: anExtent ! !

!ArmorRack methodsFor: 'position testing' stamp: 'HAW 12/2/2023 21:04:55'!
isSharingPositionWith: aFieldElement 
	
	^aFieldElement isAt: position ! !


!ArmorRack methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoArmorRack: self with: armor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ArmorRack class' category: 'ISW1-2023-2C-2Recuperatorio'!
ArmorRack class
	instanceVariableNames: ''!

!ArmorRack class methodsFor: 'instance creation' stamp: 'HAW 11/27/2023 20:00:05'!
at: aPosition with: anArmor

	^self new initializeAt: aPosition with: anArmor! !


!classDefinition: #Mine category: 'ISW1-2023-2C-2Recuperatorio'!
NotEmptyFieldPosition subclass: #Mine
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!Mine methodsFor: 'initialization' stamp: 'HAW 11/27/2023 19:08:03'!
initializeAt: aPosition 
	
	position := aPosition.! !


!Mine methodsFor: 'position testing' stamp: 'HAW 11/27/2023 19:08:09'!
isAt: aPosition 
	
	^position = aPosition ! !

!Mine methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:25:42'!
isInsideBoardOf: anExtent 
	
	^position between: 1@1 and: anExtent ! !

!Mine methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:43:04'!
isSharingPositionWith: aFieldElement 
	
	^aFieldElement isAt: position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mine class' category: 'ISW1-2023-2C-2Recuperatorio'!
Mine class
	instanceVariableNames: ''!

!Mine class methodsFor: 'instance creation' stamp: 'HAW 11/28/2023 12:55:22'!
at: aPosition 
	
	^self new initializeAt: aPosition! !


!classDefinition: #HighPowerMine category: 'ISW1-2023-2C-2Recuperatorio'!
Mine subclass: #HighPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!HighPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoHighPowerMine: self! !


!classDefinition: #LowPowerMine category: 'ISW1-2023-2C-2Recuperatorio'!
Mine subclass: #LowPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!LowPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoLowPowerMine: self! !


!classDefinition: #Tunnel category: 'ISW1-2023-2C-2Recuperatorio'!
NotEmptyFieldPosition subclass: #Tunnel
	instanceVariableNames: 'hole anotherHole'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!Tunnel methodsFor: 'initialization' stamp: 'HAW 12/2/2023 20:44:14'!
initializeAt: aHole and: anAnotherHole 
	
	hole := aHole.
	anotherHole := anAnotherHole.! !


!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/2/2023 20:45:30'!
isAt: aPosition 
	
	^hole = aPosition or: [ anotherHole = aPosition ]! !

!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:26:43'!
isInsideBoardOf: anExtent 
	
	^(hole between: 1@1 and: anExtent) and: [ anotherHole between: 1@1 and: anExtent ]! !

!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/2/2023 21:08:52'!
isSharingPositionWith: aFieldElement 
	
	^(aFieldElement isAt: hole) or: [ aFieldElement isAt: anotherHole ]! !


!Tunnel methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 12:04:59'!
exitWhenEnteringAt: aPosition 
	
	aPosition = hole ifTrue: [ ^anotherHole ].
	aPosition = anotherHole ifTrue: [ ^hole ].
	
	self error: self class invalidHoleErrorDescription 
	
	
	! !

!Tunnel methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoTunnel: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tunnel class' category: 'ISW1-2023-2C-2Recuperatorio'!
Tunnel class
	instanceVariableNames: ''!

!Tunnel class methodsFor: 'instance creation' stamp: 'HAW 12/4/2023 12:02:03'!
assert: aHole doesNotSharePositionWith: anotherHole

	^ aHole = anotherHole ifTrue: [ self error: self holesMustBeAtDifferentPositionsErrorDescription ]! !

!Tunnel class methodsFor: 'instance creation' stamp: 'HAW 12/4/2023 12:02:03'!
at: aHole and: anotherHole 
	
	self assert: aHole doesNotSharePositionWith: anotherHole.
	
	^self new initializeAt: aHole and: anotherHole ! !


!Tunnel class methodsFor: 'error description' stamp: 'HAW 12/4/2023 12:00:43'!
holesMustBeAtDifferentPositionsErrorDescription
	
	^'Holes must be at different positions'! !

!Tunnel class methodsFor: 'error description' stamp: 'HAW 12/4/2023 12:04:05'!
invalidHoleErrorDescription
	
	^'Invalid hole'! !


!classDefinition: #MineField category: 'ISW1-2023-2C-2Recuperatorio'!
Object subclass: #MineField
	instanceVariableNames: 'boardExtent fieldElements random player firstTeam secondTeam turn lastPlayerMoved currentPlayer allPlayers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!MineField methodsFor: 'initialization' stamp: 'cc 12/11/2023 21:12:35'!
initializeExtent: anExtent elements: aCollectionOfFieldElements randomizingWith: aRandom firstTeam: aFirstTeam secondTeam: aSecondTeam    
	
	boardExtent := anExtent.
	fieldElements := aCollectionOfFieldElements asOrderedCollection .
	random := aRandom.
	
	"player := BayonetPlayer lives: aNumberOfLives aPosition: aStartingPosition."
	firstTeam := aFirstTeam.
	secondTeam := aSecondTeam.
	
	currentPlayer := firstTeam currentPlayer 
	! !


!MineField methodsFor: 'random' stamp: 'HAW 11/28/2023 12:53:15'!
nextInteger: aMaxInteger

	^random nextInteger: aMaxInteger ! !


!MineField methodsFor: 'testing' stamp: 'HAW 12/4/2023 10:48:44'!
hasPlayerWon
	
	^self isOver and: [ self isPlayerStillAlive ]! !

!MineField methodsFor: 'testing' stamp: 'cc 12/11/2023 20:43:44'!
isOver
	
	(firstTeam includes: self currentPlayer ) ifTrue: [^self isPlayerAtTopRow or: [self isPlayerStillAlive not]].
	^false
	! !

!MineField methodsFor: 'testing' stamp: 'cc 12/11/2023 18:38:03'!
isPlayerAt: aPosition

	^self currentPlayer isPlayerAt: aPosition ! !

!MineField methodsFor: 'testing' stamp: 'cc 12/11/2023 18:49:42'!
isPlayerAtTopRow

	^ (self currentPlayer currentPosition) y = boardExtent y! !

!MineField methodsFor: 'testing' stamp: 'cc 12/11/2023 18:44:21'!
isPlayerStillAlive

	^ self currentPlayer isStillAlive! !


!MineField methodsFor: 'player' stamp: 'cc 12/11/2023 18:38:03'!
armorUsed
	
	self currentPlayer armorUsed! !

!MineField methodsFor: 'player' stamp: 'cc 12/11/2023 20:45:14'!
currentPlayer

	^ firstTeam currentPlayer.
! !

!MineField methodsFor: 'player' stamp: 'cc 12/11/2023 18:38:03'!
decreasePlayerLives
	
	self currentPlayer decreasePlayerLives! !

!MineField methodsFor: 'player' stamp: 'cc 12/11/2023 18:38:03'!
playerLives
	
	^self currentPlayer livesLeft! !


!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:24:49'!
movePlayerDown
	
	self movePlayer: 0@-1! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:25:00'!
movePlayerLeft
	
	self movePlayer: -1@0! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:25:09'!
movePlayerRight
	
	self movePlayer: 1@0! !

!MineField methodsFor: 'moving' stamp: 'cc 12/11/2023 20:42:39'!
movePlayerUp
	
	self movePlayer: 0@1.
	! !


!MineField methodsFor: 'moving - private' stamp: 'cc 12/11/2023 18:38:03'!
fieldElementAtPlayerPosition

	^ fieldElements detect: [ :aFieldElement | aFieldElement isAt: self currentPlayer currentPosition ] ifNone: [ EmptyFieldElement new ]! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:01:47'!
isInBoard: aPosition

	^ aPosition between: 1@1 and: boardExtent! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:01:18'!
movePlayer: aStep

	^self movePlayer: aStep ifGameOver: [ self error: self class gameIsOverErrorDescription ].! !

!MineField methodsFor: 'moving - private' stamp: 'cc 12/11/2023 21:12:01'!
movePlayer: aStep ifGameOver: aBlock

	| newPosition |
	
	self isOver ifTrue: [^aBlock value].
	"self isOver ifTrue: [ ^aBlock value ]."
	
	newPosition := currentPlayer currentPosition + aStep.
	(self isInBoard: newPosition) ifTrue: [ self movePlayerTo: newPosition ]! !

!MineField methodsFor: 'moving - private' stamp: 'cc 12/11/2023 21:26:49'!
movePlayerTo: newPosition

	currentPlayer moveToPosition: newPosition.
	self fieldElementAtPlayerPosition playerSteppedIntoFrom: self.
	
	lastPlayerMoved :=  currentPlayer.
	self nextPlayer.! !


!MineField methodsFor: 'steep into field element' stamp: 'cc 12/11/2023 18:38:03'!
playerSteppedIntoArmorRack: anArmorRack with: anArmor 
	
	self currentPlayer equipArmor: anArmor.
	self removeFieldElement: anArmorRack ! !

!MineField methodsFor: 'steep into field element' stamp: 'cc 12/11/2023 18:38:03'!
playerSteppedIntoHighPowerMine: aHighPowerMine 
	
	| step |
	
	step := self currentPlayer defendFromHighPowerMine: aHighPowerMine in: self.
	self removeFieldElement: aHighPowerMine .
	self movePlayer: step ifGameOver: []
	
	! !

!MineField methodsFor: 'steep into field element' stamp: 'cc 12/11/2023 18:38:03'!
playerSteppedIntoLowPowerMine: aLowPowerMine 
	
	self currentPlayer steppedIntoLowPowerMine: aLowPowerMine in: self.
	self removeFieldElement: aLowPowerMine ! !

!MineField methodsFor: 'steep into field element' stamp: 'cc 12/11/2023 18:38:03'!
playerSteppedIntoTunnel: aTunnel 
	
	| exitPosition |
	
	exitPosition := aTunnel exitWhenEnteringAt: self currentPlayer currentPosition.
	self currentPlayer moveToPosition: exitPosition.! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 11/27/2023 19:01:18'!
removeFieldElement: aFieldElement 
	
	fieldElements remove: aFieldElement ! !


!MineField methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 20:10:45'!
firstTeam
	^firstTeam! !

!MineField methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 21:18:46'!
lastMovedPlayer
	^lastPlayerMoved ! !

!MineField methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 21:45:58'!
nextPlayer
	

	(firstTeam includes: lastPlayerMoved) ifTrue: [currentPlayer :=secondTeam currentPlayer . firstTeam advancePlayer].
	(secondTeam includes: lastPlayerMoved) ifTrue: [currentPlayer := firstTeam currentPlayer. secondTeam advancePlayer].! !

!MineField methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 20:30:30'!
secondTeam
	^secondTeam! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineField class' category: 'ISW1-2023-2C-2Recuperatorio'!
MineField class
	instanceVariableNames: ''!

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:56:39'!
assert: aStartingPosition isAtFirstRow: anExtent

	(aStartingPosition between: 1@1 and: anExtent x @ 1) ifFalse: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:00'!
assert: aStartingPosition isInBoundsFor: anExtent andNotUsedBy: aCollectionOfFieldElements .
	
	self assert: aStartingPosition isAtFirstRow: anExtent.
	self assert: aStartingPosition isNotUsedBy: aCollectionOfFieldElements! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:00'!
assert: aStartingPosition isNotUsedBy: aCollectionOfFieldElements

	^ (aCollectionOfFieldElements anySatisfy: [ :aFieldElement | aFieldElement isAt: aStartingPosition ]) 
		ifTrue: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/7/2023 23:20:51'!
assertElementsDoNotSharePosition: aCollectionOfFieldElements

	aCollectionOfFieldElements combinations: 2 atATimeDo: [ :elements |
		(elements first isSharingPositionWith: elements second) ifTrue: [
			self error: self fieldElementsShouldNotSharePositionsErrorDescription ]]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:12:42'!
assertIsValidExtent: anExtent

	^ anExtent >=(2@2) ifFalse: [ self error: self invalidBoardExtentErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:32'!
assertIsValidNumberOfLives: aNumberOfLives

	^ (aNumberOfLives strictlyPositive and: [ aNumberOfLives isInteger ]) ifFalse: [ self error: self invalidNumberOfLivesErrorDescription ]! !


!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/4/2023 12:20:01'!
fieldElementsMustBeInsideBoardErrorDescription
	
	^'Field elements must be inside board'
! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/2/2023 21:00:39'!
fieldElementsShouldNotSharePositionsErrorDescription
	
	^'Field elements should not share positions'! !

!MineField class methodsFor: 'error descriptions' stamp: 'cc 12/11/2023 19:54:06'!
firstTeamMustBeInFirstRowErrorDescription
	^'First team must be in first row'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/2/2023 21:30:59'!
gameIsOverErrorDescription
	
	^'Cannot move when game is over'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 11:51:11'!
invalidBoardExtentErrorDescription
	
	^'Board extent must be greater or equal to 2@2'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 12:00:56'!
invalidNumberOfLivesErrorDescription
	
	^'Number of lives must be an strictly positive integer'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 12:13:28'!
invalidStartingPositionErrorDescription
	
	^'Player must start at an empty position, inside the board and at row 1'! !

!MineField class methodsFor: 'error descriptions' stamp: 'cc 12/11/2023 19:47:59'!
invalidTeamLivesErrorDescription
	^' Team must have same amount of lives'! !


!MineField class methodsFor: 'instance creation' stamp: 'HAW 12/5/2023 16:50:37'!
assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent

	(aCollectionOfFieldElements allSatisfy: [ :aFieldElement | aFieldElement isInsideBoardOf: anExtent ]) 
		ifFalse: [ self error: self fieldElementsMustBeInsideBoardErrorDescription ]! !

!MineField class methodsFor: 'instance creation' stamp: 'cc 12/11/2023 21:39:13'!
extent: anExtent elements: aCollectionOfFieldElements randomizingWith: aRandom firstTeam: firstTeam secondTeam: aSecondTeam       
	
	self assertIsValidExtent: anExtent.
	self assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent.
	self assertElementsDoNotSharePosition: aCollectionOfFieldElements.
	
	self assertFirstTeam: firstTeam isInBoundsForAndInFirstRow: anExtent andNotUsedBy: aCollectionOfFieldElements.
	self assertSecondTeam: aSecondTeam isInBoundsForAndInLastRow: anExtent andNotUsedBy: aCollectionOfFieldElements.
	
	"no hace falta porque es un chequeo de la creacion del equipo"
	"self assertIsValidNumberOfLives: aNumberOfLives."
	
	"self assertTeamsHaveSameAmountOfLivesFirstTeam: firstTeam secondTeam: aSecondTeam ."
	
	^self new initializeExtent: anExtent 
			elements: aCollectionOfFieldElements 
			randomizingWith: aRandom    
			firstTeam: firstTeam secondTeam: aSecondTeam
! !


!MineField class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:57:25'!
assertFirstTeam: firstTeam isInBoundsForAndInFirstRow: anExtent andNotUsedBy: aCollectionOfFieldElements 
	firstTeam allPlayersAreInBoundsInFirstRow: anExtent andNotUsedBy: aCollectionOfFieldElements.! !

!MineField class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:58:15'!
assertSecondTeam: aSecondTeam isInBoundsForAndInLastRow: anExtent andNotUsedBy: aCollectionOfFieldElements 
	aSecondTeam allPlayersAreInBoundsInLastRow: anExtent andNotUsedBy: aCollectionOfFieldElements.! !

!MineField class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:34:34'!
assertTeamHasValidNumberOfLives: firstTeam 
	firstTeam allPlayersHaveValidLives.! !

!MineField class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:50:31'!
assertTeamsHaveSameAmountOfLivesFirstTeam: firstTeam secondTeam: aSecondTeam 
	(firstTeam totalLives = aSecondTeam totalLives) ifFalse: [ self error: self invalidTeamLivesErrorDescription]! !


!classDefinition: #PlayerTeam category: 'ISW1-2023-2C-2Recuperatorio'!
Object subclass: #PlayerTeam
	instanceVariableNames: 'players originalPlayers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2Recuperatorio'!

!PlayerTeam methodsFor: 'initialization' stamp: 'cc 12/11/2023 19:27:48'!
initializeWithPlayers: aCollectionOfPlayers 

	players := CircularReadStream on: (aCollectionOfPlayers  )moving: NullUnit new.
	originalPlayers := aCollectionOfPlayers .! !


!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 21:09:20'!
advancePlayer
	players next.! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:57:25'!
allPlayersAreInBoundsInFirstRow: anExtent andNotUsedBy: aCollectionOfFieldElements 
	
	originalPlayers do: [ :player | self player: player isInBounds: anExtent.
							self elements: aCollectionOfFieldElements areNotInSamePositionAs: player].
	! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:58:46'!
allPlayersAreInBoundsInLastRow: anExtent andNotUsedBy: aCollectionOfFieldElements 
	originalPlayers do: [ :player | self player: player isInBoundsForLastRow: anExtent.
							self elements: aCollectionOfFieldElements areNotInSamePositionAs: player].! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:34:39'!
allPlayersHaveValidLives
	self shouldBeImplemented.! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:04:25'!
currentPlayer
	^players current! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:44:57'!
elements: aCollectionOfFieldElements areNotInSamePositionAs: player

	^ (aCollectionOfFieldElements anySatisfy: [ :aFieldElement | aFieldElement isAt: player currentPosition ]) 
					ifTrue: [self error: MineField invalidStartingPositionErrorDescription ]! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 20:14:44'!
firstPlayer
	^players current.! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 20:44:04'!
includes: aPlayer 
	^originalPlayers includes: aPlayer.! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 20:23:41'!
movePlayer: aRenameMe1 in: aMineField 
	self shouldBeImplemented.! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:44:35'!
player: player isInBounds: anExtent

	^ (player currentPosition between: 1@1 and: anExtent x @ 1) 
					ifFalse: [self error: MineField invalidStartingPositionErrorDescription ]! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 21:40:22'!
player: player isInBoundsForLastRow: anExtent 
	^ (player currentPosition between: 1 @ anExtent y and: anExtent) 
					ifFalse: [self error: MineField invalidStartingPositionErrorDescription ]! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:55:10'!
players

	^players! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:50:51'!
totalLives
	| totalLives |
	totalLives := 0.
	originalPlayers  do: [:aPlayer | totalLives := totalLives + aPlayer livesLeft ].
	^totalLives ! !

!PlayerTeam methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 19:43:01'!
totalTeamLivesIs: possibleLives
	
	
	| totalLives |
	totalLives := 0.
	originalPlayers  do: [:aPlayer | totalLives := totalLives + aPlayer livesLeft ].
	^possibleLives = totalLives.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerTeam class' category: 'ISW1-2023-2C-2Recuperatorio'!
PlayerTeam class
	instanceVariableNames: ''!


!PlayerTeam class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:10:39'!
invalidPlayerWithInvalidLivesErrorDescription
	^'Cannot start team with player with non integer lives'! !

!PlayerTeam class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:04:51'!
invalidPlayerWithNegativeLives
	^'Cannot start team with a player with negative lives'! !

!PlayerTeam class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:00:11'!
invalidPlayerWithNoLives
	^ 'Cannot start team with not alive players'! !

!PlayerTeam class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:12:37'!
positionsCannotBeTheSameForPlayersErrorDescription
	^' Players must be in different starting positions'! !

!PlayerTeam class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:16:45'!
totalTeamLivesIs: aRenameMe1 
	self shouldBeImplemented.! !

!PlayerTeam class methodsFor: 'as yet unclassified' stamp: 'cc 12/11/2023 18:17:34'!
withPlayers: aCollectionOfPlayers
	aCollectionOfPlayers do: 
	[:aPlayer | (aPlayer livesLeft strictlyPositive and: [ aPlayer livesLeft  isInteger ]) 
			ifFalse: [ self error: self invalidPlayerWithInvalidLivesErrorDescription ]].
		
	aCollectionOfPlayers  combinations: 2 atATimeDo: [ :elements |
		(elements first isSharingPositionWith: elements second) ifTrue: [
			self error: self positionsCannotBeTheSameForPlayersErrorDescription ]].
 	
	^self new initializeWithPlayers: aCollectionOfPlayers .! !
