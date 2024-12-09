extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		visible = true
		get_tree().paused = true


func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")


func _on_resume_pressed():
	visible = false 
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_restart_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	visible = false
