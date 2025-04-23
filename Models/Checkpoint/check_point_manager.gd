extends Node3D
var last_location
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_node("Dash")
	last_location = player.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
