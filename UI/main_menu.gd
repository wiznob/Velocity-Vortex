extends Control
@export_group("ControllerMenu")
@export_range(0.0, 3.0) var controller_sensitivity := 2.00
var _mouse_input_direction := Vector2.ZERO

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Levels/test-Level.tscn")


func _on_options_pressed():
	get_tree().change_scene_to_file("res://UI/Options/Options.tscn")


func _on_quit_pressed():
	get_tree().quit()

func _physics_process(delta):
	print(get_global_mouse_position())
	var left_stick_input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if left_stick_input != Vector2.ZERO:
		_mouse_input_direction += left_stick_input * controller_sensitivity
		Input.warp_mouse(get_global_mouse_position() * _mouse_input_direction * delta)
