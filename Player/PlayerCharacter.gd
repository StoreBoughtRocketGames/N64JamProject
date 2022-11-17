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
var gravity = 28
var weight_on_ground = 0


var movement_speed = 0
var walk_speed = 2.2
var crouch_walk_speed = 1
var run_speed = 10
var acceleration = 6
var decceleration = 4
@export var angular_acceleration = 18

var jump_magnitude = 15
var roll_magnitude = 20

var sprint_toggle = true
var sprinting = false
var is_gun_in_range = false
var run_blendspace = "parameters/run/blend_position"
@onready var animovement = $AnimationTree
@onready var animachine = $AnimationPlayer.get("paramaters/playback")
@onready var bodyNode = $metarig/Skeleton3D
@onready var lowPolyGunNode = get_node("../LowPolyGun")
@onready var attachedLowPolyGunNode = get_node("metarig/Skeleton3D/BoneAttachment3D/LowPolyGun")
@onready var globals = get_node("/root/Globals")

# Called when the node enters the scene tree for the first time.
func _ready():
	lowPolyGunNode.connect("gun_is_in_pickup_rnage", pick_up_gun)

func _input(event):
	if event is InputEvent:
		if (Input.is_action_pressed("pickup") and is_gun_in_range):
			attachedLowPolyGunNode.set_visible(true)
			print('Yee haaa')
			
			
func pick_up_gun():
	is_gun_in_range = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	
	#if !$roll_timer.is_stopped(): # we only need roll_timer to change acceleration in the middle (using wait_time)
	#	acceleration = 3.5
	#else:
	acceleration = 5
	
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

		#$PlayerCharacter.rotation.y = lerp_angle($PlayerCharacter.rotation.y, atan2(direction.x, direction.z) - rotation.y, delta * angular_acceleration)
		
	if !is_on_floor():
		vertical_velocity -= gravity * delta
	#if (vertical_velocity < -30):
	#	vertical_velocity = -30
	else:
		#if vertical_velocity < -20:
			#roll()
		vertical_velocity = 0
	#print('is_on_floor: ',is_on_floor)
