extends Control

@onready var btnStart = $btnStart
@onready var btnHowToPlay = $btnHowToPlay

@onready var howToPlay = $HowToPlay

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btnStart.pressed.connect(_on_btnStart_pressed)
	btnHowToPlay.pressed.connect(_on_btnHowToPlay_pressed)

	howToPlay.btnExit.pressed.connect(_on_btnHowToPlayExit_pressed)

func _on_btnStart_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/game/game.tscn")

func _on_btnHowToPlay_pressed() -> void:
	howToPlay.visible = true

func _on_btnHowToPlayExit_pressed() -> void:
	howToPlay.visible = false
