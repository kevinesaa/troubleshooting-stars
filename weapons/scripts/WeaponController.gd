class_name WeaponController
extends Node2D

const NORMAL_BULLET:Resource = preload("res://bullet-systems/_normal-bullet/normal_bullet.tscn")

var weapon_owner:Node2D
var bullet_speed: float = 100


static var normal_bullet_pool:PoolingSystemBase

func init_bullet_pool():
	if(normal_bullet_pool == null):
		normal_bullet_pool = PoolingSystemBase.new(NORMAL_BULLET) 
	var pool_parent_node = normal_bullet_pool.get_parent()
	if(pool_parent_node == null):
		normal_bullet_pool.call_deferred("add_pool_to_scene",get_tree().root)
		

func _ready() -> void:
	init_bullet_pool()

func shoot() -> void:
	
	if(weapon_owner != null):
		
		var bulletInstance:BulletController = normal_bullet_pool.get_object_from_pool() as BulletController
		bulletInstance.position = self.global_position
		bulletInstance.base_speed = bullet_speed
		bulletInstance.set_emitter(weapon_owner.get_bullet_emmiter_layer_type())

func _process(delta: float) -> void:
	
	
	if(weapon_owner != null):
		self.position =  weapon_owner.global_position
		
