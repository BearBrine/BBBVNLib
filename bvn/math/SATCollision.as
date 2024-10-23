package bvn.math
{
	import flash.geom.Point;

    public class SATCollision
    {
        /**
         * 检查两个多边形是否碰撞
         * 该方法使用分离轴定理来检测碰撞
         * 
         * @param a 第一个多边形，表示为点的数组
         * @param b 第二个多边形，表示为点的数组
         * @return 如果多边形发生碰撞，则返回true；否则返回false
         */
        public static function collide(a:Array, b:Array):Boolean
        {
            var axes: Array = getAxes(a).concat(getAxes(b));

			for each(var axis: Point in axes) {
				var projection1: Array = projectPoints(a, axis);
				var projection2: Array = projectPoints(b, axis);

				if (!isOverlapping(projection1, projection2)) {
					return false;
				}
			}

			return true;
        }

        private static function getAxes(points: Array): Array {
			var axes: Array = [];
			for (var i: int = 0; i < points.length; i++) {
				var p1: Point = points[i];
				var p2: Point = points[(i + 1) % points.length];
				var edge: Point = new Point(p2.x - p1.x, p2.y - p1.y);
				var normal: Point = new Point(-edge.y, edge.x);
				normal.normalize(1);
				axes.push(normal);
			}
			return axes;
		}

        private static function projectPoints(points: Array, axis: Point): Array {
			var projections: Array = [];
			for each(var point: Point in points) {
				var projection: Number = point.x * axis.x + point.y * axis.y;
				projections.push(projection);
			}
			projections.sort(Array.NUMERIC);
			return [projections[0], projections[projections.length - 1]];
		}

		private static function isOverlapping(projection1: Array, projection2: Array): Boolean {
			return projection1[1] > projection2[0] && projection2[1] > projection1[0];
		}
    }
}