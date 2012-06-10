package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	import org.sepy.fontreader.lang.IComparable;

	public class CmapIndexEntry implements IComparable
	{
		
	    private var _platformId:uint;
	    private var _encodingId:uint;
	    private var _offset:int;
	    private var _format:CmapFormat;
	
	    public function CmapIndexEntry(di:ByteArray):void
	    {
	        _platformId = di.readUnsignedShort();
	        _encodingId = di.readUnsignedShort();
	        _offset = di.readInt();
	    }
	
	    public function get platformId():uint
	    {
	        return _platformId;
	    }
	
	    public function get encodingId():uint
	    {
	        return _encodingId;
	    }
	
	    public function get offset():int
	    {
	    	return _offset;
	    }
	
	    public function get format():CmapFormat
	    {
	        return _format;
	    }
	    
	    public function set format(format:CmapFormat):void
	    {
	        _format = format;
	    }
	
	    public function toString():String
	    {
	        return new StringBuffer()
	            .append("platform id: ")
	            .append(_platformId)
	            .append(" (")
	            .append(ID.getPlatformName(_platformId))
	            .append("), encoding id: ")
	            .append(_encodingId)
	            .append(" (")
	            .append(ID.getEncodingName(_platformId, _encodingId))
	            .append("), offset: ")
	            .append(_offset).toString();
	    }
	
	    public function compareTo( obj:Object ):int
	    {
	        var entry:CmapIndexEntry = CmapIndexEntry(obj);
	        
	        if (offset < entry.offset)
	        {
	            return -1;
	        } else if (offset > entry.offset)
	        {
	            return 1;
	        } else {
	            return 0;
	        }
	    }
	}
}