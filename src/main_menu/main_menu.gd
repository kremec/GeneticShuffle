extends Control

@onready var btnStart = $btnStart
@onready var btnHowToPlay = $btnHowToPlay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btnStart.pressed.connect(_on_btnStart_pressed)
	btnHowToPlay.pressed.connect(_on_btnHowToPlay_pressed)

func _on_btnStart_pressed() -> void:
	get_tree().change_scene_to_file("res://src/game/game.tscn")

func _on_btnHowToPlay_pressed() -> void:
	get_tree().change_scene_to_file("res://src/how_to_play/how_to_play.tscn")
