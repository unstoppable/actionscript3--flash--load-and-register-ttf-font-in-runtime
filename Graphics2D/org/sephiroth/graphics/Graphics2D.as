package org.sephiroth.graphics
{
	import flash.display.Graphics;

	import mx.graphics.IFill;
	import mx.graphics.IStroke;

	import org.sephiroth.path.GenericPathWalker;
	import org.sephiroth.path.IPath;
	import org.sephiroth.path.IPathBuilder;
	import org.sephiroth.path.IPathWalker;
	import org.sephiroth.path.PathBuilder;

	public class Graphics2D
	{
		private var $path:IPathBuilder;
		private var $stroke:IStroke;
		private var $fill:IFill;
		private var $graphic:Graphics;

		public function Graphics2D(g:Graphics, stroke:IStroke, fill:IFill)
		{
			this.$graphic=g;
			this.$stroke=stroke;
			this.$fill=fill;
			this.$path=new PathBuilder();
		}

		public function get path():IPathBuilder
		{
			return this.$path;
		}

		public function set path(value:IPathBuilder):void
		{
			this.$path=value;
		}

		public function render(walker:IPathWalker=null):void
		{
			if (this.$stroke)
				this.$stroke.apply(this.$graphic, null, null);

			if (this.$fill)
				this.$fill.begin(this.$graphic, null, null);

			var pathIterator:IPath=this.$path.createPath();
			pathIterator.walk(walker || new GenericPathWalker(this.$graphic));

			if (this.$fill)
				this.$fill.end(this.$graphic);
		}

	}
}