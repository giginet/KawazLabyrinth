import UnityEngine

class Gate (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		pass

	def OnTriggerEnter(other as Collider):
		gameObject as GameObject = other.gameObject
		if gameObject.CompareTag('Player'):
			controller = GameObject.FindWithTag('GameController').GetComponent[of GameController]()
			controller.SendMessage('Clear')
