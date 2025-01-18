extends Control

var cardScene = preload("res://src/objects/card/card.tscn")

var selectedMale: Card
var selectedMaleIndex: int = -1

var selectedFemale: Card
var selectedFemaleIndex: int = -1

var targetAlleles: Array[Allele.AlleleCombo]

var newPup: Card
var newPupSex: Card.Sex

@onready var listMales = $layout/sidebarMales/listMales
var numberAllMales: int = 0
@onready var listFemales = $layout/sidebarFemales/listFemales
var numberAllFemales: int = 0

@onready var selectedMalePosition = $layout/MarginContainer/selectedMale
@onready var selectedFemalePosition = $layout/MarginContainer/selectedFemale
@onready var popupNewPupPosition = $popupNewPup
@onready var newPupPosition = $layout/MarginContainer/HBoxContainer/newPup
@onready var targetPupPosition = $layout/MarginContainer/HBoxContainer/targetPup

@onready var btnSpin = $layout/MarginContainer/MarginContainer/btnSpin
@onready var wheelMale = $layout/MarginContainer/MarginContainer/HBoxContainer/wheelMale
@onready var wheelFemale = $layout/MarginContainer/MarginContainer/HBoxContainer/wheelFemale
var canWheelSpin: bool = true
var maleWheelSpinning: bool = false
var femaleWheelSpinning: bool = false
@export var wheelSpinSpeed: float = 360
@export var afterWheelSpinPause: float = 0.5
@export var newPupPresentPause: float = 0.5

@onready var alleleInfos = $layout/MarginContainer/HBoxContainer/AlleleInfos
@onready var alleleInfoLeft = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft
@onready var alleleInfoRight = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight
@onready var alleleInfo1 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo1
@onready var alleleInfo2 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo2
@onready var alleleInfo3 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3
@onready var alleleInfo1DominantImage = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo1/alleleInfo1Panel/alleleInfo1Dominant/alleleInfo1DominantImage
@onready var alleleInfo1DominantLabel = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo1/alleleInfo1Panel/alleleInfo1Dominant/alleleInfo1DominantLabel
@onready var alleleInfo1RecessiveImage = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo1/alleleInfo1Panel/alleleInfo1Recessive/alleleInfo1RecessiveImage
@onready var alleleInfo1RecessiveLabel = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo1/alleleInfo1Panel/alleleInfo1Recessive/alleleInfo1RecessiveLabel
@onready var alleleInfo2DominantImage = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo2/alleleInfo2Panel/alleleInfo2Dominant/alleleInfo2DominantImage
@onready var alleleInfo2DominantLabel = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo2/alleleInfo2Panel/alleleInfo2Dominant/alleleInfo2DominantLabel
@onready var alleleInfo2RecessiveImage = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo2/alleleInfo2Panel/alleleInfo2Recessive/alleleInfo2RecessiveImage
@onready var alleleInfo2RecessiveLabel = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoLeft/alleleInfo2/alleleInfo2Panel/alleleInfo2Recessive/alleleInfo2RecessiveLabel
@onready var alleleInfo3DominantDominantImage1 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3DominantDominant/alleleInfo3DominantDominantImage1
@onready var alleleInfo3DominantDominantImage2 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3DominantDominant/alleleInfo3DominantDominantImage2
@onready var alleleInfo3DominantDominantLabel = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3DominantDominant/alleleInfo3DominantDominantLabel
@onready var alleleInfo3DominantRecessiveImage1 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3DominantRecessive/alleleInfo3DominantRecessiveImage1
@onready var alleleInfo3DominantRecessiveImage2 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3DominantRecessive/alleleInfo3DominantRecessiveImage2
@onready var alleleInfo3DominantRecessiveLabel = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3DominantRecessive/alleleInfo3DominantRecessiveLabel
@onready var alleleInfo3RecessiveRecessiveImage1 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3RecessiveRecessive/alleleInfo3RecessiveRecessiveImage1
@onready var alleleInfo3RecessiveRecessiveImage2 = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3RecessiveRecessive/alleleInfo3RecessiveRecessiveImage2
@onready var alleleInfo3RecessiveRecessiveLabel = $layout/MarginContainer/HBoxContainer/AlleleInfos/AlleleInfoRight/alleleInfo3/alleleInfo3Panel/alleleInfo3RecessiveRecessive/alleleInfo3RecessiveRecessiveLabel

