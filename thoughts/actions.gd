extends RigidBody2D
class_name Thought

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var speed = 110

var ThoughtNode = load("res://thoughts/Thought.tscn")

func rand_vector():
	return Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()


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
		clone.set_linear_velocity((clone_dir-position).normalized() * speed)
		clone.position = position + clone_dir
		position = position - clone_dir
		get_parent().add_child(clone)


func _change_velocity():
	var screen = get_viewport_rect()
	$Timer.set_wait_time(1.0)
	
	if screen.has_point(position):
		set_linear_velocity(rand_vector() * speed)
	else:
		var center : Vector2 = screen.position + screen.size/2
		var movement_dir := position.direction_to(center)
		set_linear_velocity(movement_dir * speed)
