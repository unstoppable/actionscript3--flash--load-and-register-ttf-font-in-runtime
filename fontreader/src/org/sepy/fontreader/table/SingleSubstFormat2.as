package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class SingleSubstFormat2 extends SingleSubst
	{
	    private var _coverageOffset:uint;
	    private var _glyphCount:uint;
	    private var _substitutes:Array;
	    private var _coverage:Coverage;
	
	    public function SingleSubstFormat2( dis:ByteArray, offset:uint ):void
	    {
	        _coverageOffset = dis.readUnsignedShort();
	        _glyphCount     = dis.readUnsignedShort();
	        _substitutes    = new Array( _glyphCount );
	        
	        for (var i:uint = 0; i < _glyphCount; i++)
	        {
	            _substitutes[i] = dis.readUnsignedShort();
	        }
	        
	        dis.position = offset + _coverageOffset;
	        _coverage = Coverage.read(dis);
	    }
	
	    public function get format():uint
	    {
	        return 2;
	    }
	
	    override public function substitute(glyphId:int):int
	    {
	        var i:int = _coverage.findGlyph(glyphId);
	        if (i > -1) {
	            return _substitutes[i];
	        }
	        return glyphId;
	    }
	
	    override public function getTypeAsString():String
	    {
	        return "SingleSubstFormat2";
	    }
	}
}