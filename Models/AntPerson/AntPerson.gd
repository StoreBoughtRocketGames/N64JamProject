extends CharacterBody3D

@onready var dialogNode = "DialogPlayer"
var dialog_player
var allow_dialog = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	#print('get_overlapping_bodies(): ',len(get_overlapping_bodies()))
	if event.is_action_pressed("Interact") and allow_dialog:
		#print('doing this!')
		find_and_use_dialog()

func find_and_use_dialog():
	dialog_player = get_node_or_null(dialogNode)
	#print('dialog_player: ',dialog_player)
	if dialog_player:
		dialog_player.play_dialog()

func _on_area_3d_body_entered(body):
	if body is CharacterBody3D:
		print('we entered the bee area')
		allow_dialog = true

func _on_area_3d_body_exited(body):
	if body is CharacterBody3D:
		print('dialog_player: ',dialog_player)
		allow_dialog = false
		if dialog_player:
			print('setting invisible!')
			dialog_player.hide_dialog()



