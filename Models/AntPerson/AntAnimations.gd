extends AnimationTree

var called_once = false
var playback
# Called when the node enters the scene tree for the first time.
func _ready():
	playback = get("parameters/playback") 
	playback.start("BlendTreeIdleWalk")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set("parameters/BlendTreeIdleWalk/BlendSpace1D/blend_position",0)
	#if (not called_once):
		#$".".play("NormalIdle")
		#called_once = true
		#print('called this guy')
	#playback = get("parameters/playback") 
	#playback.start("")
