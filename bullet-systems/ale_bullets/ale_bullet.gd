extends Area2D
class_name AleBullet

@onready var speed:float = 4
@onready var angle_in_degrees: float

var poolContainer:PoolableObjectContainer
var bullet_emitter:BulletEmitter
enum BulletEmitter {
	PLAYER = 2,
	ENEMY = 4,
}

func set_emitter(emitter:BulletEmitter) -> void:
	self.bullet_emitter = emitter
	for i in range(0, 32):
		set_collision_layer_value( i + 1,false)
	set_collision_layer_value(emitter,true)

func get_emitter() -> BulletEmitter:
	return self.bullet_emitter

func set_pool_container(poolContainer:PoolableObjectContainer):
	self.poolContainer = poolContainer

func back_to_pool(): 
	if(self.poolContainer != null):
		self.poolContainer.back_to_pool()

func _physics_process(delta: float) -> void:
	var angle_in_radians = deg_to_rad(angle_in_degrees)
	var direction = Vector2(cos(angle_in_radians), sin(angle_in_radians))
	position += speed * direction
