extends Area2D

signal fail_line_entered

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(Groups.ENEMIES):
		emit_signal("fail_line_entered")
