extends Control

var gold = 0
onready var gold_label = $Gold
onready var timer = $Timer

var appart_list = []
var appart_idx = 0

func _ready():
	var appart_scene = load("res://scenes/appart/appart.tscn")
	
	var appart = appart_scene.instance()
	$Apparts.add_child(appart)
	appart.init_appart(5000, 3, 20, 5, "res://scenes/appart/sprites/appart02.png")
	appart_list.append(appart)
	
	appart = appart_scene.instance()
	$Apparts.add_child(appart)
	appart.rect_position = Vector2(-5000, 0)
	appart.init_appart(7000, 4, 50, 10, "res://scenes/appart/sprites/appart01.png")
	appart_list.append(appart)
	
	timer.start(1)
	
# warning-ignore:return_value_discarded
	$CenterContainer/HBoxContainer/PreviousButton.connect("pressed", self, "previous_appart")
# warning-ignore:return_value_discarded
	$CenterContainer/HBoxContainer/NextButton.connect("pressed", self, "next_appart")

func earn_money(amount):
	gold += amount
	
# warning-ignore:unused_argument
func _physics_process(delta):
	if Input.get_action_strength("ui_left"):
		earn_money(50)

func next_appart():
	var current_appart = appart_list[appart_idx]
	appart_idx = (appart_idx - 1) % appart_list.size()
	var next_appart = appart_list[appart_idx]
	next_appart.rect_position = Vector2(1024, 0)
	next_appart.modulate.a = 0
	$EnterTweenPos.interpolate_property(next_appart, "rect_position", next_appart.rect_position, Vector2(0, 0), 0.3)
	$EnterTweenModulate.interpolate_property(next_appart, "modulate", next_appart.modulate, Color(1, 1, 1, 1), 0.3)
	$ExitTweenPos.interpolate_property(current_appart, "rect_position", current_appart.rect_position, Vector2(-1024, 0), 0.3)
	$ExitTweenModulate.interpolate_property(current_appart, "modulate", current_appart.modulate, Color(1, 1, 1, 0), 0.3)
	
	$EnterTweenPos.start()
	$EnterTweenModulate.start()
	$ExitTweenPos.start()
	$ExitTweenModulate.start()

func previous_appart():
	var current_appart = appart_list[appart_idx]
	appart_idx = (appart_idx + 1) % appart_list.size()
	var next_appart = appart_list[appart_idx]
	next_appart.rect_position = Vector2(-1024, 0)
	next_appart.modulate.a = 0
	$EnterTweenPos.interpolate_property(next_appart, "rect_position", next_appart.rect_position, Vector2(0, 0), 0.3)
	$EnterTweenModulate.interpolate_property(next_appart, "modulate", next_appart.modulate, Color(1, 1, 1, 1), 0.3)
	$ExitTweenPos.interpolate_property(current_appart, "rect_position", current_appart.rect_position, Vector2(1024, 0), 0.3)
	$ExitTweenModulate.interpolate_property(current_appart, "modulate", current_appart.modulate, Color(1, 1, 1, 0), 0.3)
	
	$EnterTweenPos.start()
	$EnterTweenModulate.start()
	$ExitTweenPos.start()
	$ExitTweenModulate.start()
