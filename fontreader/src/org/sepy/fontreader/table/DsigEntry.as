package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class DsigEntry
	{
	    private var _format:int;
	    private var _length:int;
	    private var _offset:int;
	    
	    public function DsigEntry(di:ByteArray):void
	    {
	        _format = di.readInt();
	        _length = di.readInt();
	        _offset = di.readInt();
	    }
	
	    public function get format():int
	    {
	        return _format;
	    }
	    
	    public function get length():int
	    {
	        return _length;
	    }
	    
	    public function get offset():int
	    {
	        return offset;
	    }

	}
}