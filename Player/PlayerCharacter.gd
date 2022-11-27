extends CharacterBody3D



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var current_weapon = -1
var fired_once = false

var direction = Vector3.BACK
var strafe_dir = Vector3.ZERO
var strafe = Vector3.ZERO

var aim_turn = 0

var vertical_velocity = 0
var gravity = 9.81
var weight_on_ground = 0


var movement_speed = 0
var walk_speed = 2.2
var crouch_walk_speed = 1
var run_speed = 25
var acceleration = 3
var decceleration = 6
@export var angular_acceleration = 9

var jump_magnitude = 15
var roll_magnitude = 20

var sprint_toggle = true
var sprinting = false
var is_item_in_range = false
var run_blendspace = "parameters/run/blend_position"
@onready var animovement = $AnimationTree
@onready var animachine = $AnimationPlayer.get("paramaters/playback")
@onready var bodyNode = $metarig/Skeleton3D
@onready var lowPolyGunNode = get_node("../LowPolyGun")
#onready var attachedLowPolyGunNode = get_node("metarig/Skeleton3D/BoneAttachment3D/LowPolyGun")
@onready var boneAttachment = get_node("metarig/Skeleton3D/BoneAttachment3D")
@onready var globals = get_node("/root/Globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	lowPolyGunNode.connect("gun_is_in_pickup_range", gun_in_pickup_range)
	lowPolyGunNode.connect("gun_out_of_pickup_range", gun_out_of_pickup_range)
	
func _input(event):
	if event is InputEvent:
		if (Input.is_action_pressed("pickup") and is_item_in_range):
			#attachedLowPolyGunNode.set_visible(true)
			pick_up_item()
			print('Yee haaa')
			
func pick_up_item():
	get_parent().remove_child(lowPolyGunNode)
	boneAttachment.add_child(lowPolyGunNode)
	lowPolyGunNode.position = Vector3(-0.014,0.366,-0.108)
	lowPolyGunNode.rotation = Vector3(deg_to_rad(-78.8), deg_to_rad(-12.5), deg_to_rad(173.6))


func gun_in_pickup_range():
	is_item_in_range = true
	print('coming here')

func gun_out_of_pickup_range():
	is_item_in_range = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	
	#if !$roll_timer.is_stopped(): # we only need roll_timer to change acceleration in the middle (using wait_time)
	#	acceleration = 3.5
	#else:
	acceleration = 5
	#PhysicsServer3D.area_set_param(get_viewport().find_world().space, PhysicsServer3D.AREA_PARAM_GRAVITY,0)
	#if Input.is_action_pressed("aim"):
	#	$Status/Aim.color = Color("ff6666")
	#else:
	#	$Status/Aim.color = Color("ffffff")
	
	var h_rot = $CameraRoot/h.global_transform.basis.get_euler().y
	

	
	if Input.is_action_pressed("forward") ||  Input.is_action_pressed("backward") ||  Input.is_action_pressed("left") ||  Input.is_action_pressed("right"):
		
		direction = Vector3(Input.get_action_strength("left") - Input.get_action_strength("right"),
					0,
					Input.get_action_strength("forward") - Input.get_action_strength("backward"))

		strafe_dir = direction
		
		direction = direction.rotated(Vector3.UP, h_rot).normalized()
		
		#if sprinting && $AnimationTree.get(aim_transition) == 1 && crouch_stand_target:
		movement_speed = run_speed
		#else:
		#	if crouch_stand_target:
		#		movement_speed = walk_speed
		#	else:
		#		movement_speed = crouch_walk_speed
			
	else:
		movement_speed = lerpf(movement_speed, 0, delta * decceleration)
		strafe_dir = Vector3.ZERO
		
		#if $AnimationTree.get(aim_transition) == 0:
		#direction = $Camroot/h.global_transform.basis.z
	#print('direction:',direction)
	velocity = lerp(velocity, direction * movement_speed , delta * acceleration)
	velocity.y += vertical_velocity
	#print('direction: ',direction.length())
	var _test = move_and_slide()
	globals.player_velocity = velocity
	
	if (Input.is_action_pressed("aim")):
		#bodyNode.rotation.y = lerp(bodyNode.rotation.y, $CameraRoot/h.rotation.y-rotation.y, delta * angular_acceleration)
		bodyNode.rotation.y = $CameraRoot/h.rotation.y-rotation.y
	else:
		bodyNode.rotation.y = lerp_angle(bodyNode.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
		$CollisionShape3D.rotation.y = lerp_angle($CollisionShape3D.rotation.y, atan2(direction.x, direction.z), delta * angular_acceleration)
		# Limit to 0-360 degrees, prevents overflow
		bodyNode.rotation.y = wrapf(bodyNode.rotation.y, 0.0, deg_to_rad(360.0))
		$CollisionShape3D.rotation.y = wrapf($CollisionShape3D.rotation.y, 0.0, deg_to_rad(360.0))

	#print('is_on_floor(): ',is_on_floor())
	#print('$RayCast3D.is_colliding():',$metarig/Skeleton3D/RayCast3D.is_colliding())
	if !is_on_floor() and not $metarig/Skeleton3D/RayCast3D.is_colliding():
		vertical_velocity -= gravity * delta
	#if (vertical_velocity < -30):
	#	vertical_velocity = -30
	else:
		pass#vertical_velocity = 0.15
	if (Input.is_action_just_pressed("jump") and is_on_floor()):
		#if vertical_velocity < -20:
			#roll()
		vertical_velocity = 4
		print('going in here')

	#print('is_on_floor: ',is_on_floor)
