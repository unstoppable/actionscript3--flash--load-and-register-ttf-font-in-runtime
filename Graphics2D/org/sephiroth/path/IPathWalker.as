package org.sephiroth.path
{
	import flash.geom.Point;
	
	public interface IPathWalker
	{
		function beginSubPath( closed:Boolean ):void;
		function endSubPath( startPoint:Point ):void;
		
		function lineTo( x:Number, y:Number ):void;
		function moveTo( x:Number, y:Number ):void;
		function curveTo( x1:Number, y1:Number, x2:Number, y2:Number ):void;
	}
}