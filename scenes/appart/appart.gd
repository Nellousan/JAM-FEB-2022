extends Control

var buy_price: int
var appart_count: int
var appart_rent: int
var tenant_find_ticks: int

var initialized = false

var tenants = []

onready var left_panel = $LeftPanel
onready var right_panel = $RightPanel

onready var foreground = $Center/Sprites/Foreground

var money_to_harvest = 0
var owned = false

func _ready():
# warning-ignore:return_value_discarded
	$Center/CenterContainer/VBoxContainer/Button.connect("pressed", self, "harvest_money")

func init_appart(_buy_price, _appart_count, _appart_rent, _tenant_find_ticks, foreground_image_path):
	buy_price = _buy_price
	appart_count = _appart_count
	appart_rent = _appart_rent
	tenant_find_ticks = _tenant_find_ticks
	var foreground_image = load(foreground_image_path)
	foreground.texture = foreground_image
	var tenant_scene = load("res://scenes/appart/Tenant.tscn")
# warning-ignore:unused_variable
	for i in range(appart_count):
		var new_tenant = tenant_scene.instance()
		$LeftPanel/HBoxContainer.add_child(new_tenant)
		tenants.append(new_tenant)
	get_node("../../Timer").connect("timeout", self, "timer_ticks")
	var buy_button = $Center/BuyInterface/VBoxContainer/Button
	buy_button.set_price(buy_price)
	buy_button.connect("pressed", self, "buy_appart")

func show_panels():
	left_panel.show()
	right_panel.show()

func hide_panels():
	left_panel.hide()
	right_panel.hide()

func timer_ticks():
	for tenant in tenants:
		if tenant.is_vacant == false:
			money_to_harvest += appart_rent

func harvest_money():
	get_node("/root/main").earn_money(money_to_harvest)
	money_to_harvest = 0

func buy_appart():
	$Center/BuyInterface.queue_free()
	$Center/CenterContainer.visible = true
	$LeftPanel.visible = true
	$RightPanel.visible = true
	get_node("/root/main").gold -= buy_price
