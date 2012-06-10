package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	internal class KernSubtableFormat2 extends KernSubtable
	{
	    private var rowWidth:uint;
	    private var leftClassTable:uint;
	    private var rightClassTable:uint;
	    private var array:uint;
	
	    /**
	     * 
	     * @param di
	     * @throws IOError
	     */
	    public function KernSubtableFormat2( di:ByteArray ):void
	    {
	        rowWidth        = di.readUnsignedShort();
	        leftClassTable  = di.readUnsignedShort();
	        rightClassTable = di.readUnsignedShort();
	        array           = di.readUnsignedShort();
	    }
	
	    override public function getKerningPairCount():uint
	    {
	        return 0;
	    }
	
	    override public function getKerningPair( i:uint ):KerningPair
	    {
	        return null;
	    }
	}
}