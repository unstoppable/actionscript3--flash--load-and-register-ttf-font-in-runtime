package org.sepy.fontreader.table
{
	public interface IGlyphDescription
	{
	    function getGlyphIndex():int;
	    function getEndPtOfContours(i:int):int;
	    function getFlags(i:int):int;
	    function getXCoordinate(i:int):int;
	    function getYCoordinate(i:int):int;
	    function getXMaximum():int;
	    function getXMinimum():int;
	    function getYMaximum():int;
	    function getYMinimum():int;
	    function isComposite():Boolean;
	    function getPointCount():int;
	    function getContourCount():int;
	    function toString():String;
	}
}