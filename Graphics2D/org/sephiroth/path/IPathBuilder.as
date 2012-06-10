package org.sephiroth.path
{
	public interface IPathBuilder
	{
		function get hasStartPoint():Boolean;
		
		function moveTo(x:Number, y:Number):void;
		function lineTo( x:Number, y:Number ):void;
		function curveTo( anchor_x:Number, anchor_y:Number, dest_x:Number, dest_y:Number ):void;
		function quadTo( anchor_x:Number, anchor_y:Number, dest_x:Number, dest_y:Number ):void;
		function cubeTo( anchor_x:Number, anchor_y:Number, anchor_x2:Number, anchor_y2:Number, dest_x:Number, dest_y:Number ):void;
		function addSegment(s:ISegment):void;
		function close():void;
		function createPath():IPath;
	}
}