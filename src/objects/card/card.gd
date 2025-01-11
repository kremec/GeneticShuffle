extends BoxContainer
class_name Card

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

@onready var image = $button/image
@export var sex: Sex
@export var furLength: FurLength
@export var furLengthAlleles: Alleles
@export var furSwirls: FurSwirls
@export var furSwirlsAlleles: Alleles
@export var furColour: FurColour
@export var furColourAlleles: Alleles

func _ready() -> void:
	image.texture = GetImageTexture()
	if sex == Sex.Male:
		image.flip_h = true

func Init(_sex: Sex, _furLengthAlleles: Alleles, _furSwirlsAlleles: Alleles, _furColourAlleles: Alleles) -> void:
	sex = _sex
	furLengthAlleles = _furLengthAlleles
	furSwirlsAlleles = _furSwirlsAlleles
	furColourAlleles = _furColourAlleles
	
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

func GetImageTexture() -> Texture2D:
	var texture: Texture2D
	match furLength:
		FurLength.Short:
			match furSwirls:
				FurSwirls.Swirls:
					match furColour:
						FurColour.Yellow:
							texture = load("res://assets/guinea_pig/short-swirls-yellow.png")
						FurColour.Cream:
							texture = load("res://assets/guinea_pig/short-swirls-cream.png")
						FurColour.White:
							texture = load("res://assets/guinea_pig/short-swirls-white.png")
				FurSwirls.NoSwirls:
					match furColour:
						FurColour.Yellow:
							texture = load("res://assets/guinea_pig/short-noswirls-yellow.png")
						FurColour.Cream:
							texture = load("res://assets/guinea_pig/short-noswirls-cream.png")
						FurColour.White:
							texture = load("res://assets/guinea_pig/short-noswirls-white.png")
		FurLength.Long:
			match furSwirls:
				FurSwirls.Swirls:
					match furColour:
						FurColour.Yellow:
							texture = load("res://assets/guinea_pig/long-swirls-yellow.png")
						FurColour.Cream:
							texture = load("res://assets/guinea_pig/long-swirls-cream.png")
						FurColour.White:
							texture = load("res://assets/guinea_pig/long-swirls-white.png")
				FurSwirls.NoSwirls:
					match furColour:
						FurColour.Yellow:
							texture = load("res://assets/guinea_pig/long-noswirls-yellow.png")
						FurColour.Cream:
							texture = load("res://assets/guinea_pig/long-noswirls-cream.png")
						FurColour.White:
							texture = load("res://assets/guinea_pig/long-noswirls-white.png")
	return texture