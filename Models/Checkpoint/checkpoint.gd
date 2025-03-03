extends Area3D

var rotation_speed = 90
var spin = false
var checkpoint_manager

func _ready():
	checkpoint_manager = get_parent().get_parent().get_node("CheckPointManager")
	var edge_material = $CollisionShape3D/CSGCombiner3D/Edge.material
	if edge_material:
		edge_material.albedo_color = Color(1, 1, 0)
		edge_material.emission_enabled = true
		edge_material.emission = Color(1, 1, 0)
	var hole_material = $CollisionShape3D/CSGCombiner3D/Hole.material
	if hole_material:
		hole_material.albedo_color = Color(1, 1, 0)
		hole_material.emission_enabled = true
		hole_material.emission = Color(1, 1, 0)

func _process(delta):
	# Rotate After Player passes checkpoint
	if spin ==  true:
		rotation_degrees.y += rotation_speed * delta

func _on_body_entered(body):
	if body.name == "Dash":
		checkpoint_manager.last_location = $RespawnPoint.global_position
		spin = true
		# Change the material of Edge and Hole
		var edge_material = $CollisionShape3D/CSGCombiner3D/Edge.material
		if edge_material:
			edge_material.albedo_color = Color(0, 1, 0)
			edge_material.emission_enabled = true
			edge_material.emission = Color(0, 1, 0)
		var hole_material = $CollisionShape3D/CSGCombiner3D/Hole.material
		if hole_material:
			hole_material.albedo_color = Color(0, 1, 0) 
			hole_material.emission_enabled = true
			hole_material.emission = Color(0, 1, 0)
