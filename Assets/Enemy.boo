import UnityEngine

enum EnemyType:
	Vertical
	Horizontal
	Waddle

class Enemy (MonoBehaviour): 
	private type as EnemyType = EnemyType.Vertical
	private velocity as Vector3 = Vector3.zero
	private isTurning as bool = false
	private turnAngle as single = 0
	public angleSpeed = 1
	public searchLight as GameObject
	public speed as single = 0.1
	public minimumAngle = 45
	public maxAngle = 170

	def Start ():
		self.transform.position.y = 10
	
	def Update ():
		if self.isTurning:
			self.transform.Rotate(0, 2, 0)
			self.turnAngle += 2
			if turnAngle >= 180:
				self.turnAngle = 0
				self.isTurning = false
		else:
			self.transform.Translate(self.velocity)
		sl as Light = searchLight.GetComponent[of Light]()
		sl.spotAngle += angleSpeed
		if sl.spotAngle > self.maxAngle:
			sl.spotAngle = self.maxAngle
			angleSpeed = -1 * Mathf.Abs(self.angleSpeed)
		elif sl.spotAngle < self.minimumAngle:
			sl.spotAngle = self.minimumAngle
			angleSpeed = Mathf.Abs(self.angleSpeed)
		
	def OnTriggerEnter(other as Collider):
		if other.gameObject.CompareTag("Wall"):
			self.isTurning = true
		elif other.gameObject.CompareTag("Player"):
			controller as GameObject = GameObject.FindWithTag('GameController')
			controller.SendMessage('GameOver')

	def SetType(t as EnemyType):
		self.type = t
		if t == EnemyType.Horizontal:
			self.transform.Rotate(0, 90, 0)
		self.velocity = Vector3.forward * self.speed
