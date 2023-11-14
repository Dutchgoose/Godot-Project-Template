extends Node

signal experience_vial_collected(number: float)
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
signal recruit_upgrade_added(upgrade: RecruitUpgrade, current_upgrades: Dictionary)
signal player_damaged
signal wall_damaged

func emit_experience_vial_collected(number: float):
	experience_vial_collected.emit(number)


func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)
	

func emit_recruit_upgrade_added(upgrade:RecruitUpgrade, current_upgrades: Dictionary):
	recruit_upgrade_added.emit(upgrade, current_upgrades)
	

func emit_player_damaged():
	player_damaged.emit()


func emit_wall_damaged():
	wall_damaged.emit()
