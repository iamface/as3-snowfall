package
{
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	public class Snow extends Sprite
	{
		public function Snow()
		{
			// timer (speed) for snowfall
			var runTimer:Timer = new Timer(10, 0);
            runTimer.addEventListener(TimerEvent.TIMER, addSnow);
            runTimer.start();
		}
		private function addSnow(e:TimerEvent)
		{
			var newSnow:Sprite = new Sprite();
			// the range of how large the snowflakes are (currently 1-3 px)
			var snowSize:int = Math.floor(Math.random() * 3);
			// snow color
			newSnow.graphics.beginFill(0xFFFFFF);
			newSnow.graphics.drawCircle(0, 0, snowSize);
			newSnow.graphics.endFill();
			// horizontal range of snowflake
			var minStageX:int = -newSnow.width;
			var maxStageX:int = (stage.stageWidth + newSnow.width);
			// placement x,y of snowflake
			var snowX:Number = (Math.random() * maxStageX) + minStageX;
			var snowY:Number = -newSnow.height;
			// range of speed snow will fall (currently 2-6)
			var ySpeed:Number = Math.ceil((Math.random() * 4)+2);
			// drift speed
			var drift:int = Math.floor((Math.random() * -3)) + Math.ceil((Math.random() * 3));
			// places snowflake and adds to stage
			newSnow.x = snowX;
			newSnow.y = snowY;
			addChild(newSnow);
			// snowfall function
			newSnow.addEventListener(Event.ENTER_FRAME, snowMove);		
			function snowMove(e:Event)
			{
				// speed of fall
				e.currentTarget.y += ySpeed;
				// speed of drift
				e.currentTarget.x += drift;
				// adds newest snowflake to highest "depth"
				e.currentTarget.parent.setChildIndex(e.currentTarget, e.currentTarget.parent.numChildren - 1);
				// removes snowflake from stage after it passes below the bottom of the stage
				if(e.currentTarget.y > (stage.stageHeight + e.currentTarget.height))
				{
					e.currentTarget.parent.removeChild(e.currentTarget);
					e.currentTarget.removeEventListener(Event.ENTER_FRAME, snowMove);
				}
			}
		}
	}	
}