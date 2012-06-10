package fox.shape
{

	import org.sepy.fontreader.geom.GlyphPoint;
	import org.sepy.fontreader.table.GlyfDescript;
	import org.sepy.fontreader.table.IGlyphDescription;

	public class TTFGlyph
	{

		private var points:Vector.<GlyphPoint>;

		public function TTFGlyph(gd:IGlyphDescription):void
		{
			var endPtIndex:int=0;
			points=new Vector.<GlyphPoint>();
			var len:int=gd.getPointCount();
			for (var i:int=0; i < len; i++)
			{
				var endPt:Boolean=gd.getEndPtOfContours(endPtIndex) == i;
				if (endPt)
				{
					endPtIndex++;
				}
				var gp:GlyphPoint=new GlyphPoint(gd.getXCoordinate(i), gd.getYCoordinate(i), (gd.getFlags(i) & GlyfDescript.onCurve) != 0, endPt);
				points.push(gp);
			}
		}

		public function getPoint(i:int):GlyphPoint
		{
			return points[i];
		}

		public function getNumPoints():int
		{
			return points.length;
		}

		public function scale(factor:Number):void
		{
			for (var i:int=0; i < points.length; i++)
			{
				points[i].x*=factor;
				points[i].y*=-factor;
			}
		}
	}
}