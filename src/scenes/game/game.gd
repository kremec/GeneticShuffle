extends Control

var cardScene = preload("res://src/objects/card/card.tscn")

var selectedMale: Card
var selectedMaleIndex: int = -1
var selectedFemale: Card
var selectedFemaleIndex: int = -1

var newPup: Card
var newPupSex: Card.Sex = Card.Sex.Male

@onready var listMales = $layout/sidebarMales/listMales
@onready var listFemales = $layout/sidebarFemales/listFemales

@onready var selectedMalePosition = $layout/MarginContainer/selectedMale
@onready var selectedFemalePosition = $layout/MarginContainer/selectedFemale
@onready var newPupPosition = $layout/MarginContainer/newPup
@onready var targetPupPosition = $layout/MarginContainer/targetPup

@onready var btnSpin = $layout/MarginContainer/MarginContainer/btnSpin
@onready var wheelMale = $layout/MarginContainer/MarginContainer/HBoxContainer/wheelMale
@onready var wheelFemale = $layout/MarginContainer/MarginContainer/HBoxContainer/wheelFemale
var maleWheelSpinning: bool = false
var femaleWheelSpinning: bool = false
@export var wheelSpinSpeed: float = 360

func _ready() -> void:
	btnSpin.pressed.connect(_on_btnSpin_pressed)
	round1()

func round1() -> void:
	var allelesShown: Array[bool] = [true, false, false]

	# Starting guinea pigs
	listMales.add_child(
		create_card(
			Card.Sex.Male,
			Allele.AlleleCombo.DominantDominant,
			Allele.AlleleCombo.RecessiveRecessive,
			Allele.AlleleCombo.DominantDominant,
			allelesShown
		)
	)

	listFemales.add_child(
		create_card(
			Card.Sex.Female,
			Allele.AlleleCombo.DominantRecessive,
			Allele.AlleleCombo.RecessiveRecessive,
			Allele.AlleleCombo.DominantDominant,
			allelesShown
		)
	)

	# Target pup
	targetPupPosition.add_child(
		create_card(
			Card.Sex.Male,
			Allele.AlleleCombo.RecessiveRecessive,
			Allele.AlleleCombo.RecessiveRecessive,
			Allele.AlleleCombo.DominantDominant,
			allelesShown,
			false
		)
	)

	# Wheel
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
	pressable: bool = true,
) -> Card:
	var card = cardScene.instantiate()
	card.Init(sex, furLengthAlleles, showAlleles[0], furSwirlsAlleles, showAlleles[1], furColourAlleles, showAlleles[2])
	if pressable:
		card.card_pressed.connect(_on_card_pressed)
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
	if !card.selected: return
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
	if selectedMale == null || selectedFemale == null || maleWheelSpinning || femaleWheelSpinning:
		return
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
	await get_tree().create_timer(2.0).timeout

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

		print(Allele.StringTraitType(traitType), " - Male: ", Allele.StringAlleleType(maleAlleleType), ", Female: ", Allele.StringAlleleType(femaleAlleleType))

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
	print("\n")
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
		false
	)
	newPup.scale = Vector2(0, 0)
	newPupPosition.add_child(newPup)

	# Change sex for next pup
	if newPupSex == Card.Sex.Male:
		newPupSex = Card.Sex.Female
	else:
		newPupSex = Card.Sex.Male
	
	# Scale up
	var newPupTween = get_tree().create_tween()
	newPupTween.tween_property(
		newPup,
		"scale",
		Vector2(2, 2),
		1.0
	)
	newPupTween.finished.connect(_on_newPup_tween_finished)
	unselect_card(selectedMale)
	unselect_card(selectedFemale)
	maleWheelSpinning = false
	femaleWheelSpinning = false

func _on_newPup_tween_finished() -> void:
	await get_tree().create_timer(1.0).timeout
	# Position
	var cardNode = newPup.get_node(".")
	match newPup.sex:
		Card.Sex.Male:
			cardNode.reparent(listMales, false)
		Card.Sex.Female:
			cardNode.reparent(listFemales, false)
	# Connect card_pressed
	newPup.card_pressed.connect(_on_card_pressed)