extends Label

@export var duration: float = 20

func _ready() -> void:
	var start_pos = Vector2(position.x, get_viewport_rect().size.y)
	var end_pos = Vector2(position.x, -size.y)
	position = start_pos
	var tween = get_tree().create_tween()
	tween.tween_property(self, "position", end_pos, duration)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)
	# Switch scene when animation completes
	tween.tween_callback(change_scene)
func _physics_process(_delta):
	if Input.is_action_just_pressed("skip") or Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("left_click"):
		get_tree().change_scene_to_file("res://UI/MainMenu.tscn")

func change_scene() -> void:
	get_tree().change_scene_to_file("res://UI/MainMenu.tscn")
