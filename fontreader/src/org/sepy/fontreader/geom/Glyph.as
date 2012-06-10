package org.sepy.fontreader.geom
{
	import flash.geom.Point;
	
	import org.sepy.fontreader.table.GlyfDescript;
	import org.sepy.fontreader.table.IGlyphDescription;
	
	public class Glyph
	{
	    protected var _leftSideBearing:int;
	    protected var _advanceWidth:int;
	    
	    private var _points:Array;	// GlyphPoints[]
	
	    /**
	     * Construct a Glyph from a TrueType outline described by
	     * a GlyphDescription.
	     * @param cs The Charstring describing the glyph.
	     * @param lsb The Left Side Bearing.
	     * @param advance The advance width.
	     */
	    public function Glyph( gd:IGlyphDescription, lsb:int, advance:int ):void
	    {
	        _leftSideBearing = lsb;
	        _advanceWidth = advance;
	        describe(gd);
	    }
	
	    public function getAdvanceWidth():int
	    {
	        return _advanceWidth;
	    }
	
	    public function getLeftSideBearing():int
	    {
	        return _leftSideBearing;
	    }
	
	    public function getPoint( i:int ):GlyphPoint
	    {
	        return _points[i];
	    }
	
	    public function getPointCount():int
	    {
	        return _points.length;
	    }
	
	    public function reset():void
	    {
	    }
	
	    /**
	     * @param factor a 16.16 fixed value
	     */
	    public function scale( factor:int ):void
	    {
	        for (var i:uint = 0; i < _points.length; i++)
	        {
	            GlyphPoint(_points[i]).x = ((GlyphPoint(_points[i]).x << 10) * factor) >> 26;
	            GlyphPoint(_points[i]).y = ((GlyphPoint(_points[i]).y << 10) * factor) >> 26;
	        }
	        
	        _leftSideBearing = (( _leftSideBearing * factor) >> 6);
	        _advanceWidth    = (_advanceWidth * factor) >> 6;
	    }
	
	    /**
	     * Set the points of a glyph from the GlyphDescription
	     */
	    private function describe( gd:IGlyphDescription ):void
	    {
	        var endPtIndex:int = 0;
	        _points = new Array( gd.getPointCount() + 2 );
	        
	        for (var i:uint = 0; i < gd.getPointCount(); i++)
	        {
	            var endPt:Boolean = gd.getEndPtOfContours(endPtIndex) == i;
	            if (endPt)
	            {
	                endPtIndex++;
	            }
	            _points[i] = new GlyphPoint( gd.getXCoordinate(i), gd.getYCoordinate(i), (gd.getFlags(i) & GlyfDescript.onCurve) != 0, endPt);
	        }
	
	        _points[gd.getPointCount()]   = new GlyphPoint(0, 0, true, true);
	        _points[gd.getPointCount()+1] = new GlyphPoint(_advanceWidth, 0, true, true);
	    }		
	}
}