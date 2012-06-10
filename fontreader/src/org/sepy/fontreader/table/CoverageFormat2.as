package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	internal class CoverageFormat2 extends Coverage
	{
	    private var _rangeCount:uint;
	    private var _rangeRecords:Array;
	
	    public function CoverageFormat2( di:ByteArray ):void
	    {
	        _rangeCount   = di.readUnsignedShort();
	        _rangeRecords = new Array( _rangeCount );
	        
	        for (var i:uint = 0; i < _rangeCount; i++)
	        {
	            _rangeRecords[i] = new RangeRecord(di);
	        }
	    }
	
	    override public function get format():int
	    {
	        return 2;
	    }
	
	    override public function findGlyph( glyphId:int ):int
	    {
	    	var n:int;
	        for (var i:uint = 0; i < _rangeCount; i++)
	        {
	            n = RangeRecord(_rangeRecords[i]).getCoverageIndex(glyphId);
	            if (n > -1)
	            {
	                return n;
	            }
	        }
	        return -1;
	    }		
	}
}