@onready var level: Label = $layout/MarginContainer/level

func _ready() -> void:
	btnSpin.pressed.connect(_on_btnSpin_pressed)
	loadRound()

var currentRound: int = 1
func loadRound():
	level.text = "Level " + str(currentRound)
	if currentRound == 1:
		round1()
	elif currentRound == 2:
		round2()
	elif currentRound == 3:
		round3()
	elif currentRound == 4:
		round4()
	elif currentRound == 5:
		round5()
	else:
		get_tree().change_scene_to_file("res://src/scenes/main_menu/main_menu.tscn")

func round1() -> void:
	var allelesShown: Array[bool] = [true, false, false]
	startRound(allelesShown)

func round2() -> void:
	var allelesShown: Array[bool] = [false, true, false]
	startRound(allelesShown)

func round3() -> void:
	var allelesShown: Array[bool] = [false, false, true]
	startRound(allelesShown)

func round4() -> void:
	var allelesShown: Array[bool] = [true, true, false]
	startRound(allelesShown)

func round5() -> void:
	var allelesShown: Array[bool] = [true, true, true]
	startRound(allelesShown)

func startRound(allelesShown: Array[bool]):
	canWheelSpin = true
	numberAllMales = 0
	numberAllFemales = 0
	selectedMale = null
	selectedFemale = null
	for n in listMales.get_children(): n.queue_free()
	for n in listFemales.get_children(): n.queue_free()
	for n in selectedMalePosition.get_children(): n.queue_free()
	for n in selectedFemalePosition.get_children(): n.queue_free()
	for n in popupNewPupPosition.get_children(): n.queue_free()
	for n in newPupPosition.get_children(): n.queue_free()
	for n in targetPupPosition.get_children(): n.queue_free()

	# Random new pup sex
	newPupSex = [Card.Sex.Male, Card.Sex.Female][randi_range(0, 1)]

	# Allele infos
	setAlleleInfos(allelesShown)

	# Generate random alleles
	var allAlleleCombos: Array[Allele.AlleleCombo] = [Allele.AlleleCombo.DominantDominant, Allele.AlleleCombo.DominantRecessive, Allele.AlleleCombo.RecessiveRecessive]
	var defaultAlleles = [Allele.GetRandomAlleleCombo(allAlleleCombos), Allele.GetRandomAlleleCombo(allAlleleCombos), Allele.GetRandomAlleleCombo(allAlleleCombos)]
	var randomAllelesLength = Allele.GenerateRandomAlleles()
	var randomAllelesSwirls = Allele.GenerateRandomAlleles()
	var randomAllelesColor = Allele.GenerateRandomAlleles()

	# Starting guinea pigs
	var male = create_card(
		Card.Sex.Male,
		randomAllelesLength[1] if allelesShown[0] else defaultAlleles[0],
		randomAllelesSwirls[1] if allelesShown[1] else defaultAlleles[1],
		randomAllelesColor[1] if allelesShown[2] else defaultAlleles[2],
		allelesShown
	)
	male.card_pressed.connect(_on_card_pressed)
	listMales.add_child(male)

	var female = create_card(
		Card.Sex.Female,
		randomAllelesLength[2] if allelesShown[0] else defaultAlleles[0],
		randomAllelesSwirls[2] if allelesShown[1] else defaultAlleles[1],
		randomAllelesColor[2] if allelesShown[2] else defaultAlleles[2],
		allelesShown
	)
	female.card_pressed.connect(_on_card_pressed)
	listFemales.add_child(female)

	# Target alleles
	targetAlleles = [
		randomAllelesLength[0] if allelesShown[0] else defaultAlleles[0],
		randomAllelesSwirls[0] if allelesShown[1] else defaultAlleles[1],
		randomAllelesColor[0] if allelesShown[2] else defaultAlleles[2]
	]

	# Target pup
	targetPupPosition.add_child(
		create_card(
			Card.Sex.Male,
			targetAlleles[0] if allelesShown[0] else defaultAlleles[0],
			targetAlleles[1] if allelesShown[1] else defaultAlleles[1],
			targetAlleles[2] if allelesShown[2] else defaultAlleles[2],
			allelesShown,
			false,
			false
		)
	)

	# Wheel
	resetWheels(allelesShown)

