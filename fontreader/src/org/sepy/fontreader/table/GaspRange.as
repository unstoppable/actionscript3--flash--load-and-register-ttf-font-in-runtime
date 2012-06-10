package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class GaspRange
	{
	    public static const GASP_GRIDFIT:int = 1;
	    public static const GASP_DOGRAY:int  = 2;
	    
	    private var rangeMaxPPEM:int;
	    private var rangeGaspBehavior:int;
	    
	    public function GaspRange( di:ByteArray ):void
	    {
	        rangeMaxPPEM      = di.readUnsignedShort();
	        rangeGaspBehavior = di.readUnsignedShort();
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        
	        sb.append("  rangeMaxPPEM:        ").append(rangeMaxPPEM)
	            .append("\n  rangeGaspBehavior:   0x").append(rangeGaspBehavior);
	        if ((rangeGaspBehavior & GASP_GRIDFIT) != 0) {
	            sb.append("- GASP_GRIDFIT ");
	        }
	        if ((rangeGaspBehavior & GASP_DOGRAY) != 0) {
	            sb.append("- GASP_DOGRAY");
	        }
	        return sb.toString();
	    }
	}
}