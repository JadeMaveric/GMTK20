extends MarginContainer


onready var red_label = $Bar/BaddiesCount
onready var red_bar = $Bar/Baddies
onready var green_label = $Bar/GoodiesCount
onready var green_bar = $Bar/Goodies
onready var tween = $Tween


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