func setAlleleInfos(allelesShown: Array[bool]):
	alleleInfoLeft.visible = true
	alleleInfoRight.visible = true
	alleleInfo1.visible = true
	alleleInfo2.visible = true
	alleleInfo3.visible = true
	match allelesShown.count(true):
		1:
			if allelesShown[0]:
				alleleInfo1DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["image"]
				alleleInfo1DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["label"]
				alleleInfo1RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["image"]
				alleleInfo1RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["label"]
				alleleInfo2.visible = false
				alleleInfoRight.visible = false
			elif allelesShown[1]:
				alleleInfo1DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["image"]
				alleleInfo1DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["label"]
				alleleInfo1RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["image"]
				alleleInfo1RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["label"]
				alleleInfo2.visible = false
				alleleInfoRight.visible = false
			elif allelesShown[2]:
				alleleInfo3DominantDominantImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["image1"]
				alleleInfo3DominantDominantImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["image2"]
				alleleInfo3DominantDominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["label"]
				alleleInfo3DominantRecessiveImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["image1"]
				alleleInfo3DominantRecessiveImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["image2"]
				alleleInfo3DominantRecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["label"]
				alleleInfo3RecessiveRecessiveImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["image1"]
				alleleInfo3RecessiveRecessiveImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["image2"]
				alleleInfo3RecessiveRecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["label"]
				alleleInfoLeft.visible = false
			
		2:
			if allelesShown[2]:
				alleleInfo3DominantDominantImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["image1"]
				alleleInfo3DominantDominantImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["image2"]
				alleleInfo3DominantDominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["label"]
				alleleInfo3DominantRecessiveImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["image1"]
				alleleInfo3DominantRecessiveImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["image2"]
				alleleInfo3DominantRecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["label"]
				alleleInfo3RecessiveRecessiveImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["image1"]
				alleleInfo3RecessiveRecessiveImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["image2"]
				alleleInfo3RecessiveRecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["label"]
				if allelesShown[0]:
					alleleInfo1DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["image"]
					alleleInfo1DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["label"]
					alleleInfo1RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["image"]
					alleleInfo1RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["label"]
				elif allelesShown[1]:
					alleleInfo1DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["image"]
					alleleInfo1DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["label"]
					alleleInfo1RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["image"]
					alleleInfo1RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["label"]
				alleleInfo2.visible = false
			else:
				alleleInfo1DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["image"]
				alleleInfo1DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["label"]
				alleleInfo1RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["image"]
				alleleInfo1RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["label"]
				alleleInfo2DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["image"]
				alleleInfo2DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["label"]
				alleleInfo2RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["image"]
				alleleInfo2RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["label"]
				alleleInfoRight.visible = false

		3:
			alleleInfo1DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["image"]
			alleleInfo1DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Dominant]["label"]
			alleleInfo1RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["image"]
			alleleInfo1RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Length][Allele.AlleleType.Recessive]["label"]
			alleleInfo2DominantImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["image"]
			alleleInfo2DominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Dominant]["label"]
			alleleInfo2RecessiveImage.texture = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["image"]
			alleleInfo2RecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Swirls][Allele.AlleleType.Recessive]["label"]
			alleleInfo3DominantDominantImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["image1"]
			alleleInfo3DominantDominantImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["image2"]
			alleleInfo3DominantDominantLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantDominant]["label"]
			alleleInfo3DominantRecessiveImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["image1"]
			alleleInfo3DominantRecessiveImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["image2"]
			alleleInfo3DominantRecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.DominantRecessive]["label"]
			alleleInfo3RecessiveRecessiveImage1.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["image1"]
			alleleInfo3RecessiveRecessiveImage2.texture = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["image2"]
			alleleInfo3RecessiveRecessiveLabel.text = Allele.AlleleInfo[Allele.TraitType.Color][Allele.AlleleCombo.RecessiveRecessive]["label"]

