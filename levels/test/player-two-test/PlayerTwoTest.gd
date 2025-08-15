extends Node

@export var orbit_radius:float

@onready var pivot: Node2D = $pivot
@onready var player_two: PlayerTwoController = $PlayerTwo

func _ready() -> void:
	
	player_two.pivot_player_node = pivot
	player_two.orbit_radius = orbit_radius
	
