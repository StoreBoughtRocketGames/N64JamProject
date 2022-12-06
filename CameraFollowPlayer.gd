extends Camera3D
@export var offset_x: float = 114.946#75
@export var offset_y: float = 75.736# 150
@onready var playerNode = $"../../../../PlayerCharacter"

@export var X_REAL: float = 834.584#827.178
@export var Y_REAL: float = 545.272#582.344

var X_SCALE = X_REAL / 1003.0#902.0 
var Y_SCALE = Y_REAL / 655.0##693.0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#position.x = -playerNode.transform.origin.x * X_SCALE + offset_x* X_SCALE
	#position.y = -playerNode.transform.origin.z  * Y_SCALE - offset_y * Y_SCALE
	
	#X_SCALE = X_REAL /1003.0 
	#Y_SCALE = Y_REAL / 655.0 
	
	#print('x: ',X_SCALE, ' y: ',Y_SCALE)
	#self.position.x = playerNode.transform.origin.x
	transform.origin.x = playerNode.transform.origin.x
	#transform.origin.y = 100#playerNode.transform.origin.y
	transform.origin.z = playerNode.transform.origin.z
	#self.position.y = playerNode.transform.origin.z
