extends RigidBody3D

var health = 5
var _gravity := -30.0
@export_group("Movement")
@export var move_speed = 12.0
@export var acceleration := 20.0
@export var jump_impulse := 6.0
@onready var nav = $NavigationAgent3D
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
