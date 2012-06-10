package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	import org.sepy.fontreader.exception.ArrayIndexOutOfBoundsException;
	import org.sepy.fontreader.exception.NonImplementationException;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class CmapFormat
	{
	    protected var _format:int;
	    protected var _length:uint;
	    protected var _language:uint;
	
	    public function CmapFormat( di:ByteArray ):void
	    {
	        _length   = di.readUnsignedShort();
	        _language = di.readUnsignedShort();
	    }
	
	    internal static function create(_format:int, di:ByteArray):CmapFormat
	    {
	        switch(_format)
	        {
	            case 0:
	                return new CmapFormat0(di);
	            case 2:
	                return new CmapFormat2(di);
	            case 4:
	                return new CmapFormat4(di);
	            case 6:
	                return new CmapFormat6(di);
	            default:
	                return new CmapFormatUnknown(_format, di);
	        }
	    }
	
	    public function get format():int
	    {
	        return _format;
	    }
	
	    public function get length():uint
	    {
	        return _length;
	    }
	
	    public function get language():uint
	    {
	        return _language;
	    }
	
	    virtual public function get rangeCount():int
	    {
	    	throw new NonImplementationException();
	    }
	    
	    virtual public function getRange(index:int):Range
	    {
	        throw new ArrayIndexOutOfBoundsException();
	    }
	
	    virtual public function mapCharCode(charCode:int):int
	    {
	    	throw new NonImplementationException();
	    }
	    
	    virtual public function toString():String
	    {
	        return new StringBuffer().append("format: ").append(_format).append(", length: ").append(_length).append(", language: ").append(_language).toString();
	    }
	}
}

