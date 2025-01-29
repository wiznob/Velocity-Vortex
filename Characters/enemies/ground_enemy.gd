extends CharacterBody3D

var health = 5
var _gravity := -30.0
@export_group("Movement")
@export var move_speed = 12.0
@export var acceleration := 20.0
@export var jump_impulse := 6.0
@onready var nav = $NavigationAgent3D
func _physics_process(delta):
	var direction = Vector3()
	nav.target_position = $"../Dash".global_position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.move_toward(direction * move_speed, acceleration * delta)
	var wall = is_on_wall()
	if wall == true:
		velocity.y = jump_impulse
	move_and_slide()
func _on_area_3d_area_entered(area):
	if area.is_in_group("player"):
		health -= 1
		print(health)
		if health == 0:
			queue_free()
