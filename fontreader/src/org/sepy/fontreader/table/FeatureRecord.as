package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class FeatureRecord
	{
	    private var _tag:int;
	    private var _offset:uint;
	
	    public function FeatureRecord( di:ByteArray ):void
	    {
	        _tag    = di.readInt();
	        _offset = di.readUnsignedShort();
	    }
	
	    public function get tag():int
	    {
	        return _tag;
	    }
	    
	    public function get offset():uint
	    {
	        return _offset;
	    }
	
	    public function getTagAsString():String
	    {
	        return new StringBuffer()
	            .append(String.fromCharCode((_tag>>24)&0xff))
	            .append(String.fromCharCode((_tag>>16)&0xff))
	            .append(String.fromCharCode((_tag>>8)&0xff))
	            .append(String.fromCharCode((_tag)&0xff))
	            .toString();
	    }
	}
}