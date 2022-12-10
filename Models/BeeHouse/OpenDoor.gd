extends AnimationPlayer

var is_door_allowed_open = false
enum States {OPEN, CLOSED}
var state = States.CLOSED
# Called when the node enters the scene tree for the first time.
func _ready():
	play("DoorClose") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if (Input.is_action_just_pressed("Interact") and is_door_allowed_open and state == States.CLOSED):
		play("DoorOpen")
		state = States.OPEN
	elif (Input.is_action_just_pressed("Interact") and is_door_allowed_open):
		play("DoorClose")
		state = States.CLOSED
func _on_area_3d_body_entered(body):
	#is_door_allowed_open 
	if (body is CharacterBody3D):
		is_door_allowed_open = true

	#print("body",body.name)
	



func _on_area_3d_body_exited(body):
	is_door_allowed_open = false
