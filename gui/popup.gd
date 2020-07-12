extends Popup


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_exclusive(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Pause_pressed():
	get_tree().paused = !get_tree().paused
	


func _on_Restart_pressed():
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_Quit_pressed():
	get_tree().quit(0)
