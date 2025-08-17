extends Node2D


@export var hedge_factor: float = 1.5

@onready var line_2d: Line2D = $Line2D

@onready var up_ray_cast_2d: RayCast2D = $up_RayCast2D
@onready var right_ray_cast_2d: RayCast2D = $right_RayCast2D
@onready var down_ray_cast_2d: RayCast2D = $down_RayCast2D
@onready var left_ray_cast_2d: RayCast2D = $left_RayCast2D

var raycast_array : Array[RayCast2D]

var center_screen:Vector2
var distance:float = 0

func on_resize_screen_listener()->void:
	print("on resize")
	resize_hedge()
	corner_position()
	draw_hedge()

func  resize_hedge():
	
	var viewport = get_viewport()
	var size = viewport.size
	center_screen = abs(size / 2)
	var r = size.x * size.x + size.y * size.y
	var d = max(distance, sqrt( r ) )
	
	if (distance != d):
		distance =  d + d * hedge_factor
		distance = ceil(distance)
		
	

func corner_position()->void:
	up_ray_cast_2d.position = center_screen + distance * Vector2.UP
	right_ray_cast_2d.position = center_screen + distance * Vector2.RIGHT
	down_ray_cast_2d.position = center_screen + distance * Vector2.DOWN
	left_ray_cast_2d.position = center_screen + distance * Vector2.LEFT

func draw_hedge() -> void:
	up_ray_cast_2d.target_position =  right_ray_cast_2d.position - up_ray_cast_2d.position
	right_ray_cast_2d.target_position = down_ray_cast_2d.position - right_ray_cast_2d.position
	down_ray_cast_2d.target_position = left_ray_cast_2d.position - down_ray_cast_2d.position
	left_ray_cast_2d.target_position = up_ray_cast_2d.position - left_ray_cast_2d.position
	
	line_2d.clear_points()
	line_2d.add_point(up_ray_cast_2d.position)
	line_2d.add_point(right_ray_cast_2d.position)
	line_2d.add_point(down_ray_cast_2d.position)
	line_2d.add_point(left_ray_cast_2d.position)
	line_2d.add_point(up_ray_cast_2d.position)
	
func _ready() -> void:
	raycast_array.append(up_ray_cast_2d)
	raycast_array.append(right_ray_cast_2d)
	raycast_array.append(down_ray_cast_2d)
	raycast_array.append(left_ray_cast_2d)
	resize_hedge()
	corner_position()
	draw_hedge()
	get_viewport().size_changed.connect(on_resize_screen_listener)

func _physics_process(delta: float) -> void:
	for ray in raycast_array:
		if(ray.is_colliding()):
			var collider = ray.get_collider()
			if(collider is BulletController):
				collider = collider as BulletController
				collider.back_to_pool()
			
