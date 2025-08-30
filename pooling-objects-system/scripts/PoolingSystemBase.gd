class_name PoolingSystemBase
extends Node

var pooledObjects:Array[PoolableObjectContainer]
var min_capacity:int
var class_resource:Resource

#var current_task_id:int = -1
var thread_for_massive_object_create:Thread
var mutex_for_massive_object_create: Mutex

func _exit_tree():
	if(thread_for_massive_object_create != null && thread_for_massive_object_create.is_alive()):
		thread_for_massive_object_create.wait_to_finish()

func _init(class_resource:Resource, capacity:int=100) -> void:
	self.min_capacity = maxi(100,capacity)
	self.class_resource = class_resource
	self.pooledObjects = []
	
	while( self.pooledObjects.size() < self.min_capacity  ):
		var container = build_poolable_instance()
		self.pooledObjects.append(container)


func add_pool_to_scene(node:Node):
	var current_parent = self.get_parent()
	if(current_parent!=null):
		current_parent.remove_child(self)
	node.add_child(self)
	
func _ready() -> void:
	mutex_for_massive_object_create = Mutex.new()

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
		create_instances_massive_to_pool()
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
	
	
func create_instances_massive_to_pool():
	
	if(
		thread_for_massive_object_create == null
		|| (thread_for_massive_object_create.is_started() 
			&& !thread_for_massive_object_create.is_alive()
		)
	):
		if(thread_for_massive_object_create != null):
			thread_for_massive_object_create.wait_to_finish()
	
		thread_for_massive_object_create = Thread.new()
		# WorkerThreadPool.
	
	if(!thread_for_massive_object_create.is_started()):
		thread_for_massive_object_create.start(create_instaces_async)
	

func create_instaces_async():
	
	var new_ojects:Array[PoolableObjectContainer] = []
	
	for i in(min_capacity):
		var instance:PoolableObjectContainer = build_poolable_instance()
		new_ojects.append(instance)
	
	mutex_for_massive_object_create.lock()

	self.pooledObjects.append_array(new_ojects)
	
	mutex_for_massive_object_create.unlock()
	
