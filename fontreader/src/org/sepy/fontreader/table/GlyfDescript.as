package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	import org.sepy.fontreader.exception.NonImplementationException;
	
	public class GlyfDescript extends Program implements IGlyphDescription
	{
	    public static const onCurve:int = 0x01;
	    public static const xShortVector:int = 0x02;
	    public static const yShortVector:int = 0x04;
	    public static const repeat:int = 0x08;
	    public static const xDual:int = 0x10;
	    public static const yDual:int = 0x20;
	
	    protected var _parentTable:GlyfTable;
	    
	    private var _glyphIndex:int;
	    private var _numberOfContours:int;
	    private var _xMin:int;
	    private var _yMin:int;
	    private var _xMax:int;
	    private var _yMax:int;
	
	    public function GlyfDescript( parentTable:GlyfTable, glyphIndex:int, numberOfContours:int,  di:ByteArray):void
	    {
	        _parentTable = parentTable;
	        _numberOfContours = numberOfContours;
	        _xMin = di.readShort();
	        _yMin = di.readShort();
	        _xMax = di.readShort();
	        _yMax = di.readShort();
	    }
	
	    public function getNumberOfContours():int
	    {
	        return _numberOfContours;
	    }
	
	    public function getGlyphIndex():int
	    {
	        return _glyphIndex;
	    }
	
	    public function getXMaximum():int
	    {
	        return _xMax;
	    }
	
	    public function getXMinimum():int
	    {
	        return _xMin;
	    }
	
	    public function getYMaximum():int
	    {
	        return _yMax;
	    }
	
	    public function getYMinimum():int
	    {
	        return _yMin;
	    }
	    
	    virtual public function getPointCount():int
	    {
	    	throw new NonImplementationException();
	    }
	    
	    virtual public function getContourCount():int
	    {
	    	throw new NonImplementationException();
	    }
	    
	    virtual public function getEndPtOfContours(i:int):int
	    {
	    	throw new NonImplementationException();
	    }

		virtual public function getFlags(i:int):int
		{
			throw new NonImplementationException();
		}
		
	    virtual public function getXCoordinate(i:int):int
	    {
	    	throw new NonImplementationException();
	    }
	    
	    virtual public function getYCoordinate(i:int):int
	    {
	    	throw new NonImplementationException();
	    }
	    
	    virtual public function isComposite():Boolean
	    {
	    	throw new NonImplementationException();
	    }
	    
	    virtual public function toString():String
	    {
	        return new StringBuffer()
	            .append("          numberOfContours: ").append(_numberOfContours)
	            .append("\n          xMin:             ").append(_xMin)
	            .append("\n          yMin:             ").append(_yMin)
	            .append("\n          xMax:             ").append(_xMax)
	            .append("\n          yMax:             ").append(_yMax)
	            .toString();
	    }		
	}
}