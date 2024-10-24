package bvn.math
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	
	/**
	 * bb的常用数学相关方法
	 * @author BearBrine
	 */
	public class BBMath
	{
		
		/**
		 * @private
		 */
		public function BBMath()
		{
			throw new Error("BBMath:What are you doing???");
		}
		
		private static function _dist(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
		}
		
		/**
		 * 计算两点之间的距离
		 * @param	... args	格式为 (x1, y1, x2, y2) 或 (position1, position2)
		 * @return	当然是距离的计算结果啦~
		 */
		public static function dist(... args):Number
		{
			if (args.length == 4) {
				return _dist(args[0], args[1], args[2], args[3]);
			}
			if (args.length == 2){
				return _dist(args[0].x, args[0].y, args[1].x, args[1].y);
			}
		}
		
		private static function _randomSwitchNoWeight(arr:Array):*
		{
			return arr[Math.floor(Math.random() * arr.length)];
		}
		
		/**
		 * 从数组中随机选取一个对象并返回该对象
		 * @param	arr			目标数组
		 * @param	weightArr	数组中每一项的权值，权值越高被选中的概率越大，该数组长度必须和目标数组一致，默认设置为 null 选取到每一项的概率一致
		 * @return	随机选取出的对象
		 */
		public static function randomSwitch(arr:Array, weightArr:Array = null):*
		{
			if (!arr.length) return null;
			if (!weightArr) {
				return _randomSwitchNoWeight(arr);
			}
			var totVal:Number = 0;
			for (var i:int = 0; i < weightArr.length; ++i) 
			{
				totVal += weightArr[i];
			}
			var randVal:Number = Math.random() * totVal;
			totVal = 0;
			for (var j:int = 0; j < weightArr.length; ++j) 
			{
				totVal += weightArr[j];
				if (randVal < totVal) return arr[j];
			}
			throw new Error("Weight array is end.");
			return null;
		}

		/**
		 * 检测两个凸多边形是否相交，即是否发生碰撞
		 * 该方法使用分离轴定理来检测碰撞（使用 SATCollision 类中的实现）
		 * 多边形可以是包含点集（Point）的 Array，也可以是 Rectangle，也可以是支持旋转的矩形 DisplayObject
		 * 如果要检测的 DisplayObject 对象和另一个多边形不在同一层级，则可能需要 getRectPointsOfDisplay 方法
		 * 对于 DisplayObject，会将矩形的旋转角度临时设置为 0 后再恢复以方便检测
		 * 目前只支持凸多边形检测，不支持凹多边形
		 * 
		 * @param	poly1	多边形1
		 * @param	poly2	多边形2
		 * @return	如果相交返回 true，否则返回 false
		 * @throws	如果传入的参数不是 Array、Rectangle 或 DisplayObject 则抛出异常
		 * @see #getRectPointsOfDisplay
		 * @see SATCollision
		 * @see SATCollision#collide
		 */
		public static function polygonCollide(poly1, poly2) 
		{
			function transType(poly):Array
			{
				if (poly is Array) {
					return poly;
				}
				var points:Array;
				
				if (poly is Rectangle) {
					points = [
						new Point(poly.x, poly.y),
						new Point(poly.x + poly.width, poly.y),
						new Point(poly.x + poly.width, poly.y + poly.height),
						new Point(poly.x, poly.y + poly.height)
					];
				}
				else if (poly is DisplayObject) {
					points = getRectPointsOfDisplay(poly);
				}
				else {
					throw new Error("无法识别的多边形类型！");
				}
				return points;
			}
			return SATCollision.collide(transType(poly1), transType(poly2));
		}

		/**
		 * 获取一个 DisplayObject 的矩形顶点坐标数组，可以指定相对于某个包含自身的对象以获取相对的坐标
		 * 用于和一些不在同一层级的多边形检测碰撞而提供正确的坐标数组
		 * @param	obj		目标对象
		 * @param	container	如果 container 不为空且 obj 不为 container 的子项，则会抛出错误，默认为 null
		 * @return	返回一个 Array，数组中包含四个 Point 对象，依次为左上、右上、左下、右下四个顶点坐标
		 * @throws	如果传入的参数不是 DisplayObject 则抛出异常
		 * @see #polygonCollide
		 */
		public static function getRectPointsOfDisplay(obj:DisplayObject, container:DisplayObjectContainer = null):Array
		{
			if (container != null && !container.contains(obj)) {
				throw new Error("obj 不为 container 的子项！");
			}
			var matrix: Matrix = obj.transform.matrix.clone();
			obj.transform.matrix = new Matrix();
			
			var rect: Rectangle = obj.getBounds(obj);
			
			obj.transform.matrix = matrix.clone();
			if (container != null) {
				for (var parent: DisplayObjectContainer = obj.parent; true; parent = parent.parent) {
					matrix.concat(parent.transform.matrix);
					if (parent == container) {
						break;
					}
				}
			}

			return [
				matrix.transformPoint(new Point(rect.x, rect.y)),
				matrix.transformPoint(new Point(rect.x + rect.width, rect.y)),
				matrix.transformPoint(new Point(rect.x, rect.y + rect.height)),
				matrix.transformPoint(new Point(rect.x + rect.width, rect.y + rect.height))
			];
		}
		
	}

}