extends CanvasLayer

@onready var item_name_label: RichTextLabel = $ItemInformationPanel/ItemInformationGrid/ItemNameLabel
@onready var item_description_label: RichTextLabel = $ItemInformationPanel/ItemInformationGrid/DescriptionGrid/ItemDescriptionLabel

@onready var luxury_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TypeGrid/LuxuryPanel
@onready var consumable_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TypeGrid/ConsumablePanel
@onready var toy_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TypeGrid/ToyPanel
@onready var handicraft_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TypeGrid/HandicraftPanel
@onready var practical_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TypeGrid/PracticalPanel
@onready var apparel_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TypeGrid/ApparelPanel
@onready var technology_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TypeGrid/TechnologyPanel

@onready var liquid_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TagGrid/LiquidPanel
@onready var liquid_risk_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TagGrid/LiquidRiskPanel
@onready var fragile_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TagGrid/FragilePanel
@onready var soft_panel: Panel = $ItemInformationPanel/ItemInformationGrid/TagGrid/SoftPanel
@onready var tag_grid: GridContainer = $ItemInformationPanel/ItemInformationGrid/TagGrid

func _ready() -> void:
	self.visible = false

# Called when the node enters the scene tree for the first time.
func update(item: ItemUnit):
	luxury_panel.visible = false
	consumable_panel.visible = false
	toy_panel.visible = false
	handicraft_panel.visible = false
	practical_panel.visible = false
	apparel_panel.visible = false
	technology_panel.visible = false

	tag_grid.visible = false
	liquid_panel.visible = false
	liquid_risk_panel.visible = false
	fragile_panel.visible = false
	soft_panel.visible = false

	item_name_label.text = item.item_name
	item_description_label.text = item.item_description

	if item.type == Globals.item_types.LUXURY:
		luxury_panel.visible = true
	elif item.type == Globals.item_types.CONSUMABLES:
		consumable_panel.visible = true
	elif item.type == Globals.item_types.TOYS:
		toy_panel.visible = true
	elif item.type == Globals.item_types.HANDICRAFTS:
		handicraft_panel.visible = true
	elif item.type == Globals.item_types.PRACTICAL:
		practical_panel.visible = true
	elif item.type == Globals.item_types.APPAREL:
		apparel_panel.visible = true
	elif item.type == Globals.item_types.TECHNOLOGY:
		technology_panel.visible = true

	if item.liquid_container:
		tag_grid.visible = true
		liquid_panel.visible = true
	elif item.liquid_risk:
		tag_grid.visible = true
		liquid_risk_panel.visible = true
	if item.fragile:
		tag_grid.visible = true
		fragile_panel.visible = true
	elif item.soft:
		tag_grid.visible = true
		soft_panel.visible = true

	self.visible = true

	
