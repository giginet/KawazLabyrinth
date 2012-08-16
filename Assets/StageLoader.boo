import UnityEngine

class StageLoader (MonoBehaviour): 
	public tilePrefab as GameObject
	public wallPrefab as GameObject
	public lightPrefab as GameObject
	public searchLightPrefab as GameObject
	public gatePrefab as GameObject
	public playerPrefab as GameObject
	public coinPrefab as GameObject
	public enemyPrefab as GameObject
	private playerPlaced as bool
	
	def Start ():
		pass
		
	def Update ():
		pass
		
	def CreateStage (stageNo as int):
		self.playerPlaced = false
		stageData as TextAsset = Instantiate(Resources.Load("StageData/stage" + stageNo,  TextAsset))
		width as single = tilePrefab.transform.localScale.x
		height as single = tilePrefab.transform.localScale.z
		lines = stageData.text.Split("\n"[0])
		stage as GameObject = GameObject.CreatePrimitive(PrimitiveType.Cube)
		stage.tag = "Stage"
		stage.renderer.enabled = false
		stage.name = "Stage" + stageNo
		for y as int, line as string in enumerate(lines):
			for x as int in range(line.Length):
				position = Vector3(x * width, 0, y * height)
				c = line[x]
				if c == "/"[0] or c == "L"[0] or c == "*"[0] or c == "S"[0] or c == "G"[0] or c == "C"[0] or c == "V"[0] or c == "H"[0] or c == "@"[0]:
					tile as GameObject = Instantiate(tilePrefab, position, Quaternion.identity)
					tile.transform.parent = stage.transform
				if c == "#"[0]:
					wall as GameObject = Instantiate(wallPrefab, position, Quaternion.identity)
					wall.transform.parent = stage.transform
				elif c == "L"[0]:
					light as GameObject = Instantiate(lightPrefab, position, Quaternion.identity)	
					light.transform.position.y = 5
					light.transform.parent = stage.transform
				elif c == "*"[0] or c == "@"[0]:
					slight as GameObject = Instantiate(searchLightPrefab, position, Quaternion.identity)
					slight.transform.parent = stage.transform
					if c == "@"[0]:
						slight.SendMessage("ToggleFix", true)
				elif c == "S"[0] and not self.playerPlaced:
					player as GameObject = Instantiate(playerPrefab, position, Quaternion.identity)
					player.transform.position.y = height
					player.transform.parent = stage.transform
					self.playerPlaced = true
				elif c == "G"[0]:
					gate as GameObject = Instantiate(gatePrefab, position, Quaternion.identity)
					gate.transform.position = position
					gate.transform.position.y = height / 2
					gate.transform.parent = stage.transform
				elif c == "C"[0] or c == "c"[0]:
					coin as GameObject = Instantiate(coinPrefab, position, Quaternion.identity)
					coin.transform.position = position
					coin.transform.position.y = height / 2
					coin.transform.parent = stage.transform
				elif c == "V"[0] or c == "H"[0]:
					enemy as GameObject = Instantiate(enemyPrefab, position, Quaternion.identity)
					enemy.transform.position = position
					enemy.transform.position.y = height / 2
					if c == "V"[0]:
						enemy.SendMessage("SetType", EnemyType.Vertical)
					else:
						enemy.SendMessage("SetType", EnemyType.Horizontal)
					enemy.transform.parent = stage.transform
					
	def DestroyStage():
		stage as GameObject = GameObject.FindWithTag("Stage")
		if stage:
			Destroy(stage)
					
	