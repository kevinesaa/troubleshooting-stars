class_name BulletController
extends CharacterBody2D # implements PoolableObject

enum BulletEmitter {
	PLAYER,
	ENEMY
}

@export var base_speed:float

var bullet_emitter:BulletEmitter
var poolContainer:PoolableObjectContainer

func set_emitter(emitter:BulletEmitter) -> void:
	self.bullet_emitter = emitter
	#todo set collision layer

func get_emitter() -> BulletEmitter:
	return self.bullet_emitter

func get_emiiter_collision_layer():
	pass

 
func set_pool_container(poolContainer:PoolableObjectContainer):
	self.poolContainer = poolContainer
	
func back_to_pool(): 
	if(self.poolContainer != null):
		self.poolContainer.back_to_pool()
	
	

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	
	var speed = base_speed * delta
	velocity = velocity + Vector2.UP * speed
	move_and_slide()
