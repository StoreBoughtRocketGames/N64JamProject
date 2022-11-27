extends Node3D

#@export var path_to_world_viewport : NodePath
#@onready var world_viewport : Viewport = get_node(path_to_world_viewport)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass#world_viewport.msaa = Viewport.MSAA_4X 

func _process(_delta):
	if Input.is_action_pressed("exit_game"):
		get_tree().quit()
