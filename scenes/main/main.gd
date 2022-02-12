extends Node2D

var gold = 0
onready var gold_label = $Gold
onready var timer = $Timer

func _ready():
	timer.start(1)

func earn_money(amount):
	gold += amount
	

func _physics_process(delta):
	if Input.get_action_strength("ui_left"):
		earn_money(50)

