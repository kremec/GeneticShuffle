class_name Allele

enum TraitType {
	Length,
	Swirls,
	Color,
}
enum FurLength {
	Long,
	Short
}
enum FurSwirls {
	Swirls,
	NoSwirls
}
enum FurColor {
	Yellow,
	Cream,
	White
}

enum AlleleCombo {
	DominantDominant,
	DominantRecessive,
	RecessiveRecessive
}
enum AlleleType {
	Dominant,
	Recessive
}

static func GetFurLength(alleles: AlleleCombo) -> FurLength:
	# Short - dominant, Long - recessive
	var furLength: FurLength
	match alleles:
		AlleleCombo.DominantDominant:
			furLength = FurLength.Short
		AlleleCombo.DominantRecessive:
			furLength = FurLength.Short
		AlleleCombo.RecessiveRecessive:
			furLength = FurLength.Long
	return furLength

static func GetFurSwirls(alleles: AlleleCombo) -> FurSwirls:
	# Swirls - dominant, No swirls - recessive
	var furSwirls: FurSwirls
	match alleles:
		Allele.AlleleCombo.DominantDominant:
			furSwirls = Allele.FurSwirls.Swirls
		Allele.AlleleCombo.DominantRecessive:
			furSwirls = Allele.FurSwirls.Swirls
		Allele.AlleleCombo.RecessiveRecessive:
			furSwirls = Allele.FurSwirls.NoSwirls
	return furSwirls

static func GetFurColor(alleles: AlleleCombo) -> FurColor:
	# Yellow - dominant, White - recessive
	var furColor: FurColor
	match alleles:
		Allele.AlleleCombo.DominantDominant:
			furColor = FurColor.Yellow
		Allele.AlleleCombo.DominantRecessive:
			furColor = FurColor.Cream
		Allele.AlleleCombo.RecessiveRecessive:
			furColor = FurColor.White
	return furColor

static func StringTraitType(traitType: TraitType) -> String:
	var traitTypeString: String
	match traitType:
		TraitType.Length:
			traitTypeString = "Length"
		TraitType.Swirls:
			traitTypeString = "Swirls"
		TraitType.Color:
			traitTypeString = "Color"
	return traitTypeString

static func StringAlleleType(alleleType: AlleleType) -> String:
	var alleleTypeString: String
	match alleleType:
		AlleleType.Dominant:
			alleleTypeString = "Dominant"
		AlleleType.Recessive:
			alleleTypeString = "Recessive"
	return alleleTypeString

static func GenerateRandomAlleles(targetAlleles: AlleleCombo) -> Array[AlleleCombo]:
	var otherPossibleAlleles: Array[AlleleCombo] = [AlleleCombo.DominantDominant, AlleleCombo.DominantRecessive, AlleleCombo.RecessiveRecessive]
	otherPossibleAlleles.erase(targetAlleles)
	var maleAlleles = GetRandomAlleleCombo(otherPossibleAlleles)
	var femaleAlleles: AlleleCombo

	match targetAlleles:
		AlleleCombo.DominantDominant:
			match maleAlleles:
				AlleleCombo.RecessiveRecessive:
					femaleAlleles = AlleleCombo.DominantRecessive
				_:
					femaleAlleles = GetRandomAlleleCombo([AlleleCombo.DominantRecessive, AlleleCombo.RecessiveRecessive])
		AlleleCombo.RecessiveRecessive:
			match maleAlleles:
				AlleleCombo.DominantDominant:
					femaleAlleles = AlleleCombo.DominantRecessive
				_:
					femaleAlleles = GetRandomAlleleCombo([AlleleCombo.DominantDominant, AlleleCombo.DominantRecessive])
		AlleleCombo.DominantRecessive:
			match maleAlleles:
				AlleleCombo.DominantDominant:
					femaleAlleles = AlleleCombo.RecessiveRecessive
				AlleleCombo.RecessiveRecessive:
					femaleAlleles = AlleleCombo.DominantDominant
				_:
					femaleAlleles = GetRandomAlleleCombo([AlleleCombo.DominantRecessive, AlleleCombo.RecessiveRecessive, AlleleCombo.DominantDominant])

	return [targetAlleles, maleAlleles, femaleAlleles]


static func GetRandomAlleleCombo(possibleCombos: Array[AlleleCombo]) -> AlleleCombo:
	var combo: int = randi_range(0, possibleCombos.size() - 1)
	return possibleCombos[combo]

static var AlleleInfo = {
	TraitType.Length: {
		AlleleType.Dominant: {
			"label": "Short fur (Dominant)",
			"image": load("res://assets/alleles/lengthDominant.png")
		},
		AlleleType.Recessive: {
			"label": "Long fur (Recessive)",
			"image": load("res://assets/alleles/lengthRecessive.png")
		}
	},
	TraitType.Swirls: {
		AlleleType.Dominant: {
			"label": "Swirls (Dominant)",
			"image": load("res://assets/alleles/swirlsDominant.png")
		},
		AlleleType.Recessive: {
			"label": "No swirls (Recessive)",
			"image": load("res://assets/alleles/swirlsRecessive.png")
		}
	},
	TraitType.Color: {
		AlleleCombo.DominantDominant: {
			"label": "Yellow hair",
			"image1": load("res://assets/alleles/colorYellow.png"),
			"image2": load("res://assets/alleles/colorYellow.png")
		},
		AlleleCombo.DominantRecessive: {
			"label": "Cream hair",
			"image1": load("res://assets/alleles/colorYellow.png"),
			"image2": load("res://assets/alleles/colorWhite.png")
		},
		AlleleCombo.RecessiveRecessive: {
			"label": "White hair",
			"image1": load("res://assets/alleles/colorWhite.png"),
			"image2": load("res://assets/alleles/colorWhite.png")
		}
	}
}
