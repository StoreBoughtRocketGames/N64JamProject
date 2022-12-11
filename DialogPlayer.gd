extends CanvasLayer

@export_file("*.json") var dialog_file : String
var dialog = []
var json_object
var parse_err
var file
# player dialog index
var dialog_index = 0
var is_dialog_active = false
var is_dialog_over = false
@onready var messageNode = $AspectRatioContainer/MarginContainer/NinePatchRect/MarginContainer/Message
@onready var nameNode = $AspectRatioContainer/MarginContainer/NinePatchRect/Name
@onready var antPersonNode = $".."
var window_size
# Called when the node enters the scene tree for the first time.
func _ready():
	#play_dialog() # Replace with function body.
	hide()
	#pass
	
func play_dialog():
	if is_dialog_active:
		return
	
	dialog = load_dialog()
	show()
	is_dialog_active = true
	
	nameNode.text = dialog[0]['name']
	messageNode.text = dialog[0]['text']


func _input(event):
	if not is_dialog_active:
		return
	if Input.is_action_just_pressed("Interact"):
		next_line()

func next_line():
	
	dialog_index = dialog_index + 1
	print('antPersonNode.allow_dialog: ',antPersonNode.allow_dialog)
	if (dialog_index >= len(dialog)):
		dialog_index = 0
		is_dialog_over = true
		is_dialog_active = false
		hide()
		print('Returning')
		return
	elif (is_dialog_over == true and antPersonNode.allow_dialog):
		dialog_index = 0
		nameNode.text = dialog[dialog_index]['name']
		messageNode.text = dialog[dialog_index]['text']
		show()
		return
	print('len(dialog):',len(dialog))
	print('dialog_index: ',dialog_index)

	nameNode.text = dialog[dialog_index]['name']
	messageNode.text = dialog[dialog_index]['text']
	
func hide_dialog():
	hide()

func load_dialog():
	# Create file
	file = FileAccess.open(dialog_file, FileAccess.READ)
	
	#if file.file_exists(dialog_file):

	json_object = JSON.new()
	parse_err = json_object.parse(file.get_as_text())
	
	return json_object.get_data()
	#else:
	#	print('Couldn\'t find file: ', dialog_file)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if Input.is_action_just_pressed("toggle_fullscreen"):
	#	window_size = DisplayServer.window_get_size()
	#	print('dialog size: ',window_size)#Vector2(window_size.x / (4.0 * 4.0), window_size.y  /  (4.0 * 4.0)))
		#if (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED):
			#$AspectRatioContainer.set_position(Vector2(window_size.x / (2.0 * 4.0), window_size.y * 3.0 / (4.0 * 4.0) ) )
			#$AspectRatioContainer.set_size(Vector2(window_size.x / (4.0 * 2.0), window_size.y  /  (2.0 * 4.0)) )
#
#		else:
#			print('Coming in here')
#			$AspectRatioContainer/NinePatchRect.set_position(Vector2(window_size.x / (4.0 * 4.0), window_size.y  /  (4.0 * 4.0)) )
#			$AspectRatioContainer/NinePatchRect.set_size(Vector2(window_size.x / (4.0 * 4.0), window_size.y  /  (4.0 * 4.0)) )

		#if (is_dialog_active == false):
			#print('hiding the dialog')
		

