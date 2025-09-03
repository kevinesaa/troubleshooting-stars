extends BulletController
class_name AleBullet

@onready var speed:float
@onready var angle_in_radians: float
@onready var is_degree: bool

func set_pool_container(poolContainer:PoolableObjectContainer):
	self.poolContainer = poolContainer

func back_to_pool(): 
	if(self.poolContainer != null):
		self.poolContainer.back_to_pool()

func _physics_process(delta: float) -> void:
	var ang = angle_in_radians
	var direction = Vector2(cos(ang), sin(ang))
	position += speed * direction
