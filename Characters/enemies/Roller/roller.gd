extends RigidBody3D
var direction
var follow_player = false
var self_destruct = false
var died = false
var health = 1
signal blowup

#Movement Exports
@export_group("Movement")
@export var knockback = 10.0
@export var move_speed = 12.0
@onready var nav = $NavigationAgent3D
@onready var floor_ray = $FloorRay
@onready var wall_ray = $WallRay

func _physics_process(_delta):
	player_kill()
	#despawn after blow up effect
	if died == true and health == 1:
		I_died()
		died = false 
		health = 0
		# Tracking the player 
	if follow_player == true:
		direction = Vector3()
		nav.target_position = $"../../Dash".global_position
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		var force = direction.normalized() * move_speed
		apply_central_force(force)

#Getting and apply knockback when hit
func get_knockback_direction():
	nav.target_position = $"../../Dash".global_position
	return (global_transform.origin - nav.target_position).normalized()
	
func apply_knockback():
	direction = get_knockback_direction()
	direction.y = 1.0  # for vertical knockback
	direction = direction.normalized()
	var impulse = direction * knockback
	apply_central_impulse(impulse)

# Will run if hit by a player
func player_kill():
	if self_destruct == true and (floor_ray.is_colliding() or wall_ray.is_colliding()):
		$AudioStreamPlayer3D.play()
		$Explosion.play_effect()
		$MeshInstance3D.visible = false 
		$eye.visible = false
		died = true

# Enabling raycast after 0.5 seconds 
func _on_timer_timeout():
	floor_ray.enabled = true
	wall_ray.enabled = true 

# Check if player is with tracking area 
func _on_tracking_area_body_entered(body):
	if body.name == "Dash":
		follow_player = true

# Check if the player left the area 
func _on_tracking_area_body_exited(body):
	if body.name == "Dash":
		follow_player = false
		
# Check if hit by the player and launch backwards
func _on_hurt_box_area_entered(area):
	if area.is_in_group("player"):
		follow_player = false
		apply_knockback()
		self_destruct = true
		#Timer exist to stop instant explosion and turn on ray cast (line 54)
		$Timer.start()

#start despawn timer
func I_died():
	$DespawnTimer.start()

func _on_despawn_timer_timeout():
	queue_free()

#Touched player without getting hit
func _on_body_entered(body):
	if body.name == "Dash":
		emit_signal("blowup")

#If it hits the player first blow up instantly 
func _on_blowup():
		$AudioStreamPlayer3D.play()
		$AttackBox/AttackShape.call_deferred("set_disabled", false)
		$Explosion.play_effect()
		$MeshInstance3D.visible = false 
		$eye.visible = false
		died = true
