extends CanvasLayer

@export var message := "GAME OVER"
@export var display_time := 2.5

@onready var label: Label = $Label

func _ready() -> void:
	label.text = message
	await get_tree().create_timer(display_time).timeout
	get_tree().change_scene_to_file("res://Stages/TitleScreen/title_screen.tscn")
	
