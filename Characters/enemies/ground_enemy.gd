extends CharacterBody3D

var health = 5
var speed  = 10
var acceleration = 20
@onready var nav = $NavigationAgent3D
func _physics_process(delta):
	var direction = Vector3()
	nav.target_position = $"../Dash".global_position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	move_and_slide()
func _on_area_3d_area_entered(area):
	if area.is_in_group("player"):
		health -= 1
		print(health)
		if health == 0:
			queue_free()
