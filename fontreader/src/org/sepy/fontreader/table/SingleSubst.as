package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class SingleSubst implements ILookupSubtable
	{

	    virtual public function getFormat():int
	    {
	    	throw new Error("NonImplementationException");
	    }
	
	    virtual public function substitute(glyphId:int):int
	    {
	    	throw new Error("NonImplementationException");
	    }
	    
	    public static function read( dis:ByteArray, offset:uint ):SingleSubst
	    {
	        var s:SingleSubst = null;
	        dis.position = offset;
	        
	        var format:uint = dis.readUnsignedShort();

	        if (format == 1) 
	            s = new SingleSubstFormat1( dis, offset );
	        else if (format == 2)
	            s = new SingleSubstFormat2( dis, offset );

	        return s;
	    }
		
		
		virtual public function getTypeAsString():String
		{
			throw new Error("NonImplementationException");;
		}
		
	}
}