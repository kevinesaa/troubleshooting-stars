class_name AleWeapon
extends Node2D

const ALE_BULLET:Resource = preload("res://bullet-systems/ale_bullets/AleBullet.tscn")

@onready var weapon_owner:Node2D
var bullet_speed: float = 100

var wait_shot = 90.0
var attack_speed = 0.0

var bullet_quantity=0
var bullet_dist=0
var initial_point=0
var final_point=0

static var bullet_pool:PoolingSystemBase


func pattern_one() -> void: #fixed
	var quantity = 9
	var ang_initial:float = 0.0
	var ang_final:float = 180.0
	var step = (ang_final - ang_initial) / (quantity - 1)
	
	for index in quantity:
		var ang = ang_initial + index * step
		create_bullet(ang)

func pattern_two(player_position: Vector2) -> void: #aimed
	var quantity = 3
	print(player_position)
	var direction_vector = player_position - self.global_position
	var ang = atan2(direction_vector.y,direction_vector.x)
	for index in quantity:
		create_bullet(ang)

func pattern_three(player_position: Vector2) -> void: #aimed cono
	var quantity = 3
	print(player_position)
	var direction_vector = player_position - self.global_position
	var ang = atan2(direction_vector.y,direction_vector.x)
	for index in quantity:
		create_bullet(ang)

func shoot() -> void:
	if(weapon_owner != null):
		attack_speed-=1.0
		if attack_speed <=0.0:
			attack_speed = wait_shot
			pattern_one()

func aimed_shot(position) -> void:
	if(weapon_owner != null):
		attack_speed-=1.0
		if attack_speed <=0.0:
			attack_speed = wait_shot
			pattern_two(position)

func create_bullet(ang) -> void:
	var bulletInstance:AleBullet = bullet_pool.get_object_from_pool() as AleBullet
	bulletInstance.position = self.global_position
	bulletInstance.angle_in_degrees = ang
	bulletInstance.speed = randf_range(1.0,.0)
	bulletInstance.set_emitter(weapon_owner.get_bullet_emmiter_layer_type())

func create_bullet_rnd(ang) -> void:
	var bulletInstance:AleBullet = bullet_pool.get_object_from_pool() as AleBullet
	bulletInstance.position = self.global_position
	bulletInstance.angle_in_degrees = ang
	#set speed rnd6
	bulletInstance.set_emitter(weapon_owner.get_bullet_emmiter_layer_type())



func init_bullet_pool():
	if(bullet_pool == null):
		bullet_pool = PoolingSystemBase.new(ALE_BULLET) 
	var pool_parent_node = bullet_pool.get_parent()
	if(pool_parent_node == null):
		bullet_pool.call_deferred("add_pool_to_scene",get_tree().root)

func _ready() -> void:
	init_bullet_pool()
