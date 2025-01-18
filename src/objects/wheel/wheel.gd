class_name Wheel extends Control

enum WheelType {
	Wheel2,
	Wheel4,
	Wheel8,
}

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

@onready var alleleImages = {
	1: $Alleles/alleles1,
	2: $Alleles/alleles2,
	3: $Alleles/alleles3,
	4: $Alleles/alleles4,
	5: $Alleles/alleles5,
	6: $Alleles/alleles6,
	7: $Alleles/alleles7,
	8: $Alleles/alleles8
}


@export var wheelSpinSpeed: float = 360

var alleles = {1: [], 2: [], 3: [], 4: [], 5: [], 6: [], 7: [], 8: []}

func Init(_wheelType: WheelType) -> void:
	wheelType = _wheelType
	var wheelImage: TextureRect = $wheel
	var alleleContainers: Control = $Alleles
	match _wheelType:
		WheelType.Wheel2:
			wheelImage.texture = wheel2Image
			alleleContainers.rotation_degrees = 0
		WheelType.Wheel4:
			wheelImage.texture = wheel4Image
			alleleContainers.rotation_degrees = 0
		WheelType.Wheel8:
			wheelImage.texture = wheel8Image
			alleleContainers.rotation_degrees = 22.5

func SetAlleles(card: Card) -> void:
	validateAlleleCount(card)
	setWheelAlleles(card)

func validateAlleleCount(card: Card) -> void:
	var totalTrue = [
		card.showFurLengthAlleles,
		card.showFurSwirlsAlleles,
		card.showFurColorAlleles
	].count(true)

	match wheelType:
		WheelType.Wheel2: assert(totalTrue == 1)
		WheelType.Wheel4: assert(totalTrue == 2)
		WheelType.Wheel8: assert(totalTrue == 3)

func setWheelAlleles(card: Card) -> void:
	var alleleTypes = [
		{
			"type": Allele.TraitType.Length,
			"show": card.showFurLengthAlleles,
			"alleles": card.furLengthAlleles,
			"dominant": lengthDominantImage,
			"recessive": lengthRecessiveImage
		},
		{
			"type": Allele.TraitType.Swirls,
			"show": card.showFurSwirlsAlleles,
			"alleles": card.furSwirlsAlleles,
			"dominant": swirlsDominantImage,
			"recessive": swirlsRecessiveImage
		},
		{
			"type": Allele.TraitType.Color,
			"show": card.showFurColorAlleles,
			"alleles": card.furColorAlleles,
			"dominant": colourDominantImage,
			"recessive": colourRecessiveImage
		}
	]

	var allelesShown = 0
	for i in range(alleleTypes.size()):
		var alleleType = alleleTypes[i]

		if alleleType["show"]:
			allelesShown += 1
			setAllelePositions(
				alleleType["type"],
				alleleType["alleles"],
				getAllelePositionsForWheelType(),
				alleleType["dominant"],
				alleleType["recessive"],
				allelesShown
			)

func getAllelePositionsForWheelType() -> Array:
	match wheelType:
		WheelType.Wheel2: return [3, 7]
		WheelType.Wheel4: return [2, 4, 6, 8]
		WheelType.Wheel8: return [1, 2, 3, 4, 5, 6, 7, 8]
	return []

