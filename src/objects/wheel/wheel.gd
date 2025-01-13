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


@export var wheelSpinSpeed: float = 360

var alleles = {}

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
			"show": card.showFurLengthAlleles,
			"alleles": card.furLengthAlleles,
			"dominant": lengthDominantImage,
			"recessive": lengthRecessiveImage
		},
		{
			"show": card.showFurSwirlsAlleles,
			"alleles": card.furSwirlsAlleles,
			"dominant": swirlsDominantImage,
			"recessive": swirlsRecessiveImage
		},
		{
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
				alleleType["alleles"],
				getAllelePositionsForWheelType(),
				alleleType["dominant"],
				alleleType["recessive"],
				allelesShown
			)

func getAllelePositionsForWheelType() -> Array:
	match wheelType:
		WheelType.Wheel2: return [$Alleles/alleles3, $Alleles/alleles7]
		WheelType.Wheel4: return [$Alleles/alleles2, $Alleles/alleles4, $Alleles/alleles6, $Alleles/alleles8]
		WheelType.Wheel8: return [$Alleles/alleles1, $Alleles/alleles2, $Alleles/alleles3, $Alleles/alleles4, $Alleles/alleles5, $Alleles/alleles6, $Alleles/alleles7, $Alleles/alleles8]
	return []

func setAllelePositions(alleleCombo: Allele.AlleleCombo, positionNodes: Array, dominantImage: Texture, recessiveImage: Texture, allelesShown: int) -> void:
	var images = []
	var numPositions = len(positionNodes)
	match alleleCombo:
		Allele.AlleleCombo.DominantDominant:
			# All dominant
			for i in numPositions:
				images.append(dominantImage)
		Allele.AlleleCombo.RecessiveRecessive:
			# All recessive
			for i in numPositions:
				images.append(recessiveImage)
		Allele.AlleleCombo.DominantRecessive:
			# Mixed based on number of alleles shown
			if allelesShown == 1:
				for i in numPositions / 2:
					images.append(dominantImage)
				for i in numPositions / 2:
					images.append(recessiveImage)
			elif allelesShown == 2:
				for i in numPositions / 4:
					images.append(dominantImage)
				for i in numPositions / 4:
					images.append(recessiveImage)
				for i in numPositions / 4:
					images.append(dominantImage)
				for i in numPositions / 4:
					images.append(recessiveImage)
			else:
				for i in numPositions:
					if i % 2 == 0:
						images.append(dominantImage)
					else:
						images.append(recessiveImage)
		
		
	for i in range(len(positionNodes)):
		positionNodes[i].add_child(createAlleleImageNode(images[i]))

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
	var relativeRotation = wheelNode.rotation_degrees - (floor(wheelNode.rotation_degrees) / 360) * 360

	# Get alleles
	match wheelType:
		WheelType.Wheel2:
			if relativeRotation < 180:
				print("7")
			else:
				print("3")
		WheelType.Wheel4:
			if relativeRotation < 90:
				print("8")
			elif relativeRotation < 180:
				print("6")
			elif relativeRotation < 270:
				print("4")
			else:
				print("2")
		WheelType.Wheel8:
			if relativeRotation < 45:
				print("8")
			elif relativeRotation < 90:
				print("7")
			elif relativeRotation < 135:
				print("6")
			elif relativeRotation < 180:
				print("5")
			elif relativeRotation < 225:
				print("4")
			elif relativeRotation < 270:
				print("3")
			elif relativeRotation < 315:
				print("2")
			else:
				print("1")
