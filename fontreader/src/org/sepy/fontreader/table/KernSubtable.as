package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	import org.sepy.fontreader.exception.NonImplementationException;
	
	public class KernSubtable
	{
	    public function KernSubtable() 
	    {
	    }
	    
	    virtual public function getKerningPairCount():uint
	    {
	    	throw new NonImplementationException();
	    }
	
	    virtual public function getKerningPair(i:uint):KerningPair 
	    {
	    	throw new NonImplementationException();
	    }
	
	    /**
	     * 
	     * @param di
	     * @throws IOError
	     */
	    public static function read( di:ByteArray ):KernSubtable
	    {
	        var table:KernSubtable;
	        var version:uint  = di.readUnsignedShort();
	        var length:uint   = di.readUnsignedShort();
	        var coverage:uint = di.readUnsignedShort();
	        var format:int   = coverage >> 8;
	        
	        switch (format)
	        {
	        	case 0:
	            	table = new KernSubtableFormat0(di);
	            	break;
	        	case 2:
	            	table = new KernSubtableFormat2(di);
	            	break;
	        	default:
	            	break;
	        }
	        
	        return table;
	    }		
	}
}