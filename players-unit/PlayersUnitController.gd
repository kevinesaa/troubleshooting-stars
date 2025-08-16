class_name PlayersUnitController
extends Node2D

@onready var player_one_node: PlayerOneController = $playerOneNode
@onready var player_two_node: PlayerTwoController = $PlayerTwoNode

func _ready() -> void:
	player_two_node.pivot_player_node = player_one_node

func _process(delta: float) -> void:
	pass
