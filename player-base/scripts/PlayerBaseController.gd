class_name PlayerBaseController
extends Node2D


const BULLET_EMMITER_LAYER_TYPE:BulletController.BulletEmitter = BulletController.BulletEmitter.PLAYER

var current_weapon:WeaponController


func on_press_shoot_listener(is_pressing:bool):
	if(is_pressing and current_weapon != null):
		current_weapon.shoot()

func get_bullet_emmiter_layer_type() -> BulletController.BulletEmitter:
	return self.BULLET_EMMITER_LAYER_TYPE
