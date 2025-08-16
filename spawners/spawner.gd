extends Node2D

@export var spawners: Array[Vector2] = []

func _ready():
	spawners = [
		Vector2(448, -32), #1
		Vector2(576, 72),
		Vector2(576, 192),
		Vector2(576, 312),
		Vector2(448, 392),
		Vector2(320, 392),
		Vector2(192, 392),
		Vector2(64, 312),
		Vector2(64, 192),
		Vector2(64, 72),
		Vector2(192, -32),
		Vector2(320, -32) #12
	]
	pass

func get_spawner(position):
	return spawners[position]
