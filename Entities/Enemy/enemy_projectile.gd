class_name EnemyProjectile extends Area2D

@export var speed:= 200.0

@onready var sprite: Sprite2D = $Sprite

const ENEMY_PROJECTILE_1 := preload("uid://mbxxoqwo031u")
const ENEMY_PROJECTILE_2 := preload("uid://cth1b5vde6hen")
const ENEMY_PROJECTILE_3 := preload("uid://o7xqlkn8xd8r")

func _ready() -> void:
	add_to_group(Groups.ENEMY_PROJECTILES)

func initialize(enemy_type: Enemy.EnemyType) -> void:
	match enemy_type:
		Enemy.EnemyType.ENEMY_1:
			sprite.texture = ENEMY_PROJECTILE_1
			speed = 150
		Enemy.EnemyType.ENEMY_2:
			sprite.texture = ENEMY_PROJECTILE_2
			speed = 200
		Enemy.EnemyType.ENEMY_3:
			sprite.texture = ENEMY_PROJECTILE_3
			speed = 250
	
func _physics_process(delta: float) -> void:
	position.y += speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(Groups.PLAYER):
		body.die()
	queue_free()
