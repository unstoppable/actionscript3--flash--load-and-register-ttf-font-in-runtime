package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class LigatureSet
	{
	    private var _ligatureCount:uint;
	    private var _ligatureOffsets:Array;
	    private var _ligatures:Array;
	
	    public function LigatureSet( dis:ByteArray, offset:uint ):void
	    {
	    	var i:uint;
	        dis.position = offset;
	        
	        _ligatureCount   = dis.readUnsignedShort();
	        _ligatureOffsets = new Array( _ligatureCount );
	        _ligatures       = new Array( _ligatureCount );
	        
	        for (i = 0; i < _ligatureCount; i++)
	        {
	            _ligatureOffsets[i] = dis.readUnsignedShort();
	        }
	        
	        for (i = 0; i < _ligatureCount; i++)
	        {
	            dis.position = (offset + _ligatureOffsets[i]);
	            _ligatures[i] = new Ligature(dis);
	        }
	    }		
	}
}