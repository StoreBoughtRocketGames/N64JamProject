extends Node3D

var camrot_h = 0
var camrot_v = 0
var cam_v_max = 5#deg_to_rad(220)
var cam_v_min = -5#deg_to_rad(-220)
var h_sensitivity = 0.1
var h_sensitivity_aim = 0.04
var v_sensitivity = 0.1
var v_sensitivity_aim = 0.04
var h_acceleration = .4
var v_acceleration = .4
var	DecelerationFactor = 4

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$h/v/Camera.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:
		
		#var aim_transition = get_node("../AnimationTree").get("parameters/aim_transition/current")
		
		#camrot_h += -event.relative.x * (h_sensitivity * aim_transition + h_sensitivity_aim * (1-aim_transition))
		#amrot_v += event.relative.y * (v_sensitivity * aim_transition + v_sensitivity_aim * (1-aim_transition))
		camrot_h += -event.relative.x * (h_sensitivity + h_sensitivity_aim)# * (1-aim_transition))
		camrot_v += event.relative.y * (v_sensitivity + v_sensitivity_aim)# * (1-aim_transition))
		
func _physics_process(delta):
	
	camrot_v = clamp(camrot_v, cam_v_min, cam_v_max)
	
	$h.rotation.y = lerpf($h.rotation.y, camrot_h, delta * h_acceleration)
	$h/v.rotation.x = lerpf($h/v.rotation.x, camrot_v, delta * v_acceleration)
	#print('$h/v.rotation.x:',$h/v.rotation.x)
	$h.rotation.y = lerpf($h.rotation.y, 0, delta * DecelerationFactor)
	$h/v.rotation.x = lerpf($h/v.rotation.x, 0, delta * DecelerationFactor)
