extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	get_animation("DrunkIdle").loop_mode = true
	play("NormalIdle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
