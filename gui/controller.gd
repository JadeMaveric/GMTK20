extends MarginContainer


onready var energy_text = $Bar/LifeStats/EnergyBar/Count/Background/Number
onready var energy_bar = $Bar/LifeStats/EnergyBar/TextureProgress
onready var life_text = $Bar/LifeStats/LifeBar/Count/Background/Number
onready var life_bar = $Bar/LifeStats/LifeBar/TextureProgress
onready var addiction_bar = $Bar/MoodStats/AddictionBar/TextureProgress
onready var boredom_bar = $Bar/MoodStats/BoredomBar/TextureProgress
onready var tween :Tween= $Tween

var goodies_ratio := 0.5
var baddies_ratio := 0.5
var animated_health := 100.0
var animated_energy := 1.0

var boredom_warning := false
var addiction_warning := false
var overthink_warning := false
var energy_warning := false


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.get_animation("GameOverBob").set_loop(true)
	$AnimationPlayer.get_animation("BoredomDanger").set_loop(true)
	$AnimationPlayer.get_animation("AddictionDanger").set_loop(true)
	$AnimationPlayer2.get_animation("GameOverBob").set_loop(true)
	$AnimationPlayer2.get_animation("BoredomDanger").set_loop(true)
	$AnimationPlayer2.get_animation("AddictionDanger").set_loop(true)
	$AnimationPlayer3.get_animation("GameOverBob").set_loop(true)
	$AnimationPlayer3.get_animation("BoredomDanger").set_loop(true)
	$AnimationPlayer3.get_animation("AddictionDanger").set_loop(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	energy_bar.value = animated_energy
	
	life_text.text = str(round(animated_health))
	life_bar.value = animated_health
	
	addiction_bar.set_as_ratio(goodies_ratio)
	boredom_bar.set_as_ratio(baddies_ratio)
	
	if animated_health < 1:
		$GameOver.show()
		$AnimationPlayer.play("GameOverBob")
		get_tree().paused = true
	
	if boredom_warning:
		$AnimationPlayer.play("BoredomDanger")
	else:
		$AnimationPlayer.stop()
	
	if addiction_warning:
		$AnimationPlayer2.play("AddictionDanger")
	else:
		$AnimationPlayer.stop()
	
	if energy_warning:
		$AnimationPlayer3.play("EnergyDanger")
	else:
		$AnimationPlayer.stop()
	


func _on_HP_mouse_entered():
	$Messages/HP.show()


func _on_HP_mouse_exited():
	$Messages/HP.hide()


func _on_WP_mouse_entered():
	$Messages/WP.show()


func _on_WP_mouse_exited():
	$Messages/WP.hide()


func _on_BA_mouse_entered():
	$Messages/BA.show()


func _on_BA_mouse_exited():
	$Messages/BA.hide()


func _on_Timer_timeout():
	$Intro.hide()
