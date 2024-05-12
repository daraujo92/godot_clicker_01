extends Node

@export var resources = {
	"gold": 40,
	"wood": 40,
	"food": 40,
}

var player_strength = {
	"gold": 1,
	"wood": 1,
	"food": 1,
}

var workers_strength = {
	"gold": 0,
	"wood": 0,
	"food": 0,
}

var buy_prices = {
	"gold": 30,
	"wood": 30,
	"food": 30,
}

var buy_labels = {
	"gold": "Gold/BuyMiner/GoldPriceLabel",
	"wood": "Wood/BuyCutter/WoodPriceLabel",
	"food": "Food/BuyFarmer/FoodPriceLabel",
}

var resources_label_text: String

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create icons and labels for buttons
	$Gold.icon = load("res://graphics/gold_mine.png")
	$Gold.resource_name = "gold"
	$Gold.text = "Gold"
	
	$Wood.icon = load("res://graphics/forest.png")
	$Wood.resource_name = "wood"
	$Wood.text = "Wood"
	
	$Food.icon = load("res://graphics/farm.png")
	$Food.resource_name = "food"
	$Food.text = "Food"
	
	update_resources_count()
	
	# Create Labels for purchase
	for key in buy_labels:
		get_node(buy_labels[key]).text = "Cost: " + str(buy_prices[key]) + " " + key.capitalize()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func add_resource(resource_name, amount):
	#print("adding " + str(amount) + " " + resource_name)
	resources[resource_name] += amount
	update_resources_count()

func _on_player_add(resource):
	add_resource(resource, player_strength[resource])

	
func update_resources_count():
	resources_label_text = "Gold: " + str(resources.gold) + "        Food: " + str(resources.food) + "        Wood: " + str(resources.wood)
	$HUD/ResourcesLabel.text = resources_label_text

func hire_worker(type, strength):
	workers_strength[type] += strength


func _on_resources_timer_timeout():
	for key in workers_strength:
		resources[key] += workers_strength[key]
	update_resources_count()



func _on_buy_pressed(worker_type):
	var new_worker_strength = 1
	var current_price = buy_prices[worker_type]
	
	if resources[worker_type] - current_price >= 0:
		resources[worker_type] -= current_price
		hire_worker(worker_type, new_worker_strength)
		update_resources_count()
		
		buy_prices[worker_type] += 1
		
		current_price = buy_prices[worker_type]
		
		get_node(buy_labels[worker_type]).text = "Cost: " + str(current_price) + " " + worker_type.capitalize()
	
