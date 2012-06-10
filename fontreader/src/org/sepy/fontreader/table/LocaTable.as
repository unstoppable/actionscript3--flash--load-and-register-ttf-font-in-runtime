package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class LocaTable extends Table
	{
	
	    private var _offsets:Array;
	    private var _factor:int = 0;
	
	    public function LocaTable( de:DirectoryEntry, di:ByteArray, head:HeadTable, maxp:MaxpTable ):void
	    {
	        _de      = DirectoryEntry(de.clone());
	        _type    = loca;
	        _offsets = new Array(maxp.getNumGlyphs() + 1);
	        var shortEntries:Boolean = head.getIndexToLocFormat() == 0;
	        var i:uint;
	        
	        if (shortEntries) 
	        {
	            _factor = 2;
	            for (i = 0; i <= maxp.getNumGlyphs(); i++) 
	            {
	                _offsets[i] = di.readUnsignedShort();
	            }
	        } else 
	        {
	            _factor = 1;
	            for (i = 0; i <= maxp.getNumGlyphs(); i++) 
	            {
	                _offsets[i] = di.readInt();
	            }
	        }
	    }
	
	
	    public function getOffset(i:int):int 
	    {
	        if (_offsets == null) {
	            return 0;
	        }
	        return _offsets[i] * _factor;
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        sb.append("'loca' Table - Index To Location Table\n--------------------------------------\n")
	            .append("Size = ").append( _de.length ).append(" bytes, ")
	            .append(_offsets.length).append(" entries\n");
	        for (var i:int = 0; i < _offsets.length; i++) 
	        {
	            sb.append("        Idx ").append(i).append(" -> glyfOff 0x").append(getOffset(i)).append("\n");
	        }
	        return sb.toString();
	    }
	}
}