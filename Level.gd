extends Node3D

var toggle_screen = false
#@export var path_to_world_viewport : NodePath
#@onready var world_viewport : Viewport = get_node(path_to_world_viewport)
# Called when the node enters the scene tree for the first time.
func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	
	
func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()
	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggle_screen = not toggle_screen
		if (toggle_screen):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			
		#OS.window_fullscreen = !OS.window_fullscreen
