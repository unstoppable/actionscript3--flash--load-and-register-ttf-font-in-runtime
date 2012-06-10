package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.exception.ArrayIndexOutOfBoundsException;
	
	internal class CmapFormatUnknown extends CmapFormat
	{
	    public function CmapFormatUnknown( format:int, di:ByteArray ):void
	    {
	        super(di);
	        _format = format;

	        // We don't know how to handle this data, so we'll just skip over it
	        di.position += (_length - 4);
	    }
	
	    override public function get rangeCount():int
	    {
	        return 0;
	    }
	    
	    /**
	     * 
	     * @param index
	     * @return 
	     * @throws ArrayIndexOutOfBoundsException
	     */
	    override public function getRange( index:int ):Range
	    {
	        throw new ArrayIndexOutOfBoundsException();
	    }
	
	    override public function mapCharCode( charCode:int ):int
	    {
	        return 0;
	    }		
	}
}