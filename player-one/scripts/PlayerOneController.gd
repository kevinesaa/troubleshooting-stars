class_name PlayerOneController
extends Node2D

@export var base_speed:float 

@onready var player_one_input_manager: PlayerOneInputManager = $playerOneInputManagerNode


var input_position:Vector2 = Vector2.ZERO
var input_position_up_left:Vector2 = Vector2.ZERO
var input_position_down_rigth:Vector2 = Vector2.ZERO
var velocity:Vector2 = Vector2.ZERO

var current_weapon: WeaponController

func on_press_up_listener(is_pressing:bool):
	
	if(is_pressing):
		self.input_position_up_left.y = -1
	else:
		self.input_position_up_left.y = 0

func on_press_left_listener(is_pressing:bool):
	if(is_pressing):
		self.input_position_up_left.x= -1
	else:
		self.input_position_up_left.x = 0
		
func on_press_donw_listener(is_pressing:bool):
	if(is_pressing):
		self.input_position_down_rigth.y = 1
	else:
		self.input_position_down_rigth.y = 0

func on_press_right_listener(is_pressing:bool):
	if(is_pressing):
		self.input_position_down_rigth.x = 1
	else:
		self.input_position_down_rigth.x = 0

func on_press_shoot_listener(is_pressing:bool):
	if(is_pressing and current_weapon != null):
		current_weapon.shoot()

func my_move(delta: float) -> void:
	
	self.input_position = self.input_position_down_rigth + self.input_position_up_left
	self.input_position = self.input_position.normalized() 
	self.velocity = (delta * base_speed) * self.input_position
	
	self.position = self.position + self.velocity
	

func _ready() -> void:
	self.player_one_input_manager.pressing_up_notify.connect(on_press_up_listener)
	self.player_one_input_manager.pressing_right_notify.connect(on_press_right_listener)
	self.player_one_input_manager.pressing_down_notify.connect(on_press_donw_listener)
	self.player_one_input_manager.pressing_left_notify.connect(on_press_left_listener)
	self.player_one_input_manager.pressing_shooting_notify.connect(on_press_shoot_listener  )
	
func _process(delta: float) -> void:
	my_move(delta)
	
	
