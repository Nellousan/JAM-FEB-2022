extends Label

onready var appart = get_parent().get_parent().get_parent().get_parent().get_parent()

# warning-ignore:unused_argument
func _process(delta):
	text = String(appart.money_to_harvest) + "$"
