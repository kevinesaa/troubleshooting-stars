extends Node2D
class_name Cotufino

const BULLET_EMMITER_LAYER_TYPE:BulletController.BulletEmitter = BulletController.BulletEmitter.ENEMY

var poolContainer:PoolableObjectContainer



@onready var ale_weapon = $AleWeapon

@export var x_speed = 0
@export var y_speed = 1

#sine vars
@export var amplitude = 50
@export var frequency = 3.0
@export var time = 0.0
@onready var current_weapon: AleWeapon 
  
#shoot n go var
@export var is_moving = false

func get_bullet_emmiter_layer_type() -> BulletController.BulletEmitter:
	return self.BULLET_EMMITER_LAYER_TYPE

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
	#shot_n_go()
	ale_weapon.weapon_owner = self
	pass

func _process(delta):
	move(x_speed,y_speed)
	#sine_move(delta)
	if is_moving:
		#move(x_speed,y_speed)
		pass
	if position.y > 400:
		back_to_pool()
	ale_weapon.shoot()
	
