extends Button

class_name BuyButton

onready var main = get_node("/root/main")

var price = 0

func set_price(_price):
	price = _price
	text = String(price) + "$"

func _process(delta):
	if (main.gold >= price):
		disabled = false
	else:
		disabled = true
