extends FmodManager

var music_vca:FmodVCA;
var fmod_event

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize(1024, FmodManager.NORMAL);
	load_bank("Sound/FMOD/Master.bank", FmodManager.NORMAL_LOAD);
	load_bank("Sound/FMOD/Master.strings.bank", FmodManager.NORMAL_LOAD);

	fmod_event = Fmod.create_event_instance("event:/MusicEvent", true, true)
	print(fmod_event)
