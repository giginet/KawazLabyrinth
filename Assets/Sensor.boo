import UnityEngine

class Sensor (MonoBehaviour): 
	public minDistance as single = 8.0
	public searchSpeed as single = 3.0
	private hitCount as int = 0
		
	def Start ():
		pass
		
	def Update ():
		player as GameObject = GameObject.FindWithTag("Player")
		if player and self.IsCollideWith(player):
			if hitCount < 255:
				hitCount += searchSpeed
			else:
				hitCount = 255
				controller as GameController = GameObject.FindWithTag("GameController").GetComponent[of GameController]()
				controller.SendMessage("GameOver")
				return
		else:
			if hitCount > 0:
				hitCount -= searchSpeed
		light as Light = gameObject.GetComponent[of Light]()
		light.color.r = 100
		light.color.g = 100 - hitCount * 100.0 / 255.0
		light.color.b = 100 - hitCount * 100.0 / 255.0
		light.color.a = 100
		
	def IsCollideWith(target as GameObject):
		light as Light = gameObject.GetComponent[of Light]()
		v as Vector3 = target.transform.position - transform.position
		distance as single = Vector3.Distance(target.transform.position, transform.position)
		angle = Vector3.Angle(v, transform.forward)
		//d as single = ((light.range - distance) / (light.range - self.minDistance)) * 100
		//eyeSight = ((light.spotAngle - angle * 2) / light.spotAngle) * d
		if distance <= light.range and angle <= light.spotAngle / 2:
			return true
		return false