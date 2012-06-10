package org.sephiroth.path
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public interface ISegment
	{
		function walk( walker:IPathWalker, position:Point ):void;
		function getBounds(r:Rectangle, position:Point):void;		
	}
}