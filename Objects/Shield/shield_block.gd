extends Area2D


func _ready() -> void:
	add_to_group(Groups.SHIELD_BLOCKS)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(Groups.ENEMY_PROJECTILES) \
	or area.is_in_group(Groups.PLAYER_PROJECTILES):
		area.queue_free()
		queue_free()
