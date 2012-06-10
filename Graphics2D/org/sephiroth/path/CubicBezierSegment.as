package org.sephiroth.path
{
	import flash.geom.Point;
	
	public class CubicBezierSegment extends CurvedSegment
	{
		private var $x1:Number;
		private var $x2:Number;
		private var $x3:Number;
		private var $y1:Number;
		private var $y2:Number;
		private var $y3:Number;
		
		public function CubicBezierSegment( x1:Number, y1:Number, x2:Number, y2:Number, x3:Number, y3:Number):void
		{
			super();
			this.$x1 = x1;
			this.$x2 = x2;
			this.$x3 = x3;
			this.$y1 = y1;
			this.$y2 = y2;
			this.$y3 = y3;
		}
		
		public override function calcPoint( t:Number, position:Point ):Point
		{
			var it:Number = 1.0 - t;
			var a1:Number = it * it * it;
			var a2:Number = 3.0 * t * it * it;
			var a3:Number = 3.0 * t * t * it;
			var a4:Number = t * t * t;
			var point:Point = new Point();
			
			point.x = a1 * position.x + a2 * $x1 + a3 * $x2 + a4 * $x3;
			point.y = a1 * position.y + a2 * $y1 + a3 * $y2 + a4 * $y3;
			return point;
		}		
		
	}
}