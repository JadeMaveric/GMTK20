extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func thought_count():
	var goodies = 0
	var baddies = 0
	for child in $ThoughtController.get_children():
		if child.is_in_group("good_thought"):
			goodies += 1
		elif child.is_in_group("bad_thought"):
			baddies += 1
	return {"goodies": goodies, "baddies": baddies}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var count = thought_count()
	var goodies :float = float(count["goodies"])
	var baddies :float = float(count["baddies"])
	
	if goodies == 0 and baddies == 0:
		return
	
	var good_score = goodies / (goodies + baddies)
	var bad_score = baddies / (goodies + baddies)
	
	$GUI/Bar/Goodies.set_as_ratio(good_score)
	$GUI/Bar/Baddies.set_as_ratio(bad_score)
	
	$GUI/Bar/GoodiesCount.text = str(goodies)
	$GUI/Bar/BaddiesCount.text = str(baddies)
