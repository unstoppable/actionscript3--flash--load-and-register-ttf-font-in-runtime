package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.exception.NonImplementationException;
	
	public class Coverage
	{
	    public function get format():int
	    {
	    	throw new NonImplementationException();
	    }
	
	    /**
	     * @param glyphId The ID of the glyph to find.
	     * @return The index of the glyph within the coverage, or -1 if the glyph
	     * can't be found.
	     */
	    public function findGlyph( glyphId:int ):int
	    {
	    	throw new NonImplementationException();
	    }
	    
	    internal static function read( di:ByteArray ):Coverage
	    {
	        var c:Coverage  = null;
	        var format:uint = di.readUnsignedShort();
	        
	        if (format == 1)
	            c = new CoverageFormat1(di);
	        else if (format == 2)
	            c = new CoverageFormat2(di);
	        return c;
	    }		
	}
}