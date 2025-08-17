class_name BulletController
extends CharacterBody2D


@export var base_speed:float

func back_to_pool(): 
	print("regrea al pool")
	

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	
	var speed = base_speed * delta
	
	velocity = velocity + Vector2.UP * speed
	move_and_slide()
