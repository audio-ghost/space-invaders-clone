class_name Player extends CharacterBody2D

@export var speed := 120.0
@export var bullet_scene: PackedScene
@export var fire_cooldown := 0.4

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var half_width := sprite_2d.texture.get_width() / 2

signal player_death

var can_fire := true

func _ready() -> void:
	add_to_group(Groups.PLAYER)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("FIRE") and can_fire:
		fire()

func _physics_process(_delta: float) -> void:
	var direction = 0.0
	
	if Input.is_action_pressed("LEFT"):
		direction -= 1
	if Input.is_action_pressed("RIGHT"):
		direction += 1
	
	velocity.x = direction * speed
	velocity.y = 0
	
	move_and_slide()
	
	#Clamp to screen
	var viewport_width := get_viewport_rect().size.x
	global_position.x = clamp(
		round(global_position.x),
		half_width,
		viewport_width - half_width
	)

func fire() -> void:
	can_fire = false
	var bullet = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = global_position + Vector2(0, -12)
	await get_tree().create_timer(fire_cooldown).timeout
	can_fire = true

func die() -> void:
	emit_signal("player_death")
	queue_free()
