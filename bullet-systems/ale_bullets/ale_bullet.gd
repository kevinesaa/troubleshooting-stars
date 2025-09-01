extends BulletController
class_name AleBullet

@onready var speed:float = 4
@onready var angle_in_degrees: float
@onready var is_degree: bool

func set_pool_container(poolContainer:PoolableObjectContainer):
	self.poolContainer = poolContainer

func back_to_pool(): 
	if(self.poolContainer != null):
		self.poolContainer.back_to_pool()

func _physics_process(delta: float) -> void:
	var angle_in_radians = deg_to_rad(angle_in_degrees)
	var direction = Vector2(cos(angle_in_radians), sin(angle_in_radians))
	position += speed * direction
