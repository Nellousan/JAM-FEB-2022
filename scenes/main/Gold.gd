extends Label

func _ready():
	pass # Replace with function body.

func _process(_delta):
	var main = get_parent()
	var text = "Argent = " + String(main.gold) + " $"
	set_text(text)
