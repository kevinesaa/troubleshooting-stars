extends Node2D
class_name Cotufino
const BULLET_EMMITER_LAYER_TYPE:BulletController.BulletEmitter = BulletController.BulletEmitter.ENEMY
var poolContainer:PoolableObjectContainer

@export var x_speed = 0
@export var y_speed = 1

#sine vars
@export var amplitude = 50
@export var frequency = 3.0
@export var time = 0.0

#shoot n go var
@export var is_moving = false

# bullet patterns
const ALE_BULLET = preload("res://bullet-systems/ale_bullets/AleBullet.tscn")
var wait_shot = 80.0
var attack_speed = 0.0

func get_bullet_emmiter_layer_type() -> BulletController.BulletEmitter:
	return self.BULLET_EMMITER_LAYER_TYPE


func shoot():
	attack_speed-=1.0
	if attack_speed <=0.0:
		attack_speed = wait_shot
		for i in 9:
			var bulletInstance = ALE_BULLET.instantiate()
			bulletInstance.position = self.position
			bulletInstance.angle_in_degrees = 22.5 * i
			get_tree().root.add_child(bulletInstance)
			

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

func set_pool_container(poolContainer:PoolableObjectContainer):
	self.poolContainer = poolContainer

func back_to_pool(): 
	if(self.poolContainer != null):
		self.poolContainer.back_to_pool()

func _ready():
	shot_n_go()

func _process(delta):
	#move(x_speed,y_speed)
	#sine_move(delta)
	if is_moving:
		#move(x_speed,y_speed)
		pass
	if position.y > 400:
		queue_free()
	shoot()
