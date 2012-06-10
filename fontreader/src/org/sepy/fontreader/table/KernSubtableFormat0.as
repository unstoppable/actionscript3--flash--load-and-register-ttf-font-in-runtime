package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	internal class KernSubtableFormat0 extends KernSubtable
	{
	    private var nPairs:uint;
	    private var searchRange:uint;
	    private var entrySelector:uint;
	    private var rangeShift:uint;
	    private var kerningPairs:Array;		// KerningPair[]
	
	
	    /**
	     * 
	     * @param di
	     * @throws IOError
	     */
	    public function KernSubtableFormat0( di:ByteArray ):void
	    {
	        nPairs        = di.readUnsignedShort();
	        searchRange   = di.readUnsignedShort();
	        entrySelector = di.readUnsignedShort();
	        rangeShift    = di.readUnsignedShort();
	        
	        kerningPairs = new Array( nPairs );
	        
	        for (var i:int = 0; i < nPairs; i++)
	        {
	            kerningPairs[i] = new KerningPair(di);
	        }
	    }
	
	    override public function getKerningPairCount():uint
	    {
	        return nPairs;
	    }
	
	    override public function getKerningPair( i:uint ):KerningPair
	    {
	        return kerningPairs[i];
	    }		
	}
}