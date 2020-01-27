extends Control
	
var healthyColor = Color.green
var cautionColor = Color.yellow
var dangerColor = Color.red

var cautionZone = 0.6
var dangerZone = 0.3

func _on_health_updated(health):
	$HealthOver.value = health
	$UpdateTween.interpolate_property($HealthUnder,"value",$HealthUnder.value,health,0.4,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$UpdateTween.start()
	
	assignColor(health)
	
func assignColor(health):
	if health < $HealthOver.max_value * dangerZone:
		$HealthOver.tint_progress = dangerColor
	elif health < $HealthOver.max_value * cautionZone:
		$HealthOver.tint_progress = cautionColor
	else:
		$HealthOver.tint_progress = healthyColor
	
func _on_max_health_updated(max_health):
	$HealthOver.max_value = max_health
	$HealthUnder.max_value = max_health
	pass