package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class Lookup
	{

	    public static var IGNORE_BASE_GLYPHS:int    = 0x0002;
	    public static var IGNORE_BASE_LIGATURES:int = 0x0004;
	    public static var IGNORE_BASE_MARKS:int     = 0x0008;
	    public static var MARK_ATTACHMENT_TYPE:int  = 0xFF00;
	
	    private var _type:uint;
	    private var _flag:uint;
	    private var _subTableCount:uint;
	    private var _subTableOffsets:Array;
	    private var _subTables:Array;
	
	    public function Lookup( factory:ILookupSubtableFactory, dis:ByteArray, offset:uint):void
	    {
			var i:uint;
	        dis.position = offset;
	        _type = dis.readUnsignedShort();
	        _flag = dis.readUnsignedShort();
	        _subTableCount = dis.readUnsignedShort();
	        _subTableOffsets = new Array(_subTableCount);
	        _subTables = new Array(_subTableCount);

	        for (i = 0; i < _subTableCount; i++)
	        {
	            _subTableOffsets[i] = dis.readUnsignedShort();
	        }
	        
	        for (i = 0; i < _subTableCount; i++)
	        {
	            _subTables[i] = factory.read(_type, dis, offset + _subTableOffsets[i]);
	        }
	    }
	
	    public function get type():uint
	    {
	        return _type;
	    }
	
	    public function get subtableCount():uint
	    {
	        return _subTableCount;
	    }
	
	    public function getSubtable(i:uint):ILookupSubtable
	    {
	        return _subTables[i];
	    }
	}
}