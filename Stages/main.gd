extends Node2D


func _on_player_player_death() -> void:
	create_overlay("GAME OVER")

func _on_fail_line_fail_line_entered() -> void:
	create_overlay("GAME OVER")

func _on_enemy_controller_all_enemies_defeated() -> void:
	create_overlay("YOU WIN!")

func create_overlay(message: String) -> void:
	var overlay = preload("res://Stages/end_overlay.tscn").instantiate()
	overlay.message = message
	get_tree().current_scene.add_child(overlay)
