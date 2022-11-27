extends Node3D

var camrot_h = 0
var camrot_v = 0
var cam_v_max = 5#deg_to_rad(220)
var cam_v_min = -5#deg_to_rad(-220)
var h_sensitivity = 0.2
var h_sensitivity_aim = 0.04
var v_sensitivity = 0.1
var v_sensitivity_aim = 0.04
var h_acceleration = .3
var v_acceleration = .4
var	DecelerationFactor = 4
var deltaValue = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$h/v/Camera.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:

		$h.rotation.y += -event.relative.x * (h_sensitivity ) * deltaValue# * (1-aim_transition))
		$h/v.rotation.x += event.relative.y * (v_sensitivity) * deltaValue# * (1-aim_transition))
		$h.rotation.y = wrapf($h.rotation.y, 0.0, deg_to_rad(360.0))
		#if ($h.rotation.y <= 0.0):
		#	$h.rotation.y = 359.0
		#elif ($h.rotation.y >= 359.0):
		#	$h.rotation.y = 0.0
		#$h.rotation.y = wrapf($h.rotation.y, 0.0, 360.0)

		#print('camrot_h: ',camrot_h)
		#var aim_transition = get_node("../AnimationTree").get("parameters/aim_transition/current")
		
		#camrot_h += -event.relative.x * (h_sensitivity * aim_transition + h_sensitivity_aim * (1-aim_transition))
		#amrot_v += event.relative.y * (v_sensitivity * aim_transition + v_sensitivity_aim * (1-aim_transition))

		#camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
		#$h.rotation.y = wrapf($h.rotation.y, -360.0, 360.0)

		#$h.rotation.y = lerpf($h.rotation.y, camrot_h, h_acceleration)

		#$h/v.rotation.x = lerpf($h/v.rotation.x, camrot_v, v_acceleration)
		#print('$h/v.rotation.x:',$h/v.rotation.x)
		#$h.rotation.y = lerpf($h.rotation.y, 0, DecelerationFactor)
		#$h/v.rotation.x = lerpf($h/v.rotation.x, 0, DecelerationFactor)
		


func _physics_process(delta):
	deltaValue = delta
	#print('$h.rotation.y: ',$h.rotation.y)	
	#print('CameraRoot rotation.y', rotation.y)
