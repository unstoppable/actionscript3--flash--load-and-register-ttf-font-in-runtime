package org.sephiroth.path
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class QuadraticBezierSegment extends CurvedSegment
	{
		private var $x1:Number;
		private var $y1:Number;
		private var $x2:Number;
		private var $y2:Number;
		
		public function QuadraticBezierSegment( x1:Number, y1:Number, x2:Number, y2:Number ):void
		{
			this.$x1 = x1;
			this.$y1 = y1;
			this.$x2 = x2;
			this.$y2 = y2;
		}
		
		public override function calcPoint( t:Number, position:Point):Point
		{
			var r:Point = new Point();
			var it:Number = 1.0 - t;
			var a1:Number = it * it;
			var a2:Number = 2.0 * t * it;
			var a3:Number = t * t;
		
			r.x = a1 * position.x + a2 * $x1 + a3 * $x2;
			r.y = a1 * position.y + a2 * $y1 + a3 * $y2;
			return r;
		}
	}
}