extends RigidBody2D
class_name Thought

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var speed = 110

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
		var clone_dir = rand_vector()
		clone.set_linear_velocity((clone_dir-position).normalized() * 110)
		clone.position = position + clone_dir
		position = position - clone_dir
		get_parent().add_child(clone)

func _unhandled_input(event):
	if event.is_action_pressed("ui_down"):
		set_linear_velocity(Vector2.DOWN * 110)
	elif event.is_action_pressed("ui_right"):
		set_linear_velocity(Vector2.RIGHT * 110)
	elif event.is_action_pressed("ui_up"):
		set_linear_velocity(Vector2.UP * 110)
	elif event.is_action_pressed("ui_left"):
		set_linear_velocity(Vector2.LEFT * 110)
	if event.is_action_pressed("ui_accept"):
		set_linear_velocity(Vector2.ZERO)


func _change_velocity():
	set_linear_velocity(rand_vector() * 110)
	print("Time to bounce")
