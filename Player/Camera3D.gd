extends Node3D

var camrot_h = 0
var camrot_v = 0
var cam_v_max = 0.5
var cam_v_min = -0.35
var h_sensitivity = 0.35
var v_sensitivity = 0.15
var h_acceleration = .05
var v_acceleration = .5
var h_deceleration = .1
var v_deceleration = .025
var rotation_v
var rotation_h

@onready var mouseTimerNode = $"../mouseTimer"
@onready var bodyNode = get_node("../metarig/Skeleton3D/Body")
@onready var globals = get_node("/root/Globals")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$h/v/Camera.add_exception(get_parent())

func _input(event):
	if event is InputEventMouseMotion:
		mouseTimerNode.start()
		camrot_h += -event.relative.x * h_sensitivity
		camrot_v += event.relative.y * v_sensitivity
	else:
		camrot_h = lerpf(camrot_h, 0, h_deceleration)
		
func _physics_process(delta):
	
	camrot_v = clamp(camrot_v, -.5, 1)
	#print('camrot_v: ',camrot_v)
	var mesh_front = bodyNode.global_transform.basis.z
	var rot_speed_multiplier = 25 #reduce this to make the rotation radius larger
	var auto_rotate_speed =  (PI - mesh_front.angle_to($h.global_transform.basis.z)) * rot_speed_multiplier * globals.player_velocity.length() * rot_speed_multiplier
	#print('player_velocity: ',globals.player_velocity)
	if mouseTimerNode.is_stopped():
		#FOLLOW CAMERA
		rotation_v = rad_to_deg($h.rotation.y)
		$h.rotation.y= lerp_angle($h.rotation.y, get_node("../metarig/Skeleton3D/Body").global_transform.basis.get_euler().y, delta * auto_rotate_speed)
		camrot_h = $h.rotation.y
	else:
		#MOUSE CAMERA
		rotation_v = rad_to_deg($h.rotation.y)
		$h.rotation.y = lerpf($h.rotation.y, camrot_h, delta * h_acceleration)
		camrot_h = lerpf(camrot_h, 0, h_deceleration)

	$h/v.rotation.x = lerpf($h/v.rotation.x, camrot_v, delta * v_acceleration)
	$h/v.rotation.x = clamp($h/v.rotation.x, cam_v_min, cam_v_max)
	$h/v.rotation.x = lerpf($h/v.rotation.x, 0, v_deceleration)
	#print('$h/v.rotation.x: ',$h/v.rotation.x)
