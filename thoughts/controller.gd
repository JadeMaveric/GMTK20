extends Node


export(int) var initial_thought_count = 10

var StableThoughtNode = load("res://thoughts/stable/thought.tscn")
var UnstableThoughtNode = load("res://thoughts/unstable/thought.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	# RNG
	randomize()
	# Populate with thought nodes
	var screen := Vector2(
		ProjectSettings.get_setting("display/window/size/width"),
		ProjectSettings.get_setting("display/window/size/height")
	)

	for _i in range(initial_thought_count):
		var stable_thought = StableThoughtNode.instance()
		stable_thought.position = Vector2(randi() % int(screen.x), randi() % int(screen.y))
		stable_thought.get_node("BounceTimer").set_wait_time(randf())
		add_child(stable_thought)
		
		var unstable_thought = UnstableThoughtNode.instance()
		unstable_thought.position = Vector2(randi() % int(screen.x), randi() % int(screen.y))
		unstable_thought.get_node("BounceTimer").set_wait_time(randf())
		add_child(unstable_thought)

#func _unhandled_input(event):
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
