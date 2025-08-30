class_name BulletController
extends CharacterBody2D # implements PoolableObject


# { "players": 1, "player_bullets": 2, "enemies": 3, "enemy_bullets": 4, "bullet_collector": 5, "": 32 }
enum BulletEmitter {
	PLAYER = 2,
	ENEMY = 4
}



@export var base_speed:float

var bullet_emitter:BulletEmitter
var poolContainer:PoolableObjectContainer



func set_emitter(emitter:BulletEmitter) -> void:
	self.bullet_emitter = emitter
	for i in range(0, 32):
		self.set_collision_layer_value( i + 1,false)
	self.set_collision_layer_value(emitter,true)
	

func get_emitter() -> BulletEmitter:
	return self.bullet_emitter

func set_pool_container(poolContainer:PoolableObjectContainer):
	self.poolContainer = poolContainer
	
func back_to_pool(): 
	if(self.poolContainer != null):
		self.poolContainer.back_to_pool()
	
func _init() -> void:
	pass


func _physics_process(delta: float) -> void:
	
	var speed = base_speed * delta
	velocity = velocity + Vector2.UP * speed
	move_and_slide()
