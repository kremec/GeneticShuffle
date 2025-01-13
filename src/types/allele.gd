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