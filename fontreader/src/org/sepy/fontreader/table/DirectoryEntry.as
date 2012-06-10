package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.lang.ICloneable;

	public class DirectoryEntry implements ICloneable
	{

	    private var _tag:int;
	    private var _checksum:int;
	    private var _offset:int;
	    private var _length:int;

	    public function DirectoryEntry(di:ByteArray = null):void
	    {
	    	if(di)
	    	{
		        _tag      = di.readInt();
		        _checksum = di.readInt();
		        _offset   = di.readInt();
		        _length   = di.readInt();
		    }
	    }
	    
	    public function clone():Object
	    {
	    	var d:DirectoryEntry = new DirectoryEntry();
	    	d._tag      = _tag;
	    	d._checksum = _checksum;
	    	d._offset   = _offset;
	    	d._length   = _length;
	    	return d;
	    }

	    public function get checksum():int 
	    {
	        return _checksum;
	    }
	
	    public function get length():int
	    {
	        return _length;
	    }
	
	    public function get offset():int
	    {
	        return _offset;
	    }
	
	    public function get tag():int
	    {
	        return _tag;
	    }

	    public function getTagAsString():String
	    {
	        return (String.fromCharCode((_tag >> 24) & 0xff) +  
	        	String.fromCharCode((_tag >> 16) & 0xff) + 
	            String.fromCharCode((_tag >> 8) & 0xff) + 
	            String.fromCharCode((_tag) & 0xff)).toString();
	    }
	    
	    
	    public function toString():String
	    {
	        return "'" + getTagAsString()
	            + "' - chksm = 0x" + _checksum.toString(16)
	            + ", off = 0x" + _offset.toString(16)
	            + ", len = " + _length;
	    }	    
		
	}
}