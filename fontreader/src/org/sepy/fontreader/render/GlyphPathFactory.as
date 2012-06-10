package org.sepy.fontreader.render
{
	import org.sephiroth.path.IPathBuilder;
	import org.sephiroth.path.PathBuilder;
	import org.sepy.fontreader.geom.Glyph;
	import org.sepy.fontreader.geom.GlyphPoint;
	
	public class GlyphPathFactory
	{
	    public static function buildPath( glyph:Glyph ):IPathBuilder
	    {
	        if (glyph == null) 
	            return null;
	
	        var path:PathBuilder;
	        var firstIndex:int = 0;
	        var count:int      = 0;
	        
	        path = new PathBuilder();
	        
	        for (var i:uint = 0; i < glyph.getPointCount(); i++)
	        {
	            count++;
	            if (glyph.getPoint(i).endOfContour)
	            {
	                addContourToPath(path, glyph, firstIndex, count);
	                firstIndex = i + 1;
	                count = 0;
	            }
	        }
	        return path;
	    }
	    
	    private static function addContourToPath( gp:IPathBuilder, glyph:Glyph, startIndex:int, count:int ):void
	    {
	        var offset:int = 0;
	        var connect:Boolean = false;
	        
	        while (offset < count)
	        {
	            var point_minus1:GlyphPoint = glyph.getPoint((offset==0) ? startIndex+count-1 : startIndex+(offset-1)%count);
	            var point:GlyphPoint        = glyph.getPoint(startIndex + offset%count);
	            var point_plus1:GlyphPoint  = glyph.getPoint(startIndex + (offset+1)%count);
	            var point_plus2:GlyphPoint  = glyph.getPoint(startIndex + (offset+2)%count);
	            if(offset == 0)
	            {
	            	gp.moveTo(point.x, -point.y);
	            }
	            
	            if (point.onCurve && point_plus1.onCurve)
	            {
	                gp.lineTo( point_plus1.x, -point_plus1.y );
	                offset++;
	                
	            } else if (point.onCurve && !point_plus1.onCurve && point_plus2.onCurve)
	            {
	                gp.quadTo(point_plus1.x, -point_plus1.y, point_plus2.x, -point_plus2.y);
	                offset+=2;
	            } else if (point.onCurve && !point_plus1.onCurve && !point_plus2.onCurve)
	            {
	                //gp.lineTo( point_plus1.x, -point_plus1.y );
	                gp.quadTo(point_plus1.x, -point_plus1.y, midValue(point_plus1.x, point_plus2.x), -midValue(point_plus1.y, point_plus2.y));
	                offset+=2;
	            } else if (!point.onCurve && !point_plus1.onCurve)
	            {
	            	//gp.lineTo( point_plus1.x, -point_plus1.y );
	            	//gp.curve3(midValue(point.x, point_plus1.x), -midValue(point.y, point_plus1.y), point.x, -point.y);
	                gp.quadTo(point.x, -point.y, midValue(point.x, point_plus1.x), -midValue(point.y, point_plus1.y));
	                offset++;
	            } else if (!point.onCurve && point_plus1.onCurve)
	            {
	            	//gp.lineTo( point_plus1.x, -point_plus1.y );
	            	//gp.curve3(point_plus1.x, -point_plus1.y, point.x, -point.y);
	                gp.quadTo(point.x, -point.y, point_plus1.x, -point_plus1.y);
	                offset++;
	            } else {
	                trace("Cannot draw the glyph");
	                break;
	            }
	            connect = true;
	        }
	    }
	
	    private static function midValue( a:int, b:int ):int
	    {
	        return a + (b - a)/2;
	    }
	}
}