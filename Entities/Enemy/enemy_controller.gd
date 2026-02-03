extends Node2D

@export var enemy_scene: PackedScene
@export var rows := 3
@export var columns := 8
@export var horizontal_spacing := 24
@export var vertical_spacing := 24
@export var enemy_bullet_scene: PackedScene
@export var fire_interval := 2.0

@export var base_move_speed := 20.0
@export var step_down_amount := 8
@export var left_margin := 8
@export var right_margin := 312

var max_enemies := 24
var move_speed := base_move_speed

var direction := 1

func _ready():
	randomize()
	_spawn_grid()
	_fire_loop()

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
			enemy.killed.connect(_on_enemy_killed)
			
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
	max_enemies = get_tree().get_nodes_in_group(Groups.ENEMIES).size()

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

func _fire_loop() -> void:
	while true:
		await get_tree().create_timer(fire_interval).timeout
		fire_enemy_bullet()

func fire_enemy_bullet() -> void:
	var enemies = get_tree().get_nodes_in_group(Groups.ENEMIES)
	if enemies.is_empty():
		return
	
	var shooter = enemies.pick_random()
	var bullet = enemy_bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.initialize(shooter.get_enemy_type())
	bullet.global_position = shooter.global_position + Vector2(0, 8)

func _on_enemy_killed() -> void:
	var count = get_tree().get_nodes_in_group(Groups.ENEMIES).size()
	move_speed = base_move_speed + (max_enemies - count) * 5
