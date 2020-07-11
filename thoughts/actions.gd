extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(int) var speed = 110

var ThoughtNode = load("res://thoughts/thought.tscn")

func rand_vector():
	return Vector2(rand_range(-1, 1), rand_range(-1, 1)).normalized()


func kill():
	get_parent().remove_child(self)
	
func save():
	var clone = self.duplicate(DUPLICATE_GROUPS+DUPLICATE_SCRIPTS+DUPLICATE_SIGNALS)
	var clone_dir = rand_vector()
	clone.set_linear_velocity((clone_dir-position).normalized() * speed)
	clone.position = position + clone_dir
	position = position - clone_dir
	get_parent().add_child(clone)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_mode(RigidBody2D.MODE_CHARACTER)
	set_bounce(1)
	var wait_time = rand_range(5, 20)
	$LifetimeTimer.set_wait_time(wait_time)
	$LifetimeTimer.start()
	$MovementTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	
func _input_event(_viewport, event, _shape_idx):
	if event.is_action_pressed("gp_kill"):
		kill()
		
	elif event.is_action_pressed("gp_save"):
		save()


func _change_velocity():
	var screen = get_viewport_rect()
	
	if $MovementTimer.get_wait_time() != 1.0:
		$MovementTimer.set_wait_time(1.0)
	
	if screen.has_point(position):
		set_linear_velocity(rand_vector() * speed)
	else:
		var center : Vector2 = screen.position + screen.size/2
		var movement_dir := position.direction_to(center)
		set_linear_velocity(movement_dir * speed)


func _on_LifetimeTimer_timeout():
	pass # Replace with function body.
