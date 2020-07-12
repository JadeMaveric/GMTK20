extends MarginContainer

var goodies_ratio := 0.5
var baddies_ratio := 0.5
var animated_health := 100
var animated_energy := 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$Bar/LifeStats/EnergyBar/Count/Background/Number.text = str(round(animated_energy))
	$Bar/LifeStats/EnergyBar/TextureProgress.value = round(animated_energy)
	
	$Bar/LifeStats/LifeBar/Count/Background/Number.text = str(round(animated_health))
	$Bar/LifeStats/LifeBar/TextureProgress.value = round(animated_health)
	
	$Bar/MoodStats/BoredomBar/TextureProgress.set_as_ratio(goodies_ratio)
	$Bar/MoodStats/AddictionBar/TextureProgress.set_as_ratio(baddies_ratio)