func setAllelePositions(
		alleleType: Allele.TraitType,
		alleleCombo: Allele.AlleleCombo,
		positionNodes: Array,
		dominantImage: Texture,
		recessiveImage: Texture,
		allelesShown: int
) -> void:
	var images = []
	var newAlleles = []
	var numPositions = len(positionNodes)
	match alleleCombo:
		Allele.AlleleCombo.DominantDominant:
			# All dominant
			for i in numPositions:
				newAlleles.append([alleleType, Allele.AlleleType.Dominant])
				images.append(dominantImage)
		Allele.AlleleCombo.RecessiveRecessive:
			# All recessive
			for i in numPositions:
				newAlleles.append([alleleType, Allele.AlleleType.Recessive])
				images.append(recessiveImage)
		Allele.AlleleCombo.DominantRecessive:
			# Mixed based on number of alleles shown
			if allelesShown == 1:
				# Halfs
				for i in numPositions / 2:
					newAlleles.append([alleleType, Allele.AlleleType.Dominant])
					images.append(dominantImage)
				for i in numPositions / 2:
					newAlleles.append([alleleType, Allele.AlleleType.Recessive])
					images.append(recessiveImage)
			elif allelesShown == 2:
				# Quarters
				for i in numPositions / 4:
					newAlleles.append([alleleType, Allele.AlleleType.Dominant])
					images.append(dominantImage)
				for i in numPositions / 4:
					newAlleles.append([alleleType, Allele.AlleleType.Recessive])
					images.append(recessiveImage)
				for i in numPositions / 4:
					newAlleles.append([alleleType, Allele.AlleleType.Dominant])
					images.append(dominantImage)
				for i in numPositions / 4:
					newAlleles.append([alleleType, Allele.AlleleType.Recessive])
					images.append(recessiveImage)
			else:
				# Every other
				for i in numPositions:
					if i % 2 == 0:
						newAlleles.append([alleleType, Allele.AlleleType.Dominant])
						images.append(dominantImage)
					else:
						newAlleles.append([alleleType, Allele.AlleleType.Recessive])
						images.append(recessiveImage)
	
	for i in range(numPositions):
		alleles[positionNodes[i]].append(newAlleles[i])
		alleleImages[positionNodes[i]].add_child(createAlleleImageNode(images[i]))

func createAlleleImageNode(image: Texture) -> Node:
	var boxContainer: BoxContainer = BoxContainer.new()
	boxContainer.size_flags_vertical = Control.SizeFlags.SIZE_EXPAND_FILL
	var textureRect = TextureRect.new()
	textureRect.texture = image
	textureRect.custom_minimum_size = Vector2(45, 45)
	textureRect.size_flags_vertical = Control.SizeFlags.SIZE_SHRINK_CENTER
	textureRect.size_flags_horizontal = Control.SizeFlags.SIZE_SHRINK_CENTER
	boxContainer.add_child(textureRect)
	return boxContainer

func ResetAlleles():
	for key in alleles.keys():
		alleles[key].clear()
	
	for n in $Alleles/alleles1.get_children(): n.queue_free()
	for n in $Alleles/alleles2.get_children(): n.queue_free()
	for n in $Alleles/alleles3.get_children(): n.queue_free()
	for n in $Alleles/alleles4.get_children(): n.queue_free()
	for n in $Alleles/alleles5.get_children(): n.queue_free()
	for n in $Alleles/alleles6.get_children(): n.queue_free()
	for n in $Alleles/alleles7.get_children(): n.queue_free()
	for n in $Alleles/alleles8.get_children(): n.queue_free()

func Spin():
	var rotationAngle: float = randf_range(360, 360 * 3)
	var spinDuration: float = rotationAngle / wheelSpinSpeed

	var wheelNode = $"."

	var rotationTween = get_tree().create_tween()
	rotationTween.tween_property(
		wheelNode,
		"rotation_degrees",
		wheelNode.rotation_degrees + rotationAngle,
		spinDuration
	).set_trans(Tween.TRANS_QUINT)

	return rotationTween

func GetAlleles():
	var wheelNode = $"."
	var relativeRotation = wheelNode.rotation_degrees - (int(wheelNode.rotation_degrees) / 360) * 360

	# Get alleles
	match wheelType:
		WheelType.Wheel2:
			if relativeRotation < 180:
				return alleles[7]
			else:
				return alleles[3]
		WheelType.Wheel4:
			if relativeRotation < 90:
				return alleles[8]
			elif relativeRotation < 180:
				return alleles[6]
			elif relativeRotation < 270:
				return alleles[4]
			else:
				return alleles[2]
		WheelType.Wheel8:
			if relativeRotation < 45:
				return alleles[8]
			elif relativeRotation < 90:
				return alleles[7]
			elif relativeRotation < 135:
				return alleles[6]
			elif relativeRotation < 180:
				return alleles[5]
			elif relativeRotation < 225:
				return alleles[4]
			elif relativeRotation < 270:
				return alleles[3]
			elif relativeRotation < 315:
				return alleles[2]
			else:
				return alleles[1]
