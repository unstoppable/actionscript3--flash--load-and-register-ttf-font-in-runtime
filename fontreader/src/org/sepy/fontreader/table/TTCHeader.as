
package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class TTCHeader
	{
		public static const ttcf:int = 0x74746366;
		
	    private var ttcTag:int;
	    private var version:int;
	    private var _directoryCount:int;
	    private var tableDirectory:Array;		// int[]
	    private var dsigTag:int;
	    private var dsigLength:int;
	    private var dsigOffset:int;
		
		/**
		 * 
		 * @param di
		 * @throws IOError
		 */
		public function TTCHeader( di:ByteArray ):void
		{
        	ttcTag  = di.readInt();
        	version = di.readInt();
        	_directoryCount = di.readInt();
        	tableDirectory = new Array( _directoryCount );
        	
        	for (var i:int = 0; i < directoryCount; i++) 
        	{
            	tableDirectory[i] = di.readInt();
        	}
        	if (version == 0x00010000) 
        	{
            	dsigTag = di.readInt();
	        }
	        
        	dsigLength = di.readInt();
        	dsigOffset = di.readInt();
    	}
    	
	    public function get directoryCount():int
	    {
	        return _directoryCount;
	    }
	    
	    public function getTableDirectory( i:uint ):int
	    {
	        return tableDirectory[i];
	    }
		
	    public static function isTTC(di:ByteArray):Boolean
	    {
	        var ttcTag:int = di.readInt();
	        return ttcTag == ttcf;
	    }		
	}
}