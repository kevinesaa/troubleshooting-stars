extends Node2D

@export var x_speed = 0
@export var y_speed = 1

#sine vars
@export var amplitude = 50
@export var frequency = 3.0
@export var time = 0.0

#shoot n go var
@export var is_moving = false

func _ready():
	shot_n_go()
	pass

func _process(delta):
	#move(x_speed,y_speed)
	#sine_move(delta)
	if is_moving:
		move(x_speed,y_speed)
		pass
	if position.y > 400:
		queue_free()
	pass

func move(dir_x, dir_y):
	position.x += dir_x
	position.y += dir_y

func sine_move(delta):
	time += delta 
	var new_x = amplitude * sin(time * frequency)
	position.x = new_x
	position.y += y_speed

func shot_n_go():
	is_moving = true
	await get_tree().create_timer(1.0).timeout
	is_moving = false
	await get_tree().create_timer(1.0).timeout
	is_moving = true
	
	pass
