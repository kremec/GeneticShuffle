extends Control

@onready var btnExit = $VBoxContainer/HBoxContainer/btnExit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btnExit.pressed.connect(_on_btnExit_pressed)

func _on_btnExit_pressed() -> void:
	get_tree().change_scene_to_file("res://src/main_menu/main_menu.tscn")