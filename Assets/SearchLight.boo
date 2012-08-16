import UnityEngine

class SearchLight (MonoBehaviour): 
	public speed as single = 0.0
	public fix as bool = false
		
	def Start ():
		self.transform.position.y = 50
		self.ToggleFix(self.fix)
		
	def Update ():
		if not fix:
			transform.eulerAngles.y += speed	
		
	def ToggleFix(toggle):
		self.fix = toggle
		self.transform.eulerAngles.x = 90
		if not fix:
			self.transform.eulerAngles.x = 60
