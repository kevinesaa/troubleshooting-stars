class_name PlayerTwoInputManager
extends Node

#region orbit direcction inputs
# signal pressing_up_notify(isPressing:bool)
# signal pressing_down_notify(isPressing:bool)
signal pressing_orbit_right_notify(isPressing:bool)
signal pressing_orbit_left_notify(isPressing:bool)
#endregion

#region face direcctions inputs
signal pressing_self_rotation_left_notify(isPressing:bool)
signal pressing_self_rotation_right_notify(isPressing:bool)
#endregion

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	
	var right_orbit = Input.is_action_pressed("player_two_right_orbit")
	# var down = Input.is_action_pressed("player_one_down")
	var left_orbit = Input.is_action_pressed("player_two_left_orbit")
	# var previus_weapon = Input.is_action_just_pressed("player_one_previus_weapon")
	# var next_weapon = Input.is_action_just_pressed("player_one_next_weapon")
	# var shooting = Input.is_action_pressed("player_one_shoot")
	var self_rotation_left = Input.is_action_pressed("player_two_left_self_rotation") 
	var self_rotation_right = Input.is_action_pressed("player_two_right_self_rotation") 
	
	pressing_orbit_right_notify.emit(right_orbit)
	pressing_orbit_left_notify.emit(left_orbit)
	pressing_self_rotation_left_notify.emit(self_rotation_left)
	pressing_self_rotation_right_notify.emit(self_rotation_right)
	
