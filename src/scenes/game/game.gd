extends Control

var card = preload("res://src/objects/card/card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	round1()


func round1() -> void:
	var listMales = $layout/sidebarMales/listMales
	var listFemales = $layout/sidebarFemales/listFemales
	
	var male = card.instantiate()
	male.Init(
		Card.Sex.Male,
		Card.Alleles.DominantDominant,
		Card.Alleles.RecessiveRecessive,
		Card.Alleles.DominantDominant
	)
	listMales.add_child(male)
	
	var female = card.instantiate()
	female.Init(
		Card.Sex.Female,
		Card.Alleles.DominantRecessive,
		Card.Alleles.RecessiveRecessive,
		Card.Alleles.DominantDominant
	)
	listFemales.add_child(female)
