class_name Animations
extends AnimationTree

var playback : AnimationNodeStateMachinePlayback
var input_dir
var direction = Vector3.ZERO
var player_blend_speed = 0
var is_jumping: bool = false


enum States {IDLERUN, SHOOT, AIM, ON_GROUND, IN_AIR}

var state : int = States.IDLERUN
var previous_state : int = States.ON_GROUND
var timer
var allowTransition : bool = true
@onready var globals = get_node("/root/Globals")

func _on_timer_timeout():
	timer.stop()
	allowTransition = true

# Called when the node enters the scene tree for the first time.
func _ready():
	playback = get("parameters/playback") 
	playback.start("BlendTreeIdleRun")
	set("parameters/BlendTreeIdleRun/BlendSpace1DIdleRun/blend_position",0)
	set("parameters/BlendTreeIdleRun/BlendUnarmedToArmed/blend_amount",0)
	active = true
	set("parameters/BlendTreeIdleRun/TimeScale/scale", 2.0)
	# Wait timer to reset shoot animation
	timer = Timer.new()
	timer.wait_time = 0.75
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _input(event):
	pass		
		#print('state: ',state)
func set_state(_state):
	#if (allowTransition):
	#	_state = States.IDLERUN
	# Check for IDLE state	
	_state = set_idlerun_state(_state)
	# Check for AIM state
	_state = set_aim_state(_state)

	# Check for SHOOT state
	_state = set_shoot_state(_state)
	
	return _state
	
func set_idlerun_state(_state):
	if ((Input.is_action_pressed("forward") or Input.is_action_pressed("left") or \
		Input.is_action_pressed("right")) and not Input.is_action_pressed("aim") and \
		not Input.is_action_pressed("aim") and allowTransition):
		#print('Set idle!')
		_state = States.IDLERUN
	elif (not Input.is_action_pressed("forward") and not Input.is_action_pressed("left") and \
		not Input.is_action_pressed("right") and not Input.is_action_pressed("aim") and \
		not Input.is_action_pressed("shoot") and allowTransition):
		#print('state:',_state)
		_state = States.IDLERUN
	
	return _state

func set_aim_state(_state):
	if (Input.is_action_pressed("aim") and not Input.is_action_pressed("shoot") and allowTransition):
		_state = States.AIM
	return _state

func set_shoot_state(_state):
	if ( Input.is_action_pressed("shoot") or (Input.is_action_pressed("aim") and Input.is_action_pressed("shoot")) and allowTransition):
		#print('We are trying to shoot!')
		_state = States.SHOOT
		if (timer.is_stopped()):
			timer.start()
			allowTransition = false
		#print('state: ',state)
	return _state

func set_animation(state):
	
	clean_up(previous_state)
	# Set player speed no matter what
	set("parameters/BlendTreeIdleRun/BlendSpace1DIdleRun/blend_position",player_blend_speed)
	set("parameters/BlendTreeIdleRun/BlendSpace1DShoot/blend_position",player_blend_speed)
	set("parameters/BlendTreeIdleRun/Blend2AimShoot/blend_amount",player_blend_speed)
	if (Input.is_action_pressed("backward") and Input.is_action_pressed("aim")):
		set("parameters/BlendTreeIdleRun/BlendSpace1DIdleRun/blend_position",-1)
		print('backward')
	# Set animation
	match state:
		States.IDLERUN:
			$"../AnimationPlayer".set_speed_scale(2)
			playback.travel("BlendTreeIdleRun")
		States.AIM:
			# Set IdleRun BlendSpace1D to use running backward animation
			#set("parameters/BlendTreeIdleRun/BlendSpace1DIdleRun/blend_position",-1)
			# Set aim idle, or aim run blend animation
			set("parameters/BlendTreeIdleRun/BlendSpace1DAim/blend_position",player_blend_speed)
			# Set shoot blend animation between idle shoot and run shoot in preparation for shoot
			# transition
			set("parameters/BlendTreeIdleRun/BlendSpace1DShoot/blend_position",player_blend_speed)
			set("parameters/BlendTreeIdleRun/BlendUnarmedToArmed/blend_amount",1)
			#set("parameters/BlendTreeIdleRun/Blend2AimShoot/blend_amount",0)
			#print('Doing aiming stuff')
		States.SHOOT:
			#print('Coming into shoot')
			set("parameters/BlendTreeIdleRun/BlendUnarmedToArmed/blend_amount",1)
	#print('state: ',state)
	previous_state = state
		
func clean_up(clean_up_state):
	match clean_up_state:
		States.SHOOT:
			set("parameters/BlendTreeIdleRun/Blend2AimShoot/blend_amount",0)
			set("parameters/BlendTreeIdleRun/BlendUnarmedToArmed/blend_amount",0)
		States.AIM:
			set("parameters/BlendTreeIdleRun/BlendSpace1DIdleRun/blend_position",player_blend_speed)
			set("parameters/BlendTreeIdleRun/BlendUnarmedToArmed/blend_amount",0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	player_blend_speed = remap(globals.player_velocity.length(),-10,10,-1,1)
	state = set_state(state)
	set_animation(state)
#		$"../AnimationPlayer".set_speed_scale(2)
#		set("parameters/BlendTreeRun/BlendTree/IdleRun/blend_position",player_blend_speed)
#		set("parameters/BlendTreeRun/BlendTree/BlendSpace1D/blend_position",player_blend_speed)
#		playback.travel("BlendTreeRun")

#	if (Input.is_action_pressed("backward") and Input.is_action_pressed("aim")):
#		set("parameters/BlendTreeRun/BlendTree/IdleRun/blend_position",-1)
#		set("parameters/BlendTreeRun/BlendTree/BlendSpace1D/blend_position",-1)
#		playback.travel("BlendTreeRun")
#	if Input.is_action_pressed("aim"):
#		set("parameters/BlendTreeAim/BlendSpace1D/blend_position",player_blend_speed)
#		playback.travel("BlendTreeAim")
#	if (Input.is_action_pressed("shoot")):
#		set("parameters/BlendTreeShoot/BlendTree/Blend2/blend_amount",player_blend_speed)
#		playback.travel("BlendTreeShoot")
	#print(playback.get_current_node())
