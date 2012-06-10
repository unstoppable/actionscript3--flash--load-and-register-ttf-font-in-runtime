package org.sephiroth.path
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.sephiroth.errors.NonImplementationError;

	[ExcludeClass]
	public class CurvedSegment implements ISegment
	{
		public function getBounds(r:Rectangle, position:Point):void
		{
		}
		
		virtual public function calcPoint( t:Number, position:Point ):Point
		{
			throw new NonImplementationError("calPoint must be overridded by extended class");
		}

		public function walk( walker:IPathWalker, position:Point ):void
		{
			var p1:Point = position;
			var p2:Point = calcPoint(1.0, position);
			
			iterate(walker, position, 0.0, p1, 1.0, p2, 1 );
			position.x = p2.x;
			position.y = p2.y;
		}
	
		private function iterate( walker:IPathWalker, position:Point, t1:Number, p1:Point, t2:Number, p2:Point, error:Number ):void
		{
			//trace('iterate');
			var tc:Number = (t1 + t2) / 2.0;
			var pc:Point = calcPoint(tc, position);
			var ex:Number;
			var ey:Number;
			var tex:Number;
			var tey:Number;
				
			ex = pc.x - (p1.x + p2.x) / 2.0;
			ey = pc.y - (p1.y + p2.y) / 2.0;
			
			tex = ex + ey;
			tey = ex + ey;
			if(tex * tex + tey * tey >= error * error)
			{
				iterate(walker, position, t1, p1, tc, pc, error);
				iterate(walker, position, tc, pc, t2, p2, error);
			} else 
			{
				walker.lineTo(p2.x, p2.y);
			}
		}

		
	}
}