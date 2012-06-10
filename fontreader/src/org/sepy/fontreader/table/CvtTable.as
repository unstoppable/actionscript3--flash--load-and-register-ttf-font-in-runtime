package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class CvtTable extends Table
	{
	    private var _values:Array;	// short[]
	
	    public function CvtTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = cvt;
	        
	        var len:int = de.length / 2;
	        _values = new Array( len );
	        for (var i:uint = 0; i < len; i++)
	        {
	            _values[i] = di.readShort();
	        }
	    }
	
	    public function get values():Array
	    {
	        return _values.slice();
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        sb.append("'cvt ' Table - Control Value Table\n----------------------------------\n");
	        sb.append("Size = ").append(0).append(" bytes, ").append(values.length).append(" entries\n");
	        sb.append("        Values\n        ------\n");
	        for (var i:uint = 0; i < values.length; i++) {
	            sb.append("        ").append(i).append(": ").append(values[i]).append("\n");
	        }
	        return sb.toString();
	    }	
	}
}