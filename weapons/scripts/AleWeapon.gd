class_name AleWeapon
extends Node2D

const ALE_BULLET:Resource = preload("res://bullet-systems/ale_bullets/AleBullet.tscn")

@onready var weapon_owner:Node2D
var bullet_speed: float = 100

var wait_shot = 100.0
var attack_speed = 0.0

var bullet_quantity=0
var bullet_dist=0
var initial_point=0
var final_point=0

static var bullet_pool:PoolingSystemBase

func shoot() -> void:
	#wait_shot recomendado: 100
	if(weapon_owner != null):
		attack_speed-=1.0
		if attack_speed <=0.0:
			attack_speed = wait_shot
			pattern_one(0.0,360.0)

func spiral_shot() -> void:
	#wait_shot recomendado: 5 o 10... 30 también
	if(weapon_owner != null):
		attack_speed-=1.0
		if attack_speed <=0.0:
			attack_speed = wait_shot
			pattern_two()

func aimed_shot(position) -> void:
	#wait_shot recomendado: 100
	if(weapon_owner != null):
		attack_speed-=1.0
		if attack_speed <=0.0:
			attack_speed = wait_shot
			var direction_vector = position - self.global_position
			pattern_three(atan2(direction_vector.y,direction_vector.x))
			#pattern_four(atan2(direction_vector.y,direction_vector.x))
			#patron four tambien puede ser llamado desde el patron 3
			

func pattern_one(ang_initial:float,ang_final:float) -> void: #fixed
	var quantity = 17
	var step = (ang_final - ang_initial) / (quantity - 1)
	for index in quantity:
		var ang_deg = ang_initial + index * step
		create_bullet(deg_to_rad(ang_deg),2.0)

var spiral_ang_initial = 90.0
var spiral_ang_base = 2.0
func pattern_two() -> void: #spiral
	spiral_ang_initial += spiral_ang_base
	var quantity = 19
	var spiral_dist=360/quantity
	for index in quantity:
		var bullet_angle =(spiral_dist * index) + spiral_ang_initial
		
		create_bullet(deg_to_rad(bullet_angle),3.0)#+randf_range(2.0,3.0))

func pattern_three(player_ang: float) -> void: #aimed en filas/conos
	var quantity = 5 #prueba: 1, 2 y 5
	if quantity > 1:
		var amp=30
		var diff = 2 * amp 
		var steps=diff / (quantity-1)
		
		var ang_deg = rad_to_deg(player_ang)
		var ang_i=ang_deg-amp 
		for index in quantity:
			#create_bullet(deg_to_rad(ang_i+index*steps),1.5)
			#comenta la anterior y descomenta la siguiente. Waitshot en 200
			pattern_four(deg_to_rad(ang_i+index*steps))
	else:
		create_bullet(player_ang,5.5)#waitshot en 20

func pattern_four(player_ang: float) -> void: #aimed en columnas
	#CUIDADO este patron escala la velocidad en base a la cantidad que haya 
	var quantity = 3
	var base = 0.8
	for index in quantity:
		var speed = base+0.4*index
		create_bullet(player_ang,speed)

func create_bullet(ang:float,speed:float) -> void:
	var bulletInstance:AleBullet = bullet_pool.get_object_from_pool() as AleBullet
	bulletInstance.position = self.global_position
	bulletInstance.position = self.global_position
	bulletInstance.angle_in_radians = ang
	bulletInstance.speed = speed #+ randf_range(0, 2.0)
	bulletInstance.set_emitter(weapon_owner.get_bullet_emmiter_layer_type())

func init_bullet_pool():
	if(bullet_pool == null):
		bullet_pool = PoolingSystemBase.new(ALE_BULLET) 
	var pool_parent_node = bullet_pool.get_parent()
	if(pool_parent_node == null):
		bullet_pool.call_deferred("add_pool_to_scene",get_tree().root)

func _ready() -> void:
	init_bullet_pool()
