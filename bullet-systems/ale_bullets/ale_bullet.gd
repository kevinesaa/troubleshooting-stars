extends CharacterBody2D

@onready var speed:float = 80

@onready var angle_in_degrees: float

func _physics_process(delta: float) -> void:
	var angle_in_radians = deg_to_rad(angle_in_degrees)
	var direction = Vector2(cos(angle_in_radians), sin(angle_in_radians))
	velocity = speed * direction
	move_and_slide()

func back_to_pool(): 
	print("regrea al pool")
	
