extends Node2D

onready var timer = $Timer

func _ready():
	pass

func _physics_process(_delta):
	if Input.get_action_strength("ui_left"):
		print(timer)

