extends MarginContainer


onready var energy_text = $Bar/LifeStats/EnergyBar/Count/Background/Number
onready var energy_bar = $Bar/LifeStats/EnergyBar/TextureProgress
onready var life_text = $Bar/LifeStats/LifeBar/Count/Background/Number
onready var life_bar = $Bar/LifeStats/LifeBar/TextureProgress
onready var addiction_bar = $Bar/MoodStats/AddictionBar/TextureProgress
onready var boredom_bar = $Bar/MoodStats/BoredomBar/TextureProgress
onready var tween = $Tween

var goodies_ratio := 0.5
var baddies_ratio := 0.5
var animated_health := 100
var animated_energy := 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	energy_text.text = str(round(animated_energy))
	energy_bar.value = animated_energy
	
	life_text.text = str(round(animated_health))
	life_bar.value = round(animated_health)
	
	addiction_bar.set_as_ratio(goodies_ratio)
	boredom_bar.set_as_ratio(baddies_ratio)


