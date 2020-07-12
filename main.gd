extends Node


export(float) var health = 100
export(float) var energy = 10

var game_score = 0

func use_energy(value):
	if energy > 0:
		$GUI.tween.interpolate_property($GUI, "animated_energy", energy, energy-value, 0.5)
		energy -= value

func refill_energy(value):
	if energy < 10:
		$GUI.tween.interpolate_property($GUI, "animated_energy", energy, energy+value, 0.5)
		energy += value


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
	
	# Game Over: Fell to addication or boredom
	if goodies == 0 or baddies == 0:
		health = 0
	
	var good_score := 0.0; var bad_score := 0.0
	if goodies != 0 or baddies != 0:
		good_score = goodies / (goodies + baddies)
		bad_score = baddies / (goodies + baddies)
	
	# Calculate Health
	if goodies > baddies+1:
		health -= 10 * delta
		$GUI.boredom_warning = true
	elif baddies > goodies+1:
		health -= 10 * delta
		$GUI.addiction_warning = true
	elif goodies == baddies:
		health += 5 * delta
	elif goodies+baddies > 10:
		health -= 10 *delta # Overthinking looses health
		$GUI.overthink_warning = true
	else:
		$GUI.boredom_warning = false
		$GUI.addiction_warning = false
		$GUI.overthink_warning = false
	
	if health > 100:
		health = 100
	elif health < 0:
		health = 0
		
	$GUI.energy_warning = energy < 1
	# Refill some energy
	refill_energy(0.5 * delta)
	
	$GUI.tween.interpolate_property($GUI, "goodies_ratio", null, good_score, 0.5)
	$GUI.tween.interpolate_property($GUI, "baddies_ratio", null, bad_score, 0.5)
	$GUI.tween.interpolate_property($GUI, "animated_health", null, health, 0.5)
	
	if not $GUI.tween.is_active():
		$GUI.tween.start()
		
	# Game Score
	game_score += (10 - goodies - baddies) * delta * int(health!=0)
	$GUI/Bar/Count2/Background/Score.text = str(round(game_score))
