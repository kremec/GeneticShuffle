extends Control
class_name Card

signal card_pressed

enum Sex {
	Male,
	Female
}
enum FurLength {
	Long,
	Short
}
enum FurSwirls {
	Swirls,
	NoSwirls
}
enum FurColour {
	Yellow,
	Cream,
	White
}
enum Alleles {
	DominantDominant,
	DominantRecessive,
	RecessiveRecessive
}

@onready var button = $button
@onready var image = $button/image
@onready var lengthAllele1 = $button/HBoxContainer/allelesLength/lengthAllele1
@onready var lengthAllele2 = $button/HBoxContainer/allelesLength/lengthAllele2
@onready var swirlsAllele1 = $button/HBoxContainer/allelesSwirls/swirlsAllele1
@onready var swirlsAllele2 = $button/HBoxContainer/allelesSwirls/swirlsAllele2
@onready var colourAllele1 = $button/HBoxContainer/allelesColor/colorAllele1
@onready var colourAllele2 = $button/HBoxContainer/allelesColor/colorAllele1

@export var selected: bool

@export var sex: Sex

@export var furLength: FurLength
@export var furLengthAlleles: Alleles
@export var showFurLengthAlleles: bool

@export var furSwirls: FurSwirls
@export var furSwirlsAlleles: Alleles
@export var showFurSwirlsAlleles: bool

@export var furColour: FurColour
@export var furColourAlleles: Alleles
@export var showFurColourAlleles: bool

func _ready() -> void:
	# Guinea pig image
	SetImageTexture()
	if sex == Sex.Male:
		image.flip_h = true

	# Allele images
	SetAlleleTextures()

	# Button signal
	button.pressed.connect(_on_button_pressed)

func SetImageTexture():
	match furLength:
		FurLength.Short:
			match furSwirls:
				FurSwirls.Swirls:
					match furColour:
						FurColour.Yellow:
							image.texture = load("res://assets/guinea_pig/short-swirls-yellow.png")
						FurColour.Cream:
							image.texture = load("res://assets/guinea_pig/short-swirls-cream.png")
						FurColour.White:
							image.texture = load("res://assets/guinea_pig/short-swirls-white.png")
				FurSwirls.NoSwirls:
					match furColour:
						FurColour.Yellow:
							image.texture = load("res://assets/guinea_pig/short-noswirls-yellow.png")
						FurColour.Cream:
							image.texture = load("res://assets/guinea_pig/short-noswirls-cream.png")
						FurColour.White:
							image.texture = load("res://assets/guinea_pig/short-noswirls-white.png")
		FurLength.Long:
			match furSwirls:
				FurSwirls.Swirls:
					match furColour:
						FurColour.Yellow:
							image.texture = load("res://assets/guinea_pig/long-swirls-yellow.png")
						FurColour.Cream:
							image.texture = load("res://assets/guinea_pig/long-swirls-cream.png")
						FurColour.White:
							image.texture = load("res://assets/guinea_pig/long-swirls-white.png")
				FurSwirls.NoSwirls:
					match furColour:
						FurColour.Yellow:
							image.texture = load("res://assets/guinea_pig/long-noswirls-yellow.png")
						FurColour.Cream:
							image.texture = load("res://assets/guinea_pig/long-noswirls-cream.png")
						FurColour.White:
							image.texture = load("res://assets/guinea_pig/long-noswirls-white.png")

func SetAlleleTextures():
	if showFurLengthAlleles:
		match furLengthAlleles:
			Alleles.DominantDominant:
				lengthAllele1.texture = load("res://assets/alleles/lengthDominant.png")
				lengthAllele2.texture = load("res://assets/alleles/lengthDominant.png")
			Alleles.DominantRecessive:
				lengthAllele1.texture = load("res://assets/alleles/lengthDominant.png")
				lengthAllele2.texture = load("res://assets/alleles/lengthRecessive.png")
			Alleles.RecessiveRecessive:
				lengthAllele1.texture = load("res://assets/alleles/lengthRecessive.png")
				lengthAllele2.texture = load("res://assets/alleles/lengthRecessive.png")
	
	if showFurSwirlsAlleles:
		match furSwirlsAlleles:
			Alleles.DominantDominant:
				swirlsAllele1.texture = load("res://assets/alleles/swirlsDominant.png")
				swirlsAllele2.texture = load("res://assets/alleles/swirlsDominant.png")
			Alleles.DominantRecessive:
				swirlsAllele1.texture = load("res://assets/alleles/swirlsDominant.png")
				swirlsAllele2.texture = load("res://assets/alleles/swirlsRecessive.png")
			Alleles.RecessiveRecessive:
				swirlsAllele1.texture = load("res://assets/alleles/swirlsRecessive.png")
				swirlsAllele2.texture = load("res://assets/alleles/swirlsRecessive.png")

	if showFurColourAlleles:
		match furColourAlleles:
			Alleles.DominantDominant:
				colourAllele1.texture = load("res://assets/alleles/colorYellow.png")
				colourAllele2.texture = load("res://assets/alleles/colorYellow.png")
			Alleles.DominantRecessive:
				colourAllele1.texture = load("res://assets/alleles/colorYellow.png")
				colourAllele2.texture = load("res://assets/alleles/colorWhite.png")
			Alleles.RecessiveRecessive:
				colourAllele1.texture = load("res://assets/alleles/colorWhite.png")
				colourAllele2.texture = load("res://assets/alleles/colorWhite.png")

func _on_button_pressed() -> void:
	card_pressed.emit(self)

func Init(
	_sex: Sex,
	_furLengthAlleles: Alleles,
	_showFurLengthAlleles: bool,
	_furSwirlsAlleles: Alleles,
	_showFurSwirlsAlleles: bool,
	_furColourAlleles: Alleles,
	_showFurColourAlleles: bool
) -> void:
	sex = _sex
	furLengthAlleles = _furLengthAlleles
	showFurLengthAlleles = _showFurLengthAlleles
	furSwirlsAlleles = _furSwirlsAlleles
	showFurSwirlsAlleles = _showFurSwirlsAlleles
	furColourAlleles = _furColourAlleles
	showFurColourAlleles = _showFurColourAlleles
	
	# Short - dominant, Long - recessive
	match _furLengthAlleles:
		Alleles.DominantDominant:
			furLength = FurLength.Short
		Alleles.DominantRecessive:
			furLength = FurLength.Short
		Alleles.RecessiveRecessive:
			furLength = FurLength.Long
	
	# Swirls - dominant, No swirls - recessive
	match _furSwirlsAlleles:
		Alleles.DominantDominant:
			furSwirls = FurSwirls.Swirls
		Alleles.DominantRecessive:
			furSwirls = FurSwirls.Swirls
		Alleles.RecessiveRecessive:
			furSwirls = FurSwirls.NoSwirls

	# Yellow - dominant, White - recessive
	match _furColourAlleles:
		Alleles.DominantDominant:
			furColour = FurColour.Yellow
		Alleles.DominantRecessive:
			furColour = FurColour.Cream
		Alleles.RecessiveRecessive:
			furColour = FurColour.White