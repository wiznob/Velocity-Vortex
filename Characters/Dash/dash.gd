extends CharacterBody3D
#Camera Exports 
@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25
var controller_sensitivity  = Global.controller_sensitivity

#Movement exports 
@export_group("Movement")
@export var move_speed = 8.0
@export var boost_speed = 12.0
@export var acceleration := 20.0
@export var rotation_speed := 12
@export var jump_impulse := 10.0
@export var wall_jump_impulse := 10.0
@export var current_jumps = 0
@export var max_jumps := 2
@export var wall_friction := 0.8
@export var max_wall_friction :=  2.0
var _camera_input_direction := Vector2.ZERO
var _gravity := -30.0
var attacking = false
var health = 3
var damage_health_value = 3 
signal i_am_dead

#Get camera ready 
@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D
@onready var damage_health = $healthBar/damageBar
@onready var timer_health = $healthBar/healthTimer

#Capture mouse when left click is pressed 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"): #Free mouse
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# handling camera movement with mouse/trackpad
func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion :=(
		event is InputEventMouseMotion and 
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity

	# increasing jump strength the longer the button is held down
	if event.is_action_released("jump"):
		if velocity.y > 0.0:
			velocity.y *= 0.5
func _physics_process(delta: float) -> void:
	#handling camera movement with controller
	var right_stick_input := Input.get_vector("right_stick_left", "right_stick_right", "right_stick_up", "right_stick_down")
	if right_stick_input != Vector2.ZERO:
		_camera_input_direction += right_stick_input * controller_sensitivity
	# rotate vertically
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 6.0, PI / 3.0)
	# rotate horizontally
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	# Set input direction back to zero
	_camera_input_direction = Vector2.ZERO

	# movement logic
	var sprint := Input.is_action_pressed("run")
	var raw_input := Input.get_vector("move_left", "move_right","move_up","move_down")
	var forward := _camera.global_basis.z
	var right := _camera.global_basis.x
	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	var y_velocity := velocity.y
	velocity.y = 0.0
	velocity = velocity.move_toward(move_direction * move_speed, acceleration * delta)
	velocity.y = y_velocity + _gravity * delta
	
	#yeahhh a sprint button works much better.....
	if sprint == true:
		move_speed = boost_speed
	else:
		move_speed = 8.0
	
	#Jump logic
	var is_starting_jump := Input.is_action_just_pressed("jump") and (is_on_floor() or current_jumps < max_jumps)
	if Input.is_action_just_pressed("jump") and is_on_wall_only():#wall jump
		var wall_normal_x = get_wall_normal().x
		var wall_normal_z = get_wall_normal().z
		var current_z_velocity = velocity.z
		var current_x_velocity = velocity.x
		# Apply bounce in the opposite direction
		velocity = get_wall_normal() * wall_jump_impulse
		velocity.y = jump_impulse
		#checking what axis the wall is not on and re applying its velocity 
		if wall_normal_x == 0:
			velocity.x = current_x_velocity
		elif wall_normal_z == 0:
			velocity.z = current_z_velocity
		#sticky jump?
		# wall_friction *= delta
	elif is_on_wall_only():#Wall run
		#velocity.x *= wall_friction
		velocity.y *= wall_friction
	elif is_starting_jump:
		velocity.y = jump_impulse
		current_jumps += 1
	elif is_on_floor():
		current_jumps = 0 #Reset jumps when on floor
	move_and_slide()

	#Rotation
	var last_input_direction = $Rotate.rotation.y
	if velocity.length() > 0.01:
		last_input_direction = atan2(-velocity.x, -velocity.z)
	$Rotate.rotation.y = lerp_angle($Rotate.rotation.y, last_input_direction, delta * rotation_speed)




	#Enabling attack box
	if Input.is_action_just_pressed("attack"):
		attacking = true
		$Rotate/AttackArea/AttackShape.disabled = false 
	else:
		attacking = false
		$Rotate/AttackArea/AttackShape.disabled = true

#Checking if attack connected
func _on_attack_area_area_entered(area):
	if area.is_in_group("enemies"):
		if is_on_floor() == false:
			velocity.y = jump_impulse
	elif area.is_in_group("BlueOrb"):
		velocity.y = 50

# Taking damage
func _on_hurt_area_area_entered(area):
	var area_position = area.global_transform.origin
	var direction = (global_transform.origin - area_position).normalized()
	if area.is_in_group("bothSides") or area.is_in_group("EnemyAttack"):
		velocity = direction * wall_jump_impulse
		velocity.y = jump_impulse
		current_jumps = 2
		health -= 1
		$healthBar.value -= 1
		timer_health.start()
		if health == 0:
			i_am_dead.emit()

func _on_health_timer_timeout():
	$healthBar/damageBar.value = health


func _on_death_checkpoint_used():
	health = 3
	$healthBar/damageBar.value = health
	$healthBar.value = health
