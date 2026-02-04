extends Node2D

@export var block_scene: PackedScene
@export var pattern := [
	"  ######  ",
	" ######## ",
	"##########",
	"###    ###",
	"##      ##"
]

const BLOCK_SIZE := 4

func _ready() -> void:
	for y in pattern.size():
		for x in pattern[y].length():
			if pattern[y][x] == "#":
				var block = block_scene.instantiate()
				add_child(block)
				block.position = Vector2(x, y) * BLOCK_SIZE
