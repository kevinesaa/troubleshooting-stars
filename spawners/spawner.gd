extends Node2D

@onready var spawners: Array[Vector2] = []
static var enemy_pool:PoolingSystemBase

const COTUFINO = preload("res://enemies/cotufino/Cotufino.tscn")
@onready var player_container:PlayersUnitController = $"../playerUnitsNode"

func _ready():
	spawners = [
		Vector2(448, -32), #1
		Vector2(576, 72),
		Vector2(576, 192),
		Vector2(576, 312),
		Vector2(448, 392),
		Vector2(320, 392),
		Vector2(192, 392),
		Vector2(64, 312),
		Vector2(64, 192),
		Vector2(64, 72),
		Vector2(192, -32),
		Vector2(320, -32) #12
	]
	init_enemy_pool()

func get_spawner(position):
	return spawners[position]

func init_enemy_pool():
	if(enemy_pool == null):
		enemy_pool = PoolingSystemBase.new(COTUFINO) 
	var pool_parent_node = enemy_pool.get_parent()
	if(pool_parent_node == null):
		enemy_pool.call_deferred("add_pool_to_scene",get_tree().root)

func create_enemy():
	print("crear enemigo")
	var cotufino:Cotufino = enemy_pool.get_object_from_pool() as Cotufino
	self.player_container.player_one_position.connect(cotufino.on_player_position_listener)
	cotufino.position = self.global_position

var t:float=1
var b:bool=true

func _process(delta: float):
	t=t-delta
	if(t<=0 && b):
		b = false
		create_enemy()
	
