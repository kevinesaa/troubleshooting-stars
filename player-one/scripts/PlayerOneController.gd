class_name PlayerOneController
extends PlayerBaseController

#region inputs
@onready var player_one_input_manager: PlayerOneInputManager = $playerOneInputManagerNode

var input_position:Vector2 = Vector2.ZERO
var input_position_up_left:Vector2 = Vector2.ZERO
var input_position_down_rigth:Vector2 = Vector2.ZERO
#endregion

#region movement
@export var base_speed:float 
var velocity:Vector2 = Vector2.ZERO
signal player_one_moving(delta_position:Vector2)
#endregion

#region health
@export var default_health:float = 100
@export var max_health:float = 100
var current_health:float
signal health_changed_notify(current:float)
#endregion



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

func set_health(health:float):
	self.current_health = health

func get_health() -> float:
	return self.current_health
	

func my_move(delta: float) -> void:
	
	self.input_position = self.input_position_down_rigth + self.input_position_up_left
	self.input_position = self.input_position.normalized() 
	self.velocity = (delta * base_speed) * self.input_position
	var next_positon:Vector2 = self.position + self.velocity
	var delta_position:Vector2 = next_positon - self.position
	if( !delta_position.is_zero_approx() ):
		self.player_one_moving.emit(delta_position)
	self.position = next_positon
	
func on_collision_enter_listener(body: Node2D):
	print("jugador 1: hay algo colisionando")

func _ready() -> void:
	self.player_one_input_manager.pressing_up_notify.connect(on_press_up_listener)
	self.player_one_input_manager.pressing_right_notify.connect(on_press_right_listener)
	self.player_one_input_manager.pressing_down_notify.connect(on_press_donw_listener)
	self.player_one_input_manager.pressing_left_notify.connect(on_press_left_listener)
	self.player_one_input_manager.pressing_shooting_notify.connect(on_press_shoot_listener  )
	
func _physics_process(delta: float) -> void:
	my_move(delta)
	
	
