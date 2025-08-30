class_name PlayersUnitController
extends Node2D

@export var player_one_current_weapon: WeaponController
@export var player_two_current_weapon: WeaponController

@onready var player_one_node: PlayerOneController = $playerOneNode
@onready var player_two_node: PlayerTwoController = $PlayerTwoNode



func _ready() -> void:
	
	
	
	#region player one init
	player_one_node.current_weapon = player_one_current_weapon
	player_one_current_weapon.weapon_owner = player_one_node
	#endregion
	
	#region player two init
	player_two_node.pivot_player_node = player_one_node
	player_two_node.current_weapon = player_two_current_weapon
	player_two_current_weapon.weapon_owner = player_two_node
	#endregion
	
	player_one_node.player_one_moving.connect(player_two_node.on_player_one_moving_listener)

func _process(delta: float) -> void:
	
	pass
