extends Control
class_name Wheel

enum WheelType {
	Wheel2,
	Wheel4,
	Wheel8,
}

@export var wheelSpinSpeed: float = 360

var wheelType: WheelType

var wheel2Image = preload("res://assets/wheel/wheel_2.png")
var wheel4Image = preload("res://assets/wheel/wheel_4.png")
var wheel8Image = preload("res://assets/wheel/wheel_8.png")

var lengthDominantImage = preload("res://assets/alleles/lengthDominant.png")
var lengthRecessiveImage = preload("res://assets/alleles/lengthRecessive.png")
var swirlsDominantImage = preload("res://assets/alleles/swirlsDominant.png")
var swirlsRecessiveImage = preload("res://assets/alleles/swirlsRecessive.png")
var colourDominantImage = preload("res://assets/alleles/colorYellow.png")
var colourRecessiveImage = preload("res://assets/alleles/colorWhite.png")

func Init(_wheelType: WheelType) -> void:
	self.wheelType = _wheelType
	var wheelImage: TextureRect = $wheel
	match _wheelType:
		WheelType.Wheel2:
			wheelImage.texture = wheel2Image
			wheelImage.rotation_degrees = 0
		WheelType.Wheel4:
			wheelImage.texture = wheel4Image
			wheelImage.rotation_degrees = 0
		WheelType.Wheel8:
			wheelImage.texture = wheel8Image
			wheelImage.rotation_degrees = 22.5

