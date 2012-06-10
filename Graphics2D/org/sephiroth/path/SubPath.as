package org.sephiroth.path
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class SubPath
	{
		private var $startPoint:Point;
		private var $segments:Array;
		private var $closed:Boolean;
		
		public function SubPath(startPoint:Point, segments:Array, closed:Boolean):void
		{
			this.$startPoint = startPoint.clone();
			this.$segments   = segments.concat();
			this.$closed     = closed;
		}
		
		public function get startPoint():Point 
		{
			return this.$startPoint.clone();
		}

		public function get closed():Boolean
		{
			return this.$closed;
		}
	
		public function get segments():Array
		{
			return this.$segments.concat();
		}
	
		public function walk( walker:IPathWalker ):void
		{
			var position:Point = this.$startPoint.clone();
			walker.beginSubPath(closed);
			
			walker.moveTo(this.$startPoint.x, this.$startPoint.y);
			for(var i:int = 0; i < this.$segments.length; i++)
			{
				ISegment(segments[i]).walk( walker, position );
			}
			walker.endSubPath( this.$startPoint );
		}
		
		public function getBounds(r:Rectangle):void
		{

		}
	}
}