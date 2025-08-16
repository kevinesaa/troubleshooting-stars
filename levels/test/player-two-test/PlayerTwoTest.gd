extends Node

@export var orbit_radius:float

@onready var pivot: Node2D = $pivot
@onready var player_two: PlayerTwoController = $PlayerTwo

func _ready() -> void:
	
	player_two.pivot_player_node = pivot
	player_two.orbit_radius = orbit_radius
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pivot.position = event.position 
	
