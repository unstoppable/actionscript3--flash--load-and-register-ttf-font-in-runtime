package org.sepy.fontreader.table
{
	internal class Range 
	{
	    private var _startCode:int;
	    private var _endCode:int;
	    
	    function Range( startCode:int, endCode:int ):void
	    {
	        _startCode = startCode;
	        _endCode   = endCode;
	    }
	    
	    public function getStartCode():int
	    {
	        return _startCode;
	    }
	    
	    public function getEndCode():int
	    {
	        return _endCode;
	    }
	}
}