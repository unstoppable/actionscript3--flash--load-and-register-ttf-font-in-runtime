package org.sephiroth.path
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class CurveSegment implements ISegment
	{
		private var $x1:Number;
		private var $y1:Number;
		private var $x2:Number;
		private var $y2:Number;
		
		
		public function CurveSegment( x1:Number, y1:Number, x2:Number, y2:Number ):void
		{
			this.$x1 = x1;
			this.$x2 = x2;
			this.$y1 = y1;
			this.$y2 = y2;
		}
		
		public function walk(walker:IPathWalker, position:Point):void
		{
			walker.curveTo( this.$x1, this.$y1, this.$x2, this.$y2 );
			position.x = this.$x2;
			position.y = this.$y2;
		}
		
		public function getBounds(r:Rectangle, position:Point):void
		{
		}
		
	}
}