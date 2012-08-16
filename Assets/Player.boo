import UnityEngine

[RequireComponent(AudioSource)]
class Player (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		if transform.position.y < -50:
			controller as GameController = GameObject.FindWithTag("GameController").GetComponent[of GameController]()
			controller.SendMessage("GameOver")