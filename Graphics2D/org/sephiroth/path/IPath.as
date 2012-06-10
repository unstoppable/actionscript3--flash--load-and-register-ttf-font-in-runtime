package org.sephiroth.path
{
	import flash.geom.Rectangle;
	
	public interface IPath
	{
		function walk( walker:IPathWalker ):void;
		function getBounds():Rectangle;
	}
}