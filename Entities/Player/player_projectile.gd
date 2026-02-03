extends Area2D

@export var speed := 400.0

func _ready() -> void:
	add_to_group(Groups.PLAYER_PROJECTILES)
	
func _physics_process(delta: float) -> void:
	position.y -= speed * delta

func _on_area_entered(area: Area2D) -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	print(body)
	if body.is_in_group(Groups.ENEMIES):
		body.die()
	queue_free()
