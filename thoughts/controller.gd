extends Node


export(int) var initial_thought_count = 10

var ThoughtNode = load("res://thoughts/Thought.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Populate with thought nodes
	var screen := Vector2(
		ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height")
	)

	for i in range(initial_thought_count):
		var thought = ThoughtNode.instance()
		thought.position = Vector2(randi() % int(screen.x), randi() % int(screen.y))
		thought.get_node("Timer").set_wait_time(randf())
		add_child(thought)

func _unhandled_input(event):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
