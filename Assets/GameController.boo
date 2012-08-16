import UnityEngine

enum GameState:
	Ready
	Main
	GameOver
	Clear

class GameController (MonoBehaviour): 
	public initialStage = 1
	public maxStage = 10
	public missCount = 0
	private isGuguguMode = false
	private currentStage = 1
	private currentState as GameState
	private coin as int = 0

	def Start ():
		self.currentStage = initialStage
		self.currentState = GameState.Ready
		self.LoadStage(self.currentStage)
	
	def Update ():
		if Input.GetKeyDown(KeyCode.Space):
			if self.currentState == GameState.GameOver:
				self.Replay()
			elif self.currentState == GameState.Clear:
				self.NextLevel()

	def GameOver():
		if self.currentState == GameState.Main:
			clip as AudioClip = Resources.Load("Sound/gameover", AudioClip)
			audio.PlayOneShot(clip)
			self.coin = Mathf.Floor(self.coin) / 2 + 1
			self.currentState = GameState.GameOver
			self.ToggleController(false)	
		if not self.isGuguguMode:
			++self.missCount
		
	def ToggleController(toggle as bool):
		controller = GameObject.FindWithTag("Player").GetComponent[of CharacterController]()
		controller.enabled = toggle	
		
	def Clear():
		self.currentState = GameState.Clear
		self.ToggleController(false)	
		
	def Exit():
		Application.Quit()
		
	def StartGame():
		self.currentState = GameState.Main
		self.ToggleController(true)	
		
	def NextLevel():
		if self.missCount == 0 and self.currentStage == self.maxStage:
			self.isGuguguMode = true
		self.currentStage += 1
		self.LoadStage(self.currentStage)
	
	def Replay():
		if self.isGuguguMode:
			self.currentStage = 1
			self.isGuguguMode = false
		self.LoadStage(self.currentStage)
		
	def OnGUI ():
		style as GUIStyle = GUIStyle()
		style.fontSize = 24 
		style.normal.textColor = Color.red
		style.alignment = TextAnchor.MiddleRight
		GUI.Label(Rect(30, 30, 100, 50), "Floor: ", style)
		GUI.Label(Rect(230, 30, 150, 50), "Coin: ", style)
		style.alignment = TextAnchor.MiddleLeft
		GUI.Label(Rect(130, 30, 100, 50), self.currentStage.ToString(), style)
		GUI.Label(Rect(380, 30, 100, 50), self.GetCoin().ToString(), style)
		if self.currentState == GameState.GameOver:
			width = Screen.width
			height = Screen.height
			gameOverLabelStyle = GUIStyle()
			gameOverLabelStyle.fontSize = 64 
			gameOverLabelStyle.alignment = TextAnchor.MiddleCenter
			gameOverLabelStyle.normal.textColor = Color.white
			GUI.Label(Rect(width / 2 - 300, height / 2 - 200, 600, 400), "Game Over", gameOverLabelStyle)	
			if GUI.Button( Rect(width / 2 - 210, height / 2 + 100, 200, 60), "Replay(Space)"):
				self.Replay()
			elif GUI.Button( Rect(width / 2 + 10, height / 2 + 100, 200, 60), "Exit"):
				self.Exit()
		elif self.GetCurrentState() == GameState.Clear:
			width = Screen.width
			height = Screen.height
			clearLabelStyle = GUIStyle()
			clearLabelStyle.fontSize = 64 
			clearLabelStyle.alignment = TextAnchor.MiddleCenter
			clearLabelStyle.normal.textColor = Color.white
			text as string
			if self.currentStage == self.maxStage:
				if self.missCount == 0:
					text = "Incredible!"
					if GUI.Button( Rect(width / 2 - 100, height / 2 + 100, 200, 60), "GuguguMode(Space)"):
						self.NextLevel()
				else:
					if GUI.Button( Rect(width / 2 - 100, height / 2 + 100, 200, 60), "Exit"):
						self.Exit()
					text = "Congratulation!"
			elif self.currentStage == self.maxStage + 1:
				if GUI.Button( Rect(width / 2 - 100, height / 2 + 100, 200, 60), "Exit"):
					self.Exit()
				text = "Crasy"
			else:
				if GUI.Button( Rect(width / 2 - 100, height / 2 + 100, 200, 60), "Next Level(Space)"):
					self.NextLevel()
				text = "Clear!"
			GUI.Label(Rect(width / 2 - 300, height / 2 - 200, 600, 400), text, clearLabelStyle)	
		
	def LoadStage(stageNo as int):
		stageLoader as StageLoader = GameObject.FindWithTag("StageLoader").GetComponent[of StageLoader]()
		stageLoader.DestroyStage()
		stageLoader.CreateStage(stageNo)
		self.StartGame()
		
	def GetCurrentState() as GameState: 
		return self.currentState
		
	def GetCoin() as int:
		return self.coin
		
	def SetCoin(c as int):
		self.coin = c
		
	def AddCoin():
		clip as AudioClip = Resources.Load("Sound/coin", AudioClip)
		audio.PlayOneShot(clip)
		self.coin += 1