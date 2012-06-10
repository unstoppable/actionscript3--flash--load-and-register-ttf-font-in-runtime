package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	internal class CoverageFormat1 extends Coverage
	{
	    private var _glyphCount:uint;
	    private var _glyphIds:Array;
	
	    public function CoverageFormat1( di:ByteArray ):void
	    {
	        _glyphCount = di.readUnsignedShort();
	        _glyphIds   = new Array( _glyphCount );
	        
	        for (var i:uint = 0; i < _glyphCount; i++)
	        {
	            _glyphIds[i] = di.readUnsignedShort();
	        }
	    }
	

	    override public function get format():int
	    {
	        return 1;
	    }

	
	    override public function findGlyph(glyphId:int):int
	    {
	        for (var i:uint = 0; i < _glyphCount; i++)
	        {
	            if (_glyphIds[i] == glyphId)
	            {
	                return i;
	            }
	        }
	        return -1;
	    }
	}
}