func resetWheels(allelesShown: Array[bool]):
	wheelMale.ResetAlleles()
	wheelFemale.ResetAlleles()

	var wheelType: Wheel.WheelType
	var numAllelesShown = allelesShown.count(true)
	if numAllelesShown == 1:
		wheelType = Wheel.WheelType.Wheel2
	elif numAllelesShown == 2:
		wheelType = Wheel.WheelType.Wheel4
	else:
		wheelType = Wheel.WheelType.Wheel8
	wheelMale.Init(wheelType)
	wheelFemale.Init(wheelType)

func create_card(
	sex: Card.Sex,
	furLengthAlleles: Allele.AlleleCombo,
	furSwirlsAlleles: Allele.AlleleCombo,
	furColourAlleles: Allele.AlleleCombo,
	showAlleles: Array[bool] = [false, false, false],
	clickable: bool = true,
	increaseNumber: bool = true,
) -> Card:
	if increaseNumber:
		match sex:
			Card.Sex.Male:
				numberAllMales += 1
			Card.Sex.Female:
				numberAllFemales += 1
	
	var card = cardScene.instantiate()
	card.Init(
		sex,
		furLengthAlleles,
		showAlleles[0],
		furSwirlsAlleles,
		showAlleles[1],
		furColourAlleles,
		showAlleles[2],
		numberAllMales if sex == Card.Sex.Male else numberAllFemales,
		clickable
	)
	
	
	return card

func _on_card_pressed(card: Card) -> void:
	if card.selected:
		unselect_card(card)
	else:
		select_card(card)

func select_card(card: Card):
	if card.selected: return
	if card.sex == Card.Sex.Male && selectedMale != null: return
	if card.sex == Card.Sex.Female && selectedFemale != null: return

	# Properties
	card.selected = true
	match card.sex:
		Card.Sex.Male:
			selectedMale = card
			selectedMaleIndex = card.get_index()
		Card.Sex.Female:
			selectedFemale = card
			selectedFemaleIndex = card.get_index()
	# Position
	var cardNode = card.get_node(".")
	match card.sex:
		Card.Sex.Male:
			cardNode.reparent(selectedMalePosition, false)
			wheelMale.SetAlleles(card)
		Card.Sex.Female:
			cardNode.reparent(selectedFemalePosition, false)
			wheelFemale.SetAlleles(card)
	cardNode.set_position(Vector2(0, 0))

func unselect_card(card: Card):
	if !card.selected || !canWheelSpin: return
	if card.sex == Card.Sex.Male && selectedMale == null: return
	if card.sex == Card.Sex.Female && selectedFemale == null: return
	# Position
	var cardNode = card.get_node(".")
	match card.sex:
		Card.Sex.Male:
			cardNode.reparent(listMales, false)
			listMales.move_child(cardNode, selectedMaleIndex)
			wheelMale.ResetAlleles()
		Card.Sex.Female:
			cardNode.reparent(listFemales, false)
			listFemales.move_child(cardNode, selectedFemaleIndex)
			wheelFemale.ResetAlleles()
	# Properties
	card.selected = false
	match card.sex:
		Card.Sex.Male:
			selectedMale = null
			selectedMaleIndex = -1
		Card.Sex.Female:
			selectedFemale = null
			selectedFemaleIndex = -1

func _on_btnSpin_pressed() -> void:
	wheelsSpin()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ENTER && event.pressed && !event.is_echo():
			wheelsSpin()

func wheelsSpin() -> void:
	if selectedMale == null || selectedFemale == null || maleWheelSpinning || femaleWheelSpinning || !canWheelSpin:
		return
	canWheelSpin = false
	maleWheelSpinning = true
	femaleWheelSpinning = true

	var maleRotation = wheelMale.Spin()
	var femaleRotation = wheelFemale.Spin()

	maleRotation.finished.connect(_on_male_tween_finished)
	femaleRotation.finished.connect(_on_female_tween_finished)

func _on_male_tween_finished() -> void:
	maleWheelSpinning = false
	if !femaleWheelSpinning:
		afterWheelsSpin()

func _on_female_tween_finished() -> void:
	femaleWheelSpinning = false
	if !maleWheelSpinning:
		afterWheelsSpin()
	
