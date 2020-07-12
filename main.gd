extends Node


export(float) var health = 100
export(float) var energy = 10

func use_energy():
	if energy > 0:
		$GUI.tween.interpolate_property($GUI, "animated_energy", energy, energy-1, 0.5)
		energy -= 1

func refill_energy():
	if energy < 10:
		$GUI.tween.interpolate_property($GUI, "animated_energy", energy, energy+1, 0.5)
		energy += 1


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
	$GUI.tween.follow_property(self, "energy", $GUI.animated_energy, $GUI, "animated_energy", 0.5)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var count = thought_count()
	var goodies :float = float(count["goodies"])
	var baddies :float = float(count["baddies"])
	
	if goodies == 0 or baddies == 0:
		health = 0
	
	var good_score := 0.0; var bad_score := 0.0
	if goodies != 0 or baddies != 0:
		good_score = goodies / (goodies + baddies)
		bad_score = baddies / (goodies + baddies)
	
	if goodies > baddies+2:
		health -= 10 * delta
	elif baddies > goodies+2:
		health -= 10 * delta
	elif goodies == baddies:
		health += 5 * delta
		
	if health > 100:
		health = 100
	elif health < 0:
		health = 0
	
	$GUI.tween.interpolate_property($GUI, "goodies_ratio", null, good_score, 0.5)
	$GUI.tween.interpolate_property($GUI, "baddies_ratio", null, bad_score, 0.5)
	$GUI.tween.interpolate_property($GUI, "animated_health", null, health, 0.5)
	
	if not $GUI.tween.is_active():
		$GUI.tween.start()
