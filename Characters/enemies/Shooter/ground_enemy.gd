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
	velocity.y += _gravity * delta
	#face player
	if follow_player or shoot_mode:
		var player_position = $"../../Dash".global_position
		player_position.y = global_transform.origin.y
		look_at(player_position, Vector3.UP)

	#if it gets stuck on a ledge
	var wall = is_on_wall()
	if wall == true and max_jumps > 0:
		velocity.y = jump_impulse
		max_jumps -= 1
	elif is_on_floor_only():
		max_jumps = 1
	# entered follow range
	if follow_player == true:
		nav.target_position = $"../../Dash".global_position
		direction = (nav.get_next_path_position() - global_position).normalized()
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)
	elif shoot_mode == true:
		nav.target_position = $"../../Dash".global_position
		direction = (nav.get_next_path_position() - global_position).normalized()
		velocity = velocity.move_toward(-direction * backup_speed, acceleration * delta)
		
	move_and_slide()
#make bullet
func spawn():
	if $SpawnTimer.is_stopped():
		$SpawnTimer.start()

#take damage when hit within hurtbox
func _on_area_3d_area_entered(area):
	if area.is_in_group("player") or area.is_in_group("bothSides"):
		$SpawnTimer.start()
		var area_position = area.global_transform.origin
		var hit_direction = (global_transform.origin - area_position).normalized()
		velocity = hit_direction * Knockback
		velocity.y = jump_impulse
		health -= 1
		if health == 0:
			queue_free()
# Follow player
func _on_tracking_area_body_entered(body):
	if body.name == "Dash":
		follow_player = true
# Too far to follow
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
		$SpawnTimer.stop()


func _on_spawn_timer_timeout():
		var bullet_instance = spawn_bullet.instantiate()
		add_child(bullet_instance)
		spawn()
