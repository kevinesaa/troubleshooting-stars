class_name AleWeapon
extends Node2D

const ALE_BULLET:Resource = preload("res://bullet-systems/ale_bullets/AleBullet.tscn")

@onready var weapon_owner:Node2D
var bullet_speed: float = 100

var wait_shot = 10.0
var attack_speed = 0.0

static var bullet_pool:PoolingSystemBase

func shoot() -> void:
	if(weapon_owner != null):
		attack_speed-=1.0
		if attack_speed <=0.0:
			attack_speed = wait_shot
			for index in 9:
				create_bullet(index)

func create_bullet(index) -> void:
	var bulletInstance:AleBullet = bullet_pool.get_object_from_pool() as AleBullet
	bulletInstance.position = self.global_position
	bulletInstance.angle_in_degrees = 22.5 * index
	bulletInstance.set_emitter(weapon_owner.get_bullet_emmiter_layer_type())
	pass

func init_bullet_pool():
	if(bullet_pool == null):
		bullet_pool = PoolingSystemBase.new(ALE_BULLET) 
	var pool_parent_node = bullet_pool.get_parent()
	if(pool_parent_node == null):
		bullet_pool.call_deferred("add_pool_to_scene",get_tree().root)

func _ready() -> void:
	init_bullet_pool()

func _process(delta: float) -> void:
	if(weapon_owner != null):
		self.position =  weapon_owner.global_position
		#shoot()
