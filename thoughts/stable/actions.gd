extends "res://thoughts/actions.gd"
# Stable Thought

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print($LifetimeTimer.get_wait_time())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LifetimeTimer_timeout():
	kill()
