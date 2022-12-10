extends CanvasLayer

@export_file("*.json") var dialog_file : String
var dialog = []
var json_object
var parse_err
var file
# player dialog index
var dialog_index = 0
var is_dialog_active = false
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
	$NinePatchRect/Name.text = dialog[0]['name']
	$NinePatchRect/Message.text = dialog[0]['text']


func _input(event):
	if not is_dialog_active:
		return
	if event.is_action_pressed("Interact"):
		next_line()

func next_line():
	dialog_index = dialog_index + 1
	print('len(dialog):',len(dialog))
	print('dialog_index: ',dialog_index)
	if (dialog_index >= len(dialog)):
		is_dialog_active = false
		hide()
		return
	$NinePatchRect/Name.text = dialog[dialog_index]['name']
	$NinePatchRect/Message.text = dialog[dialog_index]['text']
	
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
	#if (is_dialog_active == false):
		#print('hiding the dialog')
		

