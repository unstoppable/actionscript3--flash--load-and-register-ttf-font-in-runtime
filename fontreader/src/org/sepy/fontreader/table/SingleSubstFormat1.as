
package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class SingleSubstFormat1 extends SingleSubst
	{
	    private var _coverageOffset:uint;
	    private var _deltaGlyphID:int;
	    private var _coverage:Coverage;
	
	    public function SingleSubstFormat1( dis:ByteArray, offset:uint):void
	    {
	        _coverageOffset = dis.readUnsignedShort();
	        _deltaGlyphID   = dis.readShort();

	        dis.position = offset + _coverageOffset;
	        _coverage = Coverage.read(dis);
	    }
	
	    public function get format():uint
	    {
	        return 1;
	    }
	
	    override public function substitute(glyphId:int):int
	    {
	        var i:int = _coverage.findGlyph(glyphId);
	        if (i > -1) {
	            return glyphId + _deltaGlyphID;
	        }
	        return glyphId;
	    }
	    
	    override public function getTypeAsString():String
	    {
	        return "SingleSubstFormat1";
	    }		
	}
}