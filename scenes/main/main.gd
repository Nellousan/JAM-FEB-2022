extends Node2D

var gold = 0
onready var gold_label = $Gold

func _ready():
	pass

func earn_money(amount):
	gold += amount
	var text = "Argent = " + String(gold) + " $"
	gold_label.set_text(text)
	

func _physics_process(delta):
	if Input.get_action_strength("ui_left"):
		earn_money(50)
