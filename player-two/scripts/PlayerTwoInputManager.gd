class_name PlayerTwoInputManager
extends Node

#region direcction inputs
# signal pressing_up_notify(isPressing:bool)
# signal pressing_down_notify(isPressing:bool)
signal pressing_right_notify(isPressing:bool)
signal pressing_left_notify(isPressing:bool)
#endregion

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	var right = Input.is_action_pressed("player_two_right")
	# var down = Input.is_action_pressed("player_one_down")
	var left = Input.is_action_pressed("player_two_left")
	# var previus_weapon = Input.is_action_just_pressed("player_one_previus_weapon")
	# var next_weapon = Input.is_action_just_pressed("player_one_next_weapon")
	# var shooting = Input.is_action_pressed("player_one_shoot")
	
	pressing_right_notify.emit(right)
	pressing_left_notify.emit(left)
	
