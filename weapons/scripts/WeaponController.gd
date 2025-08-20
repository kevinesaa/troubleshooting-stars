class_name WeaponController
extends Node2D

const NORMAL_BULLET:Resource= preload("res://bullet-systems/_normal-bullet/normal_bullet.tscn")

var weapon_owner:Node2D
var bullet_speed: float = 100


static var normal_bullet_pool:PoolingSystemBase
static func _static_init():
	normal_bullet_pool = PoolingSystemBase.new(NORMAL_BULLET) 

func _ready() -> void:
	var pool_parent_node = normal_bullet_pool.get_parent()
	if(pool_parent_node == null):
		get_tree().root.add_child(pool_parent_node)

func shoot() -> void:
	
	if(weapon_owner != null):
		
		var bulletInstance:BulletController = normal_bullet_pool.get_object_from_pool() as BulletController
		bulletInstance.position = self.global_position
		bulletInstance.base_speed = bullet_speed
		print(str(bulletInstance.position))

func _process(delta: float) -> void:
	if(weapon_owner != null):
		self.position =  weapon_owner.global_position
		
