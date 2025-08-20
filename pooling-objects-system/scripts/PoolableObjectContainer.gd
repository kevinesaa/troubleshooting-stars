class_name PoolableObjectContainer


var ownerPool:PoolingSystemBase
var objectToContain:Node

func _init(ownerPool:PoolingSystemBase,objectToContain:Node) -> void:
	self.ownerPool = ownerPool
	self.objectToContain = objectToContain
	objectToContain.set_pool_container(self)
	
func back_to_pool(): 
	ownerPool.return_object_to_pool(self)

func get_real_object() -> Node:
	return objectToContain
