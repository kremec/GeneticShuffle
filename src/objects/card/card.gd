extends Control
class_name Card

signal card_pressed

enum Sex {
	Male,
	Female
}


@onready var button = $button
@onready var image = $button/image
@onready var lengthAllele1 = $button/HBoxContainer/allelesLength/lengthAllele1
@onready var lengthAllele2 = $button/HBoxContainer/allelesLength/lengthAllele2
@onready var swirlsAllele1 = $button/HBoxContainer/allelesSwirls/swirlsAllele1
@onready var swirlsAllele2 = $button/HBoxContainer/allelesSwirls/swirlsAllele2
@onready var colorAllele1 = $button/HBoxContainer/allelesColor/colorAllele1
@onready var colorAllele2 = $button/HBoxContainer/allelesColor/colorAllele1

@export var selected: bool

@export var sex: Sex

@export var furLength: Allele.FurLength
@export var furLengthAlleles: Allele.AlleleCombo
@export var showFurLengthAlleles: bool

@export var furSwirls: Allele.FurSwirls
@export var furSwirlsAlleles: Allele.AlleleCombo
@export var showFurSwirlsAlleles: bool

@export var furColor: Allele.FurColor
@export var furColorAlleles: Allele.AlleleCombo
@export var showFurColorAlleles: bool

func _ready() -> void:
	# Guinea pig image
	image.texture = GetImageTexture()
	if sex == Sex.Male:
		image.flip_h = true

	# Allele images
	var alleleImages = GetAlleleImages()
	lengthAllele1.texture = alleleImages[0]
	lengthAllele2.texture = alleleImages[1]
	swirlsAllele1.texture = alleleImages[2]
	swirlsAllele2.texture = alleleImages[3]
	colorAllele1.texture = alleleImages[4]
	colorAllele2.texture = alleleImages[5]

	# Button signal
	button.pressed.connect(_on_button_pressed)

func GetImageTexture() -> Resource:
	match furLength:
		Allele.FurLength.Short:
			match furSwirls:
				Allele.FurSwirls.Swirls:
					match furColor:
						Allele.FurColor.Yellow:
							return load("res://assets/guinea_pig/short-swirls-yellow.png")
						Allele.FurColor.Cream:
							return load("res://assets/guinea_pig/short-swirls-cream.png")
						Allele.FurColor.White:
							return load("res://assets/guinea_pig/short-swirls-white.png")
				Allele.FurSwirls.NoSwirls:
					match furColor:
						Allele.FurColor.Yellow:
							return load("res://assets/guinea_pig/short-noswirls-yellow.png")
						Allele.FurColor.Cream:
							return load("res://assets/guinea_pig/short-noswirls-cream.png")
						Allele.FurColor.White:
							return load("res://assets/guinea_pig/short-noswirls-white.png")
		Allele.FurLength.Long:
			match furSwirls:
				Allele.FurSwirls.Swirls:
					match furColor:
						Allele.FurColor.Yellow:
							return load("res://assets/guinea_pig/long-swirls-yellow.png")
						Allele.FurColor.Cream:
							return load("res://assets/guinea_pig/long-swirls-cream.png")
						Allele.FurColor.White:
							return load("res://assets/guinea_pig/long-swirls-white.png")
				Allele.FurSwirls.NoSwirls:
					match furColor:
						Allele.FurColor.Yellow:
							return load("res://assets/guinea_pig/long-noswirls-yellow.png")
						Allele.FurColor.Cream:
							return load("res://assets/guinea_pig/long-noswirls-cream.png")
						Allele.FurColor.White:
							return load("res://assets/guinea_pig/long-noswirls-white.png")
	return null

func GetAlleleImages() -> Array[Resource]:
	var lengthAlleleImage1: Resource
	var lengthAlleleImage2: Resource
	var swirlsAlleleImage1: Resource
	var swirlsAlleleImage2: Resource
	var colorAlleleImage1: Resource
	var colorAlleleImage2: Resource
	if showFurLengthAlleles:
		match furLengthAlleles:
			Allele.AlleleCombo.DominantDominant:
				lengthAlleleImage1 = load("res://assets/alleles/lengthDominant.png")
				lengthAlleleImage2 = load("res://assets/alleles/lengthDominant.png")
			Allele.AlleleCombo.DominantRecessive:
				lengthAlleleImage1 = load("res://assets/alleles/lengthDominant.png")
				lengthAlleleImage2 = load("res://assets/alleles/lengthRecessive.png")
			Allele.AlleleCombo.RecessiveRecessive:
				lengthAlleleImage1 = load("res://assets/alleles/lengthRecessive.png")
				lengthAlleleImage2 = load("res://assets/alleles/lengthRecessive.png")
	
	if showFurSwirlsAlleles:
		match furSwirlsAlleles:
			Allele.AlleleCombo.DominantDominant:
				swirlsAlleleImage1 = load("res://assets/alleles/swirlsDominant.png")
				swirlsAlleleImage2 = load("res://assets/alleles/swirlsDominant.png")
			Allele.AlleleCombo.DominantRecessive:
				swirlsAlleleImage1 = load("res://assets/alleles/swirlsDominant.png")
				swirlsAlleleImage2 = load("res://assets/alleles/swirlsRecessive.png")
			Allele.AlleleCombo.RecessiveRecessive:
				swirlsAlleleImage1 = load("res://assets/alleles/swirlsRecessive.png")
				swirlsAlleleImage2 = load("res://assets/alleles/swirlsRecessive.png")

	if showFurColorAlleles:
		match furColorAlleles:
			Allele.AlleleCombo.DominantDominant:
				colorAlleleImage1 = load("res://assets/alleles/colorYellow.png")
				colorAlleleImage2 = load("res://assets/alleles/colorYellow.png")
			Allele.AlleleCombo.DominantRecessive:
				colorAlleleImage1 = load("res://assets/alleles/colorYellow.png")
				colorAlleleImage2 = load("res://assets/alleles/colorWhite.png")
			Allele.AlleleCombo.RecessiveRecessive:
				colorAlleleImage1 = load("res://assets/alleles/colorWhite.png")
				colorAlleleImage2 = load("res://assets/alleles/colorWhite.png")
	
	return [lengthAlleleImage1, lengthAlleleImage2, swirlsAlleleImage1, swirlsAlleleImage2, colorAlleleImage1, colorAlleleImage2]

func _on_button_pressed() -> void:
	card_pressed.emit(self)

func Init(
	_sex: Sex,
	_furLengthAlleles: Allele.AlleleCombo,
	_showFurLengthAlleles: bool,
	_furSwirlsAlleles: Allele.AlleleCombo,
	_showFurSwirlsAlleles: bool,
	_furColourAlleles: Allele.AlleleCombo,
	_showFurColourAlleles: bool
) -> void:
	sex = _sex
	furLengthAlleles = _furLengthAlleles
	showFurLengthAlleles = _showFurLengthAlleles
	furSwirlsAlleles = _furSwirlsAlleles
	showFurSwirlsAlleles = _showFurSwirlsAlleles
	furColorAlleles = _furColourAlleles
	showFurColorAlleles = _showFurColourAlleles
	
	furLength = Allele.GetFurLength(furLengthAlleles)
	furSwirls = Allele.GetFurSwirls(furSwirlsAlleles)
	furColor = Allele.GetFurColor(furColorAlleles)
