package 
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;

	/**
	 * ...
	 * @author Jonathan Sarge
	 */
	public class Main extends Sprite 
	{
		private var gameScene:Vector.<Vector.<Tile>> = new Vector.<Vector.<Tile>>();
		private var gameTitle:TextField = new TextField();
		public var s:Sprite = new Sprite();
		private var scoreBoard:TextField = new TextField();
		private var gameScore:int = 0;
		public var textFormat:TextFormat = new TextFormat();
		private var t:TextField = new TextField();
		private var hitGameScore:int = 0;
		private var xForShip:int = Math.round(Math.random() * 9); // This descides where the ship is placed
		private var yForShip:int = Math.round(Math.random() * 9); // This descides where the ship is placed
		private var shipUpOrDown:int = Math.round(Math.random() * 10); //The variabel that decides if my ship is vertical or horizontal.
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, spawnSquares);
			
			gameScoreBoard.text = "Misses: " + gameScore + "\n" + "Hits: " + hitGameScore;
			gameScoreBoard.border = true;
			gameScoreBoard.x = 650;
			gameScoreBoard.width = 300;
			gameScoreBoard.height = 700;
			addChild(gameScoreBoard);
			// This creates everything around the gameboard
			
			gameTitle.border = true;
			textFormat.size = 40;	
			gameTitle.text = "Battleships"					
			gameTitle.width = 500;
			gameTitle.height = 40;
			addChild(gameTitle);
			gameTitle.setTextFormat(textFormat);
			
			startGame();
			// here i start the game with my function.
			if (shipUpOrDown > 5) 
			{
				gameScene[xForShip][yForShip].becomeShip();
				gameScene[xForShip + 1][yForShip].becomeShip();
				gameScene[xForShip + 2][yForShip].becomeShip();
			}
			else 											// This decides the position of the ship
			{
				gameScene[xForShip][yForShip].becomeShip();
				gameScene[xForShip][yForShip + 1].becomeShip();
				gameScene[xForShip][yForShip + 2].becomeShip();
			}
		}
		public function clickTile(m:MouseEvent):void 
		{
			if (Tile(m.target).isItPressed)
			{
				t.text = " ";						// This function descides wether the click missed or hit a ship. It also makes it so that a tile can't be clicked more than once.
			}
			else if (Tile(m.target).shipOrNot) 
			{
				var HitImage:Bitmap = new Tile.HitImage();
				m.target.addChild(HitImage);
				m.target.isItPressed = true;
				hitGameScore ++;
				gameScoreBoard.text = "Misses: " + gameScore + "\n" + "Hits: " + hitGameScore;
			}
			else
			{
				var MissImage:Bitmap = new Tile.MissImage();
				m.target.addChild(MissImage);
				m.target.isItPressed = true;
				gameScore ++;
				gameScoreBoard.text = "Misses: " + gameScore + "\n" + "Hits: " + hitGameScore;
			}
		}
		public function spawnSquares(e:KeyboardEvent):void 
		{
			switch (e.keyCode) 
			{
				case Keyboard.SPACE:
			}
		}
		public function startGame():void 
		{
			for (var i:int = 0; i < 10; i++) 
			{
				var row:Vector.<Tile> = new Vector.<Tile>();
						//This function lays out the board.
					for (var j:int = 0; j < 10; j++) 
					{	
						var tileBox:Tile = new Tile();
						addChild(tileBox);
						tileBox.addEventListener(MouseEvent.CLICK, clickSquare);
						row.push(tileBox);
						tileBox.x = 10 + i * (50);
						tileBox.y = 100 + j * (50);
					}
				gameScene.push(row);
			}
		}
	}
}