extends Label

var gold = 0

func _ready():
	pass # Replace with function body.

func earn_money(amount):
	gold += amount
	var text = "Argent = " + String(gold) + " $"
	set_text(text)

func _process(_delta):
	earn_money(50)
