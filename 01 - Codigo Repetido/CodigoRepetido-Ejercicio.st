!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	
	
	self assert: (self checkIfThisCollaboration: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: (50 * millisecond)).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assert: (self checkIfThisCollaboration: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: (100 * millisecond)).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self evaluate:[ customerBook addCustomerNamed: '']
		mustRaise: Error 
		thenAssert: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self evaluate:[ customerBook removeCustomerNamed: 'Paul McCartney'.]
		mustRaise: NotFound 
		thenAssert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self checkIfThisCustomerBookHas: customerBook activeCustomers: 0 suspendedCustomers: 1 totalCustomers:1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self checkIfThisCustomerBookHas: customerBook activeCustomers: 0 suspendedCustomers: 0 totalCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertIfThisCustomerBook: customerBook withSuspendedCustomer: 'George Harrison' hasThisCustomer:johnLennon.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:55'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertIfThisCustomerBook: customerBook withSuspendedCustomer: johnLennon hasThisCustomer:johnLennon.
	
! !


!CustomerBookTest methodsFor: 'assertions' stamp: 'CJF 9/5/2023 19:20:55'!
assertIfThisCustomerBook: customerBook withSuspendedCustomer: suspendedCustomer hasThisCustomer: anotherCustomer
	
	self evaluate:[ customerBook suspendCustomerNamed: suspendedCustomer.]
		mustRaise: CantSuspend 
		thenAssert: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: anotherCustomer) ]
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'CJF 9/5/2023 19:20:55'!
checkIfThisCollaboration: aBlockClosure takesLessThan: timeInMilliseconds
	
	| millisecondsAfterRunning millisecondsBeforeRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlockClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < (timeInMilliseconds)
	
	
	
	
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'CJF 9/5/2023 19:20:55'!
checkIfThisCustomerBookHas: customerBook activeCustomers: active suspendedCustomers: suspended totalCustomers: total
	
	self assert: active equals: customerBook numberOfActiveCustomers.
	self assert: suspended equals: customerBook numberOfSuspendedCustomers.
	self assert: total equals: customerBook numberOfCustomers.
	

	
! !

!CustomerBookTest methodsFor: 'assertions' stamp: 'CJF 9/5/2023 19:20:55'!
evaluate:collaboration mustRaise: anException thenAssert: collaborationInCaseOfException

	[collaboration value.
	self fail]
		on: anException
		do: (collaborationInCaseOfException).! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:54'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'CJF 9/5/2023 19:20:54'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'CJF 9/5/2023 19:20:54'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:20:55'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:20:55'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:20:54'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:20:55'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 20:05:04'!
remove: aCustomerName from:aListOfCustomers evaluateIfFound: aBlock
	
	(aListOfCustomers includes: aCustomerName ) ifTrue: [ 
			aListOfCustomers remove: aCustomerName.
			^aBlock value.
			]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:58:39'!
removeCustomerNamed: aName 

	self remove: aName from: active evaluateIfFound: [^aName ]. 
 	self remove: aName from: suspended evaluateIfFound: [^aName ].

	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:20:54'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:20:54'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'CJF 9/5/2023 19:20:55'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'CJF 9/5/2023 19:20:55'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'CJF 9/5/2023 19:20:55'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
