package org.sephiroth.path
{
	import flash.geom.Rectangle;

	public class GenericPath implements IPath
	{
		private var $subPaths:Array;
		
		public function GenericPath( paths:Array ):void
		{
			this.$subPaths = paths;
		}
		
		public function walk( walker:IPathWalker ):void
		{
			for(var i:int = 0; i < this.$subPaths.length; i++)
			{
				SubPath(this.$subPaths[i]).walk( walker );
			}
		}
		
		public function getBounds():Rectangle
		{
			return null;
		}
		
	}
}