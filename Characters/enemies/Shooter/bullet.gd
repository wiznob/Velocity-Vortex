extends CharacterBody3D
var move_speed = 3.0
var acceleration = 100.0
var move_direction = Vector3()
var _last_movement_direction = Vector3()

func _ready():
	$AudioStreamPlayer3D.play()
	$HitBoxTimer.start()

func _physics_process(delta):
	var player = get_node("../../../Dash/CollisionShape3D")
	if player:
		var direction = (player.global_transform.origin - global_transform.origin)
		velocity = velocity.move_toward(direction * move_speed, acceleration * delta)
		move_and_slide()
		# Rotate the the bullet to face the direction of travel
		look_at(global_transform.origin + velocity, Vector3.UP)
	if is_on_wall():
		queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("PlayerHit"):
		queue_free()

func _on_timer_timeout():
	queue_free()

func _on_hit_box_timer_timeout():
	$CollisionShape3D.disabled = false
