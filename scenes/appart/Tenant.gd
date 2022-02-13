extends VBoxContainer

var is_vacant = true

onready var appart = get_parent().get_parent().get_parent().get_parent()

func _ready():
	$Background.texture = appart.interior_texture
	$Label.text = "Vacant"
	$Button.set_price(appart.buy_price / 5)
# warning-ignore:return_value_discarded
	$Button.connect("pressed", self, "find_tenant")
	
func find_tenant():
	var waiter = TickWaiter.new()
	add_child(waiter)
	waiter.wait_for_ticks(appart.tenant_find_ticks)
	waiter.connect("ticks_finished", self, "tenant_found")
	$Label.text = "Searching"
	$Button.text = "..."
	$Button.disabled = true
	get_node("/root/main").earn_money(-appart.buy_price / 5)
	$Button.disconnect("pressed", self, "find_tenant")

func tenant_found():
	
	var tenant = load("res://scenes/appart/sprites/tenant0" + String(randi() % 2 + 1) + ".png")
	$Background/TenantTexture.texture = tenant
	$Label.text = "Occupied"
	$Button.text = "Expel"
	$Button.disabled = false
# warning-ignore:return_value_discarded
	$Button.connect("pressed", self, "expel_tenant")
	is_vacant = false

func expel_tenant():
	pass
