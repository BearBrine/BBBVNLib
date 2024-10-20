package bvn.display
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import bvn.math.BBMath;
	
	/**
	 * ...
	 * @author BearBrine
	 */
	public class BentLaser
	{
		
		private var _mcClass:Class;
		
		private var _layer:DisplayObjectContainer;
		
		private var _blendMode:String;
		
		private var _mcs:Array;
		
		private var _lastPos:Point;
		
		private var _isStop:Boolean = false;
		
		public var onRemove:Function;
		
		public function BentLaser(mcClass:Class, layer:DisplayObjectContainer, startPos:Point = null, blendMode:String = "normal")
		{
			super();
			_mcClass = mcClass;
			_layer = layer;
			_lastPos = startPos;
			_blendMode = blendMode;
			_mcs = [];
		}
		
		public function render(x:* = NaN, y:* = NaN, index:int = -1):void
		{
			var segment:*;
			for (var i:int = 0; i < _mcs.length; i++)
			{
				segment = _mcs[i];
				if (segment.currentFrame == segment.totalFrames - 1)
				{
					removeLaserSegment(i--);
					continue;
				}
				segment.nextFrame();
				if (segment.currentLabel == "remove")
				{
					removeLaserSegment(i--);
					continue;
				}
			}
			if (!_isStop)
			{
				if (isNaN(x) || isNaN(y))
				{
					if (!_lastPos)
					{
						return;
					}
					if (!isNaN(x))
					{
						x = _lastPos.x;
					}
					if (!isNaN(y))
					{
						y = _lastPos.y;
					}
				}
				addLaserSegment(x, y, index);
			}
			else if (_mcs.length == 0)
			{
				removeSelf();
			}
		}
		
		private function addLaserSegment(x:Number, y:Number, index:int = -1):void
		{
			var segment:* = new _mcClass();
			segment.gotoAndStop(1);
			if (!_lastPos)
			{
				_lastPos = new Point(x, y);
			}
			segment.x = _lastPos.x;
			segment.y = _lastPos.y;
			if (segment.setLength)
			{
				segment.setLength(BBMath.dist(_lastPos.x, _lastPos.y, x, y));
			}
			else
			{
				segment.width = BBMath.dist(_lastPos.x, _lastPos.y, x, y);
			}
			segment.rotation = Math.atan2(y - _lastPos.y, x - _lastPos.x) / Math.PI * 180;
			segment.blendMode = _blendMode;
			if (index == -1)
			{
				_layer.addChild(segment);
			}
			else
			{
				_layer.addChildAt(segment, index);
			}
			_mcs.push(segment);
			_lastPos = new Point(x, y);
		}
		
		private function removeLaserSegment(index:int):void
		{
			try
			{
				_layer.removeChild(_mcs[index]);
			}
			catch (err:Error)
			{
			}
			_mcs.splice(index, 1);
		}
		
		public function stop():void
		{
			_isStop = true;
		}
		
		public function removeSelf():void
		{
			if (onRemove != null)
			{
				onRemove(this);
			}
		}
		
		public function destroy():void
		{
			for (var i:int = 0; i < _mcs.length; ++i)
			{
				try
				{
					_layer.removeChild(_mcs[i]);
				}
				catch (err:Error)
				{
				}
			}
			_mcs = null;
		}
	}

}