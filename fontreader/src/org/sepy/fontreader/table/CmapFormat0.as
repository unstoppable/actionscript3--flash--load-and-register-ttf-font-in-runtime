package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.exception.ArrayIndexOutOfBoundsException;
	
	internal class CmapFormat0 extends CmapFormat
	{
	    private var _glyphIdArray:Array = new Array(256);	// int[]
	
	    function CmapFormat0( di:ByteArray):void
	    {
			super(di);
	        _format = 0;
	        
	        for (var i:uint = 0; i < 256; i++)
	        {
	            _glyphIdArray[i] = di.readUnsignedByte();
	        }
	    }
	
	    override public function get rangeCount():int
	    {
	        return 1;
	    }
	    
	    /**
	     * 
	     * @param index
	     * @return 
	     * @throws ArrayIndexOutOfBoundsException
	     */
	    override public function getRange( index:int ):Range
		{
	        if (index != 0) {
	            throw new ArrayIndexOutOfBoundsException();
	        }
	        return new Range(0, 255);
	    }
	
	    override public function mapCharCode( charCode:int ):int
	    {
	        if (0 <= charCode && charCode < 256)
	        {
	            return _glyphIdArray[charCode];
	        } else 
	        {
	            return 0;
	        }
	    }
	}
}