func afterWheelsSpin():
	# Wait
	await get_tree().create_timer(afterWheelSpinPause).timeout

	# Get alleles from wheels
	var pupLengthAlleles = null
	var pupSwirlsAlleles = null
	var pupColorAlleles = null
	var maleAlleles = wheelMale.GetAlleles()
	var femaleAlleles = wheelFemale.GetAlleles()
	for i in range(len(maleAlleles)):
		assert(maleAlleles[i][0] == femaleAlleles[i][0]) # Same trait type
		var traitType: Allele.TraitType = maleAlleles[i][0]
		var maleAlleleType: Allele.AlleleType = maleAlleles[i][1]
		var femaleAlleleType: Allele.AlleleType = femaleAlleles[i][1]

		var alleleCombo: Allele.AlleleCombo
		if maleAlleleType == Allele.AlleleType.Dominant && femaleAlleleType == Allele.AlleleType.Dominant:
			alleleCombo = Allele.AlleleCombo.DominantDominant
		elif maleAlleleType == Allele.AlleleType.Recessive && femaleAlleleType == Allele.AlleleType.Recessive:
			alleleCombo = Allele.AlleleCombo.RecessiveRecessive
		else:
			alleleCombo = Allele.AlleleCombo.DominantRecessive
		
		match traitType:
			Allele.TraitType.Length:
				pupLengthAlleles = alleleCombo
			Allele.TraitType.Swirls:
				pupSwirlsAlleles = alleleCombo
			Allele.TraitType.Color:
				pupColorAlleles = alleleCombo
	
	if pupLengthAlleles == null:
		pupLengthAlleles = selectedMale.furLengthAlleles
	if pupSwirlsAlleles == null:
		pupSwirlsAlleles = selectedMale.furSwirlsAlleles
	if pupColorAlleles == null:
		pupColorAlleles = selectedMale.furColorAlleles

	# Create
	newPup = create_card(
		newPupSex,
		pupLengthAlleles,
		pupSwirlsAlleles,
		pupColorAlleles,
		[selectedMale.showFurLengthAlleles, selectedMale.showFurSwirlsAlleles, selectedMale.showFurColorAlleles],
	)
	await get_tree().process_frame
	newPup.scale = Vector2(0, 0)
	popupNewPupPosition.add_child(newPup)

	# Change sex for next pup
	if newPupSex == Card.Sex.Male:
		newPupSex = Card.Sex.Female
	else:
		newPupSex = Card.Sex.Male
	
	# Scale up
	var newPupScaleTween = get_tree().create_tween()
	newPupScaleTween.tween_property(
		newPup,
		"scale",
		Vector2(2, 2),
		1.0
	)
	newPupScaleTween.finished.connect(_onNewPupPresent)

func _onNewPupPresent():
	# Timeout
	await get_tree().create_timer(newPupPresentPause).timeout

	# If pup is the target start new round
	if newPup.furLengthAlleles == targetAlleles[0] && newPup.furSwirlsAlleles == targetAlleles[1] && newPup.furColorAlleles == targetAlleles[2]:
		currentRound += 1
		loadRound()
		return

	# Position
	var newPupPositionTween = get_tree().create_tween()
	newPupPositionTween.tween_property(
		newPup,
		"global_position",
		newPupPosition.global_position,
		0.5
	)
	# Scale
	var newPupScaleTween = get_tree().create_tween()
	newPupScaleTween.tween_property(
		newPup,
		"scale",
		Vector2(1.0, 1.0),
		0.5
	)

	newPupPositionTween.finished.connect(_onNewPupRepositioned)

func _onNewPupRepositioned():
	newPup.card_pressed.connect(_onNewPupClicked)

func _onNewPupClicked(_card: Card):
	newPup.card_pressed.disconnect(_onNewPupClicked)
	# Reparent new pup into correct list
	var cardNode = newPup.get_node(".")
	match newPup.sex:
		Card.Sex.Male:
			cardNode.reparent(listMales, false)
		Card.Sex.Female:
			cardNode.reparent(listFemales, false)
	
	# Connect card_pressed
	newPup.card_pressed.connect(_on_card_pressed)

	# Unselect parents
	canWheelSpin = true
	unselect_card(selectedMale)
	unselect_card(selectedFemale)
