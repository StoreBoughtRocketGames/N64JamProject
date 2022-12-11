extends Node3D
@export var vectorPos = Vector2(200,50)
var toggle_screen = false
var window_size
#@export var path_to_world_viewport : NodePath
#@onready var world_viewport : Viewport = get_node(path_to_world_viewport) 
#@onready var node2DNode = $CanvasLayer/HBlur/SubViewport/DitherBand/SubViewport/Level/Node2D
# Called when the node enters the scene tree for the first time.

func _ready():
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	#print('canvasNode: ',canvasNode)
	#print('transform: ',canvasNode.transform.set_position(Vector2(1500,500)))
	#subviewport1.position = Vector2(1000,500)
	#window_size = DisplayServer.window_get_size()
	#if (node2DNode):
		#if (DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED):
			#node2DNode.set_position(Vector2(window_size.x * 3.0 / (4.0 * 4.0), window_size.y * 3.0 /  (4.0 * 4.0) ) )
			#print('position at start: ',Vector2(window_size.x * 3.0 / (4.0 * 4.0), window_size.y * 3.0 /  (4.0 * 4.0) ))
func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()
	if Input.is_action_just_pressed("toggle_fullscreen"):
		window_size = DisplayServer.window_get_size()
		toggle_screen = not toggle_screen
		if (toggle_screen):

			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			#if (node2DNode):
			#	node2DNode.set_position(Vector2(window_size.x * 3.0 / (4.0 * 4.0), window_size.y * 3.0 /  (4.0 * 4.0)) )
		else:
#			print('Coming in here')
#
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
#			if (node2DNode):
#				node2DNode.set_position(Vector2(window_size.x * 3.0 / (4.0 * 4.0), window_size.y * 3.0 / (4.0 * 4.0) ) )

		#OS.window_fullscreen = !OS.window_fullscreen

