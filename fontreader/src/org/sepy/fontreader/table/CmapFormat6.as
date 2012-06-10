package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.exception.ArrayIndexOutOfBoundsException;
	
	internal class CmapFormat6 extends CmapFormat
	{
	    private var _firstCode:int;
	    private var _entryCount:int;
	    private var _glyphIdArray:Array;		// short[]
	
	    public function CmapFormat6( di:ByteArray ):void
	    {
	        super(di);
	        _format = 6;
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