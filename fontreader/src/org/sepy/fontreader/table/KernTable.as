package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class KernTable extends Table
	{
    
	    private var version:uint;
	    private var nTables:uint;
	    private var tables:Array;	// KernSubtable[]
	
	    public function KernTable( de:DirectoryEntry, di:ByteArray):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = kern;
	        
	        version = di.readUnsignedShort();
	        nTables = di.readUnsignedShort();
	        tables = new Array( nTables );
	        
	        for (var i:uint = 0; i < nTables; i++)
	        {
	            tables[i] = KernSubtable.read(di);
	        }
	    }
	
	    public function getSubtableCount():uint
	    {
	        return nTables;
	    }
	    
	    public function getSubtable( i:int ):KernSubtable
	    {
	        return tables[i];
	    }
	}
}