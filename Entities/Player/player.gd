extends CharacterBody2D

@export var speed := 120.0

@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var half_width := sprite_2d.texture.get_width() / 2

func _physics_process(delta: float) -> void:
	var direction = 0.0
	
	if Input.is_action_pressed("ui_left"):
		direction -= 1
	if Input.is_action_pressed("ui_right"):
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
