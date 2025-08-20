class_name PoolingSystemBase
extends Node

var pooledObjects:Array[PoolableObjectContainer]
var min_capacity:int
var class_resource:Resource

func _init(class_resource:Resource, capacity:int=1000) -> void:
	self.min_capacity = mini(100,capacity)
	self.class_resource = class_resource
	self.pooledObjects = []
	
	while( self.pooledObjects.size() < self.min_capacity  ):
		var container = build_poolable_instance()
		self.pooledObjects.append(container)


	
func _ready() -> void:
	pass #get_tree().root.add_child(self)

func build_poolable_instance() -> PoolableObjectContainer:
	var object:Node = self.class_resource.instantiate()
	object.set_process(false)
	object.set_physics_process(false)
	object.set_process_input(false)
	return PoolableObjectContainer.new(self,object)

func get_object_from_pool() -> Node:
	
	var container:PoolableObjectContainer
	if(pooledObjects.is_empty()):
		container = build_poolable_instance()
	else:
		container = pooledObjects.pop_front()
	
	var object = container.get_real_object()
	object.set_process(true)
	object.set_physics_process(true)
	object.set_process_input(true)
	# get.root.add_child(object)
	add_child(object)
	return object

func return_object_to_pool(poolable:PoolableObjectContainer):
	
	var object = poolable.get_real_object()
	var parent = object.get_parent()
	
	object.set_process(false)
	object.set_physics_process(false)
	object.set_process_input(false)
	parent.remove_child(object)
	
	pooledObjects.push_back(poolable)
	
