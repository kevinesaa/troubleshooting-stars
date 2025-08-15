class_name PlayerOneInputManager
extends Node

#region direcction inputs
signal pressing_up_notify(isPressing:bool)
signal pressing_down_notify(isPressing:bool)
signal pressing_right_notify(isPressing:bool)
signal pressing_left_notify(isPressing:bool)
#endregion

signal pressing_previus_weapon_notify(isPressing:bool)
signal pressing_next_weapon_notify(isPressing:bool)

signal pressing_shooting_notify(isPressing:bool)



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var up = Input.is_action_pressed("player_one_up")
	var right = Input.is_action_pressed("player_one_right")
	var down = Input.is_action_pressed("player_one_down")
	var left = Input.is_action_pressed("player_one_left")
	var previus_weapon = Input.is_action_just_pressed("player_one_previus_weapon")
	var next_weapon = Input.is_action_just_pressed("player_one_next_weapon")
	var shooting = Input.is_action_pressed("player_one_shoot")
	
	pressing_up_notify.emit(up)
	pressing_down_notify.emit(down)
	pressing_right_notify.emit(right)
	pressing_left_notify.emit(left)
	
	pressing_previus_weapon_notify.emit(previus_weapon)
	pressing_next_weapon_notify.emit(next_weapon)
	pressing_shooting_notify.emit(shooting)
	
