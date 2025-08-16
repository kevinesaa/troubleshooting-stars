class_name PlayerTwoController
extends Node2D

@export_range(0,360,0.01)
var initial_angle_position:float
@export var base_angular_speed:float

@onready var player_two_input_manager: PlayerTwoInputManager = $PlayerTwoInputManagerNode

var input_position:float 
var input_position_left:float
var input_position_rigth:float


var current_angle_position:float
var orbit_radius:float
var angular_vector_position:Vector2 = Vector2.ZERO
var pivot_player_node:Node2D

func on_press_left_orbit_listener(is_pressing:bool):
	if(is_pressing):
		self.input_position_left = -1
	else:
		self.input_position_left = 0

func on_press_right_orbit_listener(is_pressing:bool):
	if(is_pressing):
		self.input_position_rigth = 1
	else:
		self.input_position_rigth = 0


func _ready() -> void:
	self.current_angle_position = self.initial_angle_position
	self.player_two_input_manager.pressing_orbit_right_notify.connect(on_press_right_orbit_listener)
	self.player_two_input_manager.pressing_orbit_left_notify.connect(on_press_left_orbit_listener)
		

func _process(delta: float) -> void:
	self.input_position = self.input_position_rigth + self.input_position_left
	if (self.pivot_player_node != null):
		positioning(delta)
	
	
	
func positioning(delta_time:float) -> void:
	
	
	var angular_speed = self.input_position * self.base_angular_speed * delta_time
	self.current_angle_position = self.current_angle_position + angular_speed
	angular_vector_position.x = self.orbit_radius * cos(deg_to_rad(self.current_angle_position))
	angular_vector_position.y = self.orbit_radius * sin(deg_to_rad(self.current_angle_position))
	self.position = self.pivot_player_node.position + angular_vector_position
