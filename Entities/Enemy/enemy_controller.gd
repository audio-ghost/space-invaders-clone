extends Node2D

@export var enemy_scene: PackedScene
@export var rows := 3
@export var columns := 8
@export var horizontal_spacing := 24
@export var vertical_spacing := 24

@export var move_speed := 20.0
@export var step_down_amount := 8
@export var left_margin := 8
@export var right_margin := 312

var direction := 1

func _ready():
	randomize()
	_spawn_grid()

func _process(delta: float) -> void:
	position.x += move_speed * direction * delta
	if _hit_edge():
		position.x -= move_speed * direction * delta
		position.y += step_down_amount
		direction *= -1

func _spawn_grid():
	for row in range(rows):
		for col in range(columns):
			var enemy = enemy_scene.instantiate()
			add_child(enemy)
			
			#Row based enemy selection
			match row:
				0:
					enemy.enemy_type = enemy.EnemyType.ENEMY_3
				1:
					enemy.enemy_type = enemy.EnemyType.ENEMY_2
				_:
					enemy.enemy_type = enemy.EnemyType.ENEMY_1
			
			enemy.initialize_enemy()
			enemy.position = Vector2(
				col * horizontal_spacing,
				row * vertical_spacing
			)

func _hit_edge() -> bool:
	for child in get_children():
		if not child is Node2D:
			continue
		var enemy := child as Node2D
		var enemy_x := enemy.global_position.x
		if direction == 1 and enemy_x >= right_margin:
			return true
		if direction == -1 and enemy_x <= left_margin:
			return true
		
	return false
