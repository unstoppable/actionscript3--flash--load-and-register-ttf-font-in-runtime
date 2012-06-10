package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class Ligature
	{
	    private var _ligGlyph:uint;
	    private var _compCount:uint;
	    private var _components:Array;
	
	    public function Ligature( di:ByteArray):void
	    {
	        _ligGlyph   = di.readUnsignedShort();
	        _compCount  = di.readUnsignedShort();
	        _components = new Array( _compCount - 1 );
	        
	        for (var i:uint = 0; i < _compCount - 1; i++)
	        {
	            _components[i] = di.readUnsignedShort();
	        }
	    }
	    
	    
	    public function get glyphCount():uint
	    {
	        return _compCount;
	    }
	    
	    public function getGlyphId(i:int):int
	    {
	        return (i == 0) ? _ligGlyph : _components[i-1];
	    }		
	}
}