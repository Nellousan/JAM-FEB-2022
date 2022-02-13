extends Control

var issue_text: String
var popup_text: String
var price: int

func init(_issue_text, _price):
	issue_text = _issue_text
	price = _price
	$HBoxContainer/Label.text = issue_text
	$HBoxContainer/BuyButton.set_price(price)

func _ready():
	$HBoxContainer/BuyButton.connect("pressed", self, "on_button_pressed")

func on_button_pressed():
	get_node("/root/main").earn_money(-price)
	queue_free()
