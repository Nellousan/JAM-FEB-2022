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

var interior_texture

var issue_scene = preload("res://scenes/appart/Issue.tscn")

class Issue:
	var issue: String
	var price: int

var issues = []

func _ready():
# warning-ignore:return_value_discarded
	$Center/CenterContainer/VBoxContainer/Button.connect("pressed", self, "harvest_money")

func init_appart(_buy_price, _appart_count, _appart_rent, _tenant_find_ticks, foreground_image_path, interior_image_path):
	buy_price = _buy_price
	appart_count = _appart_count
	appart_rent = _appart_rent
	tenant_find_ticks = _tenant_find_ticks
	var foreground_image = load(foreground_image_path)
	foreground.texture = foreground_image
	interior_texture = load(interior_image_path)
	var tenant_scene = load("res://scenes/appart/Tenant.tscn")
# warning-ignore:unused_variable
	for i in range(appart_count):
		var new_tenant = tenant_scene.instance()
		$LeftPanel/VBoxContainer/HBoxContainer.add_child(new_tenant)
		tenants.append(new_tenant)
# warning-ignore:return_value_discarded
	get_node("../../Timer").connect("timeout", self, "timer_ticks")
	var buy_button = $Center/BuyInterface/VBoxContainer/Button
	buy_button.set_price(buy_price)
	buy_button.connect("pressed", self, "buy_appart")
	$LeftPanel/VBoxContainer/VBoxContainer/Income.text = "Rent: " + String(appart_rent) + "$"
# warning-ignore:integer_division
	$LeftPanel/VBoxContainer/VBoxContainer/Fee.text = "Fee: " + String(buy_price / 5) + "$"
	$LeftPanel/VBoxContainer/VBoxContainer/Apartments.text = "Apts: " + String(appart_count)
	
	var issue = Issue.new()
	issue.issue = "Repair the pipes."
# warning-ignore:integer_division
	issue.price = buy_price / 3
	issues.append(issue)
	
	issue = Issue.new()
	issue.issue = "Repair the light."
# warning-ignore:integer_division
	issue.price = buy_price / 10
	issues.append(issue)
	
	issue = Issue.new()
	issue.issue = "Fix the boiler."
# warning-ignore:integer_division
	issue.price = buy_price / 2
	issues.append(issue)
	
	issue = Issue.new()
	issue.issue = "Improve thermal insulation."
# warning-ignore:integer_division
	issue.price = buy_price / 2
	issues.append(issue)

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

func add_manager():
	pass

func create_issue():
	var issue_node = issue_scene.instance()
	$RightPanel/VBoxContainer.add_child(issue_node)
	$RightPanel/VBoxContainer.queue_sort()
	var issue = issues[randi() % issues.size()]
	issue_node.init(issue.issue, issue.price)