func SetAlleles(
	card: Card,
) -> void:
	var totalTrue = [card.showFurLengthAlleles, card.showFurSwirlsAlleles, card.showFurColourAlleles].count(true)
	match wheelType:
		WheelType.Wheel2:
			assert(totalTrue == 1)
		WheelType.Wheel4:
			assert(totalTrue == 2)
		WheelType.Wheel8:
			assert(totalTrue == 3)

	var allelesPosition1 = $Alleles/alleles1
	var allelesPosition2 = $Alleles/alleles2
	var allelesPosition3 = $Alleles/alleles3
	var allelesPosition4 = $Alleles/alleles4
	var allelesPosition5 = $Alleles/alleles5
	var allelesPosition6 = $Alleles/alleles6
	var allelesPosition7 = $Alleles/alleles7
	var allelesPosition8 = $Alleles/alleles8
	match wheelType:
		WheelType.Wheel2:
			# Use allele positions 3 and 7
			if card.showFurLengthAlleles:
				match card.furLengthAlleles:
					Card.Alleles.DominantDominant:
						allelesPosition3.add_child(createAlleleImageNode(lengthDominantImage))
						allelesPosition7.add_child(createAlleleImageNode(lengthDominantImage))
					Card.Alleles.DominantRecessive:
						allelesPosition3.add_child(createAlleleImageNode(lengthDominantImage))
						allelesPosition7.add_child(createAlleleImageNode(lengthRecessiveImage))
					Card.Alleles.RecessiveRecessive:
						allelesPosition3.add_child(createAlleleImageNode(lengthRecessiveImage))
						allelesPosition7.add_child(createAlleleImageNode(lengthRecessiveImage))
			if card.showFurSwirlsAlleles:
				match card.furSwirlsAlleles:
					Card.Alleles.DominantDominant:
						allelesPosition3.add_child(createAlleleImageNode(swirlsDominantImage))
						allelesPosition7.add_child(createAlleleImageNode(swirlsDominantImage))
					Card.Alleles.DominantRecessive:
						allelesPosition3.add_child(createAlleleImageNode(swirlsDominantImage))
						allelesPosition7.add_child(createAlleleImageNode(swirlsRecessiveImage))
					Card.Alleles.RecessiveRecessive:
						allelesPosition3.add_child(createAlleleImageNode(swirlsRecessiveImage))
						allelesPosition7.add_child(createAlleleImageNode(swirlsRecessiveImage))
			if card.showFurColourAlleles:
				match card.furColourAlleles:
					Card.Alleles.DominantDominant:
						allelesPosition3.add_child(createAlleleImageNode(colourDominantImage))
						allelesPosition7.add_child(createAlleleImageNode(colourDominantImage))
					Card.Alleles.DominantRecessive:
						allelesPosition3.add_child(createAlleleImageNode(colourDominantImage))
						allelesPosition7.add_child(createAlleleImageNode(colourRecessiveImage))
					Card.Alleles.RecessiveRecessive:
						allelesPosition3.add_child(createAlleleImageNode(colourRecessiveImage))
						allelesPosition7.add_child(createAlleleImageNode(colourRecessiveImage))
		WheelType.Wheel4:
			# Use allele positions 2, 4, 6 and 8
			if card.showFurLengthAlleles:
				match card.furLengthAlleles:
					Card.Alleles.DominantDominant:
						allelesPosition2.add_child(createAlleleImageNode(lengthDominantImage))
						allelesPosition4.add_child(createAlleleImageNode(lengthDominantImage))
						allelesPosition6.add_child(createAlleleImageNode(lengthDominantImage))
						allelesPosition8.add_child(createAlleleImageNode(lengthDominantImage))
					Card.Alleles.DominantRecessive:
						allelesPosition2.add_child(createAlleleImageNode(lengthDominantImage))
						allelesPosition4.add_child(createAlleleImageNode(lengthDominantImage))
						allelesPosition6.add_child(createAlleleImageNode(lengthRecessiveImage))
						allelesPosition8.add_child(createAlleleImageNode(lengthRecessiveImage))
					Card.Alleles.RecessiveRecessive:
						allelesPosition2.add_child(createAlleleImageNode(lengthRecessiveImage))
						allelesPosition4.add_child(createAlleleImageNode(lengthRecessiveImage))
						allelesPosition6.add_child(createAlleleImageNode(lengthRecessiveImage))
						allelesPosition8.add_child(createAlleleImageNode(lengthRecessiveImage))
			if card.showFurSwirlsAlleles:
				match card.furSwirlsAlleles:
					Card.Alleles.DominantDominant:
						allelesPosition2.add_child(createAlleleImageNode(swirlsDominantImage))
						allelesPosition4.add_child(createAlleleImageNode(swirlsDominantImage))
						allelesPosition6.add_child(createAlleleImageNode(swirlsDominantImage))
						allelesPosition8.add_child(createAlleleImageNode(swirlsDominantImage))
					Card.Alleles.DominantRecessive:
						allelesPosition2.add_child(createAlleleImageNode(swirlsDominantImage))
						allelesPosition4.add_child(createAlleleImageNode(swirlsRecessiveImage))
						allelesPosition6.add_child(createAlleleImageNode(swirlsRecessiveImage))
						allelesPosition8.add_child(createAlleleImageNode(swirlsDominantImage))
					Card.Alleles.RecessiveRecessive:
						allelesPosition2.add_child(createAlleleImageNode(swirlsRecessiveImage))
						allelesPosition4.add_child(createAlleleImageNode(swirlsRecessiveImage))
						allelesPosition6.add_child(createAlleleImageNode(swirlsRecessiveImage))
						allelesPosition8.add_child(createAlleleImageNode(swirlsRecessiveImage))
			if card.showFurColourAlleles:
				match card.colourAlleles:
					Card.Alleles.DominantDominant:
						allelesPosition2.add_child(createAlleleImageNode(colourDominantImage))
						allelesPosition4.add_child(createAlleleImageNode(colourDominantImage))
						allelesPosition6.add_child(createAlleleImageNode(colourDominantImage))
						allelesPosition8.add_child(createAlleleImageNode(colourDominantImage))
					Card.Alleles.DominantRecessive:
						if (card.showFurLengthAlleles):
							allelesPosition2.add_child(createAlleleImageNode(colourDominantImage))
							allelesPosition4.add_child(createAlleleImageNode(colourRecessiveImage))
							allelesPosition6.add_child(createAlleleImageNode(colourRecessiveImage))
							allelesPosition8.add_child(createAlleleImageNode(colourDominantImage))
						else:
							allelesPosition2.add_child(createAlleleImageNode(colourDominantImage))
							allelesPosition4.add_child(createAlleleImageNode(colourRecessiveImage))
							allelesPosition6.add_child(createAlleleImageNode(colourRecessiveImage))
							allelesPosition8.add_child(createAlleleImageNode(colourDominantImage))
					Card.Alleles.RecessiveRecessive:
						allelesPosition2.add_child(createAlleleImageNode(colourRecessiveImage))
						allelesPosition4.add_child(createAlleleImageNode(colourRecessiveImage))
						allelesPosition6.add_child(createAlleleImageNode(colourRecessiveImage))
						allelesPosition8.add_child(createAlleleImageNode(colourRecessiveImage))
		WheelType.Wheel8:
			# Use all allele positions
			match card.lengthAlleles:
				Card.Alleles.DominantDominant:
					allelesPosition1.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition2.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition3.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition4.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition5.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition6.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition7.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition8.add_child(createAlleleImageNode(lengthDominantImage))
				Card.Alleles.DominantRecessive:
					allelesPosition1.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition2.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition3.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition4.add_child(createAlleleImageNode(lengthDominantImage))
					allelesPosition5.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition6.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition7.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition8.add_child(createAlleleImageNode(lengthRecessiveImage))
				Card.Alleles.RecessiveRecessive:
					allelesPosition1.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition2.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition3.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition4.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition5.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition6.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition7.add_child(createAlleleImageNode(lengthRecessiveImage))
					allelesPosition8.add_child(createAlleleImageNode(lengthRecessiveImage))
			match card.furSwirlsAlleles:
				Card.Alleles.DominantDominant:
					allelesPosition1.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition2.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition3.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition4.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition5.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition6.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition7.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition8.add_child(createAlleleImageNode(swirlsDominantImage))
				Card.Alleles.DominantRecessive:
					allelesPosition1.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition2.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition3.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition4.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition5.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition6.add_child(createAlleleImageNode(swirlsDominantImage))
					allelesPosition7.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition8.add_child(createAlleleImageNode(swirlsRecessiveImage))
				Card.Alleles.RecessiveRecessive:
					allelesPosition1.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition2.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition3.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition4.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition5.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition6.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition7.add_child(createAlleleImageNode(swirlsRecessiveImage))
					allelesPosition8.add_child(createAlleleImageNode(swirlsRecessiveImage))
			match card.furColourAlleles:
				Card.Alleles.DominantDominant:
					allelesPosition1.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition2.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition3.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition4.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition5.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition6.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition7.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition8.add_child(createAlleleImageNode(colourDominantImage))
				Card.Alleles.DominantRecessive:
					allelesPosition1.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition2.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition3.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition4.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition5.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition6.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition7.add_child(createAlleleImageNode(colourDominantImage))
					allelesPosition8.add_child(createAlleleImageNode(colourRecessiveImage))
				Card.Alleles.RecessiveRecessive:
					allelesPosition1.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition2.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition3.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition4.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition5.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition6.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition7.add_child(createAlleleImageNode(colourRecessiveImage))
					allelesPosition8.add_child(createAlleleImageNode(colourRecessiveImage))

func createAlleleImageNode(image: Texture) -> TextureRect:
	var textureRect = TextureRect.new()
	textureRect.texture = image
	textureRect.custom_minimum_size = Vector2(45, 45)
	return textureRect

func ResetAlleles():
	for n in $Alleles/alleles1.get_children(): $Alleles/alleles1.remove_child(n)
	for n in $Alleles/alleles2.get_children(): $Alleles/alleles2.remove_child(n)
	for n in $Alleles/alleles3.get_children(): $Alleles/alleles3.remove_child(n)
	for n in $Alleles/alleles4.get_children(): $Alleles/alleles4.remove_child(n)
	for n in $Alleles/alleles5.get_children(): $Alleles/alleles5.remove_child(n)
	for n in $Alleles/alleles6.get_children(): $Alleles/alleles6.remove_child(n)
	for n in $Alleles/alleles7.get_children(): $Alleles/alleles7.remove_child(n)
	for n in $Alleles/alleles8.get_children(): $Alleles/alleles8.remove_child(n)