package org.sephiroth.path
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class LineSegment implements ISegment
	{
		private var x:Number;
		private var y:Number;
		
		public function LineSegment( x1:Number, y1:Number ):void
		{
			this.x = x1;
			this.y = y1;
		}
		
		public function walk(walker:IPathWalker, position:Point):void
		{
			walker.lineTo( this.x, this.y );
			position.x = this.x;
			position.y = this.y;
		}
		
		public function getBounds(r:Rectangle, position:Point):void
		{
		}
		
	}
}