package org.sephiroth.path
{
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;

	public class PathBuilder implements IPathBuilder
	{
		private var $subPaths:ArrayCollection;
		private var $segments:ArrayCollection;
		private var $startPoint:Point;
		private var $hasStartPoint:Boolean = false;
		
		public function PathBuilder():void
		{
			this.$subPaths   = new ArrayCollection();
			this.$segments   = new ArrayCollection();
			this.$startPoint = new Point();
		}
		
		public function get hasStartPoint():Boolean
		{
			return this.$hasStartPoint;
		}
		
		public function moveTo(x:Number, y:Number):void
		{
			if(hasStartPoint)
				endSubPath(false);
			this.$startPoint.x = x;
			this.$startPoint.y = y;
			this.$hasStartPoint = true;
		}
		
		public function lineTo( x:Number, y:Number ):void
		{
			if(hasStartPoint)
				this.$segments.addItem(new LineSegment(x, y));
			else
				moveTo(x, y);
		}
		
		public function curveTo( anchor_x:Number, anchor_y:Number, dest_x:Number, dest_y:Number ):void
		{
			addSegment( new CurveSegment( anchor_x, anchor_y, dest_x, dest_y ) );
		}
		
		public function quadTo( anchor_x:Number, anchor_y:Number, dest_x:Number, dest_y:Number ):void
		{
			addSegment( new QuadraticBezierSegment( anchor_x, anchor_y, dest_x, dest_y ) );
		}
		
		public function cubeTo( anchor_x:Number, anchor_y:Number, anchor_x2:Number, anchor_y2:Number, dest_x:Number, dest_y:Number ):void
		{
			addSegment( new CubicBezierSegment( anchor_x, anchor_y, anchor_x2, anchor_y2, dest_x, dest_y ) );
		}
		
		public function addSegment(s:ISegment):void
		{
			if(!hasStartPoint)
				throw new Error("There is no start point!!");
			this.$segments.addItem(s);
		}
		
		public function close():void
		{
			endSubPath(true);
		}
		
		private function endSubPath( closed:Boolean ):void
		{
			if(this.$segments.length > 0)
			{
				var subPath:SubPath = new SubPath(this.$startPoint, this.$segments.toArray(), closed);
				this.$subPaths.addItem( subPath );
				this.$segments.removeAll();
			}
			this.$hasStartPoint = false;
		}
		
		public function createPath():IPath
		{
			this.endSubPath(false);
			return new GenericPath(this.$subPaths.toArray());
		}
		
	}
}