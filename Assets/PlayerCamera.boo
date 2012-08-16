import UnityEngine

class PlayerCamera (MonoBehaviour): 

	def Start ():
		pass
	
	def Update ():
		self.transform.eulerAngles.y = 0
		self.transform.eulerAngles.z = 0
