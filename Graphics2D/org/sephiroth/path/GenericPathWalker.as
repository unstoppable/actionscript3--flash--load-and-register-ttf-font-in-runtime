package org.sephiroth.path
{
	import flash.display.Graphics;
	import flash.geom.Point;
	
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	
	public class GenericPathWalker implements IPathWalker
	{
		private var $graphic:Graphics;
		private var $closed:Boolean;
		
		public function GenericPathWalker( g:Graphics )
		{
			this.$graphic = g;
		}
		
		public function beginSubPath(closed:Boolean):void
		{
			this.$closed = closed;
		}
		
		public function endSubPath( startPoint:Point ):void
		{
			if(this.$closed)
				this.$graphic.lineTo( startPoint.x, startPoint.y );
		}
		
		public function lineTo(x:Number, y:Number):void
		{
			this.$graphic.lineTo(x, y);
		}
		
		public function moveTo( x:Number, y:Number ):void
		{
			this.$graphic.moveTo(x, y);
		}
		
		public function curveTo( x1:Number, y1:Number, x2:Number, y2:Number ):void
		{
			this.$graphic.curveTo( x1, y1, x2, y2 );
		}
		
	}
}