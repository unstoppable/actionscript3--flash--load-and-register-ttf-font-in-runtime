package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class RangeRecord
	{
	    private var _start:uint;
	    private var _end:uint;
	    private var _startCoverageIndex:uint;
	
	    public function RangeRecord( di:ByteArray ):void
	    {
	        _start = di.readUnsignedShort();
	        _end   = di.readUnsignedShort();
	        _startCoverageIndex = di.readUnsignedShort();
	    }
	
	    public function isInRange( glyphId:int ):Boolean
	    {
	        return (_start <= glyphId && glyphId <= _end);
	    }
	    
	    public function getCoverageIndex( glyphId:int ):int
	    {
	        if (isInRange(glyphId))
	        {
	            return _startCoverageIndex + glyphId - _start;
	        }
	        return -1;
	    }
	}
}