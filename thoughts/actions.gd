extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var speed = 10

var ThoughtNode = load("res://thoughts/Thought.tscn")

func rand_vector():
	return [Vector2.DOWN, Vector2.UP, Vector2.LEFT, Vector2.RIGHT][floor(rand_range(0, 4))]
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed("gp_kill"):
		get_parent().remove_child(self)
		
	elif event.is_action_pressed("gp_save"):
		# Slide left, generate child on right
		var clone = ThoughtNode.instance()
		clone.position = position + rand_vector()
		position = position + rand_vector()
		get_parent().add_child(clone)
		
