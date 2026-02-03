extends CharacterBody2D

@export var enemy_type : EnemyType = EnemyType.ENEMY_3

@onready var sprite: AnimatedSprite2D = $Sprite

enum EnemyType {
	ENEMY_1,
	ENEMY_2,
	ENEMY_3
}

func initialize_enemy() -> void:
	set_animation()
	randomize_start_frame()
	
func set_animation() -> void:
	match enemy_type:
		EnemyType.ENEMY_1:
			sprite.play("enemy_1")
		EnemyType.ENEMY_2:
			sprite.play("enemy_2")
		EnemyType.ENEMY_3:
			sprite.play("enemy_3")

func randomize_start_frame() -> void:
	sprite.frame = randi_range(0, sprite.sprite_frames.get_frame_count(sprite.animation) - 1)
