package org.sepy.fontreader.geom
{
	import flash.geom.Point;

	public class GlyphPoint extends Point
	{
	    public var onCurve:Boolean      = true;
	    public var endOfContour:Boolean = false;
	    public var touched:Boolean      = false;
	
	    public function GlyphPoint(_x:int, _y:int, _onCurve:Boolean, _endOfContour:Boolean):void
	    {
	    	super(_x, _y);
	        onCurve = _onCurve;
	        endOfContour = _endOfContour;
	    }		
	}
}