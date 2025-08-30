class_name PlayerTwoController
extends Node2D

@onready var player_two_input_manager: PlayerTwoInputManager = $PlayerTwoInputManagerNode

const BULLET_EMMITER_LAYER_TYPE:BulletController.BulletEmitter = BulletController.BulletEmitter.PLAYER

#region orbit properties
@export_range(0,360,0.01)
var initial_angle_orbit_position:float
@export 
var base_angular_orbit_speed:float
@export
var orbit_radius:float

var input_orbit_position:float 
var input_orbit_position_left:float
var input_orbit_position_rigth:float

var current_angle_orbit_position:float
var angular_vector_orbit_position:Vector2 = Vector2.ZERO
var pivot_player_node:Node2D
#endregion

#region self rotation properties
@export
var base_self_angular_speed:float
var input_self_rotation:float 
var input_self_rotation_left:float
var input_self_rotation_rigth:float

#endregion

var current_weapon: WeaponController

func on_press_left_orbit_listener(is_pressing:bool):
	if(is_pressing):
		self.input_orbit_position_left = -1
	else:
		self.input_orbit_position_left = 0

func on_press_right_orbit_listener(is_pressing:bool):
	if(is_pressing):
		self.input_orbit_position_rigth = 1
	else:
		self.input_orbit_position_rigth = 0

func on_press_left_self_rotation_listener(is_pressing:bool):
	if(is_pressing):
		self.input_self_rotation_left = -1
	else:
		self.input_self_rotation_left = 0

func on_press_right_self_rotation_listener(is_pressing:bool):
	if(is_pressing):
		self.input_self_rotation_rigth = 1
	else:
		self.input_self_rotation_rigth = 0

func get_bullet_emmiter_layer_type() -> BulletController.BulletEmitter:
	return self.BULLET_EMMITER_LAYER_TYPE


func self_rotation(delta_time:float) -> void:
	self.input_self_rotation = self.input_self_rotation_rigth + self.input_self_rotation_left
	var angular_speed = self.input_self_rotation * base_self_angular_speed * delta_time
	angular_speed = deg_to_rad(angular_speed)
	rotate(angular_speed)
	
func orbit_positioning(delta_time:float) -> void:
	self.input_orbit_position = self.input_orbit_position_rigth + self.input_orbit_position_left
	var angular_speed = self.input_orbit_position * self.base_angular_orbit_speed * delta_time
	self.current_angle_orbit_position = self.current_angle_orbit_position + angular_speed
	angular_vector_orbit_position.x = self.orbit_radius * cos(deg_to_rad(self.current_angle_orbit_position))
	angular_vector_orbit_position.y = self.orbit_radius * sin(deg_to_rad(self.current_angle_orbit_position))
	self.position = self.pivot_player_node.position + angular_vector_orbit_position

func _ready() -> void:
	self.current_angle_orbit_position = self.initial_angle_orbit_position
	self.player_two_input_manager.pressing_orbit_right_notify.connect(on_press_right_orbit_listener)
	self.player_two_input_manager.pressing_orbit_left_notify.connect(on_press_left_orbit_listener)
	self.player_two_input_manager.pressing_self_rotation_right_notify.connect(on_press_right_self_rotation_listener)
	self.player_two_input_manager.pressing_self_rotation_left_notify.connect(on_press_left_self_rotation_listener )
	

func _process(delta: float) -> void:
	self_rotation(delta)
	if (self.pivot_player_node != null):
		orbit_positioning(delta)
	
