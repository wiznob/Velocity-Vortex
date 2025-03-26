extends CharacterBody3D
var follow_player = false
var shoot_mode = false
var health = 5
var _gravity := -30.0
var direction = Vector3()
@export var spawn_bullet = preload("res://Characters/enemies/Shooter/bullet.tscn")
@export_group("Movement")
@export var max_jumps = 1
@export var move_speed = 6.0
@export var backup_speed = 3.0
@export var acceleration := 20.0
@export var jump_impulse := 6.0
@export var Knockback := 12
@onready var nav = $NavigationAgent3D
func _physics_process(delta):
	var wall = is_on_wall()
	if wall == true and max_jumps > 0:
		velocity.y = jump_impulse
		max_jumps -= 1
	elif is_on_floor_only():
		max_jumps = 1
	# entered follow range
	if follow_player == true:
		var y_velocity := velocity.y
		velocity.y = 0.0
		velocity.y = y_velocity + _gravity * delta
		var direction_neg = Vector3()
		nav.target_position = $"../../Dash".global_position
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)
		move_and_slide()
	# entered shooting range
	elif shoot_mode == true:
		var y_velocity := velocity.y
		velocity.y = 0.0
		velocity.y = y_velocity + _gravity * delta
		var direction_neg = Vector3()
		nav.target_position = $"../../Dash".global_position
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		direction_neg = - direction
		velocity = velocity.move_toward(direction_neg * backup_speed, acceleration * delta)
		move_and_slide()
	else:
		var y_velocity := velocity.y
		velocity.y = 0.0
		velocity.y = y_velocity + _gravity * delta
		move_and_slide()

func spawn():
	if $SpawnTimer.is_stopped() == true:
		$SpawnTimer.start()
		var obj = spawn_bullet.instantiate()
		add_child(obj)
	elif $SpawnTimer.is_stopped() == false:
		pass

#taking damage
func _on_area_3d_area_entered(area):
	if area.is_in_group("player") or area.is_in_group("bothSides"):
		var area_position = area.global_transform.origin
		var direction = (global_transform.origin - area_position).normalized()
		velocity = direction * Knockback
		velocity.y = jump_impulse
		health -= 1
		print(health)
		if health == 0:
			queue_free()

# Follow the player 
func _on_tracking_area_body_entered(body):
	if body.name == "Dash":
		follow_player = true

#Too far to follow
func _on_tracking_area_body_exited(body):
	if body.name == "Dash":
		follow_player = false

#Close enough to shoot
func _on_shooting_area_body_entered(body):
	if body.name == "Dash":
		follow_player = false
		shoot_mode = true
		spawn()
		

#Too far to shoot
func _on_shooting_area_body_exited(body):
	if body.name == "Dash":
		follow_player = true
		shoot_mode = false
