class_name WeaponController
extends Node2D

const NORMAL_BULLET = preload("res://bullet-systems/_normal-bullet/normal_bullet.tscn")

var weapon_owner:Node2D
var bullet_speed: float = 100

func shoot() -> void:
	
	if(weapon_owner != null):
		
		var bulletInstance:BulletController = NORMAL_BULLET.instantiate()
		
		bulletInstance.position = self.position
		bulletInstance.base_speed = bullet_speed
		get_tree().root.add_child(bulletInstance)

func _process(delta: float) -> void:
	if(weapon_owner != null):
		self.position =  weapon_owner.global_position
		
