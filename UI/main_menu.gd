extends Control

# const MOUSE_SPEED = 500.0

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/test-Level.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://UI/Options/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _input(event):
	pass
	
func _physics_process(delta):
	pass
	#WARNING this code will not work on Gnome wayland. the mouse will not update viusaly
	#var left_stick_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#var mouse_pos = get_global_mouse_position()
	#print(mouse_pos)
	#get_viewport().warp_mouse(round(get_global_mouse_position() + left_stick_input * MOUSE_SPEED * delta))
