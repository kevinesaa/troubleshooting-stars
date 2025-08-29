class_name MainMenuController
extends Node

var is_loading_next_scene:bool = false
var is_showing_credits:bool = false
var is_next_scene_ready:bool = false

@export var debug_loading:bool = false
func debug_loading_print(new_value:float)->void:
	if(debug_loading):
		print(str("current progress loading scene: ",new_value))


@export var progress_steps_speed:float = 0.2
@export var path_to_next_scene:String = "res://levels/001-level/level001.tscn"

# solo se usa en la forma 2
#const LEVEL_001 = preload(path_to_next_scene)

var progress_loading_scene:float = 0.0
signal progressing_loading_scene_updated(new_value:float)
signal progressing_loading_scene_completed() 

func _process(delta: float) -> void:
	
	if(is_loading_next_scene):
		
		if(self.progress_loading_scene < 1.0):
			var value_before_update:float = self.progress_loading_scene
			loading_status_update(delta)
			if(value_before_update != self.progress_loading_scene):
				self.progressing_loading_scene_updated.emit(self.progress_loading_scene)
				return
		
		if( !self.is_next_scene_ready && self.progress_loading_scene >= 1.0):
			self.is_next_scene_ready = true
			self.progressing_loading_scene_completed.emit()
	else:
		
		var is_press_new_game = Input.is_action_just_pressed("main_menu_new_game")
		var is_press_credits = Input.is_action_just_pressed("main_menu_credits")
		
		if(is_press_credits):
			toggle_show_credits()
			return
		
		if(is_press_new_game):
			start_new_game()

func start_new_game() -> void:
	if(!is_loading_next_scene && !is_showing_credits):
		is_loading_next_scene = true
		load_package_scene()

#
#func change_scene_form1():
	#get_tree().change_scene_to_file(path_to_next_scene)
#
## con scenas pre-cargadas
#func change_scene_form2():
	#get_tree().change_scene_to_packed(LEVEL_001)


func on_next_scene_ready_listener() -> void:
	change_scene()

func change_scene() -> void:
	get_tree().change_scene_to_packed(
		ResourceLoader.load_threaded_get(
			path_to_next_scene
		)
	)
	
func load_package_scene() -> void:
	ResourceLoader.load_threaded_request(path_to_next_scene)

func loading_status_update(delta:float) -> void:
	
	var value_after_update:float = self.progress_loading_scene
	var progress_array:Array[float]
	var next_progress_value:float
	ResourceLoader.load_threaded_get_status(path_to_next_scene,progress_array)
	next_progress_value = progress_array[0]
	if(next_progress_value != self.progress_loading_scene):
		
		var current = lerp(self.progress_loading_scene,next_progress_value,delta)
		var factor:float = 0.5
		if (next_progress_value < 1.0 ):
			var diff:float = 0.9 - current
			factor = clamp(diff, 0.0, 1.0)
		
		var value = factor * delta * self.progress_steps_speed 
		value_after_update = current + value
	
	self.progress_loading_scene = clamp(value_after_update, 0.0, 1.0)
	
	

func toggle_show_credits() -> void:
	if(is_showing_credits):
		hide_credits()
		is_showing_credits = false
	else:
		show_credits()
		is_showing_credits = true

func show_credits() -> void:
	pass

func hide_credits() -> void:
	pass
