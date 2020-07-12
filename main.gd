extends Node


export(int) var health = 100
export(int) var energy = 10


func thought_count():
	var goodies = 0
	var baddies = 0
	for child in $ThoughtController.get_children():
		if child.is_in_group("good_thought"):
			goodies += 1
		elif child.is_in_group("bad_thought"):
			baddies += 1
		
	return {"goodies": goodies, "baddies": baddies}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var count = thought_count()
	var goodies :float = float(count["goodies"])
	var baddies :float = float(count["baddies"])
	
	if goodies == 0 or baddies == 0:
		health = 0
	
	var good_score = 0; var bad_score = 0
	if goodies != 0 or baddies != 0:
		good_score = goodies / (goodies + baddies)
		bad_score = baddies / (goodies + baddies)
	
	$GUI.tween.interpolate_property($GUI, "goodies_ratio", null, good_score, 0.5)
	$GUI.tween.interpolate_property($GUI, "baddies_ratio", null, bad_score, 0.5)
	$GUI.tween.interpolate_property($GUI, "animated_health", null, health, 0.5)
	$GUI.tween.interpolate_property($GUI, "animated_energy", null, energy, 0.5)
	
	if not $GUI.tween.is_active():
		$GUI.tween.start()
