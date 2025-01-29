extends CharacterBody3D

var health = 5
var follow_player = false
var hit = false
var _gravity := -30.0
var knockback = 40
@export_group("Movement")
@export var move_speed = 6.0
@export var acceleration := 20.0
@export var jump_impulse := 6.0
@onready var nav = $NavigationAgent3D
func _physics_process(delta):
	if follow_player == true:
		var direction = Vector3()
		nav.target_position = $"../Dash".global_position
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)
		var wall = is_on_wall()
		if hit == true:
			velocity = get_wall_normal() * knockback
			velocity.y = jump_impulse
		if wall == true:
			velocity.y = jump_impulse
		move_and_slide()
		
func _on_hurt_box_area_entered(area):
	if area.is_in_group("player"):
		hit = true
		follow_player = false
		health -= 1
		print(health)
		if health == 0:
			queue_free()
func _on_tracking_area_body_entered(body):
	if body.name == "Dash":
		follow_player = true

func _on_tracking_area_body_exited(body):
	if body.name == "Dash":
		follow_player = false
