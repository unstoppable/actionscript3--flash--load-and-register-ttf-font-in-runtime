package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.Fixed;
	
	public class TableDirectory
	{

	    private var _version:int  = 0;
	    private var _numTables:int = 0;
	    private var _searchRange:int = 0;
	    private var _entrySelector:int = 0;
	    private var _rangeShift:int = 0;
	    private var _entries:Array;	// DirectoryEntry
		
		public function TableDirectory(di:ByteArray):void
		{
	        _version       = di.readInt();
	        _numTables     = di.readShort();
	        _searchRange   = di.readShort();
	        _entrySelector = di.readShort();
	        _rangeShift    = di.readShort();
	        _entries = new Array(_numTables);
	        
	        for(var i:int = 0; i < _numTables; i++) 
	        {
	            _entries[i] = new DirectoryEntry(di);
	        }			
		}
		

    	public function getEntry(index:uint):DirectoryEntry
    	{
        	return _entries[index];
    	}
    	
    	
	    public function getEntryByTag(tag:int):DirectoryEntry
	    {
	        for (var i:int = 0; i < _numTables; i++) 
	        {
	            if ( DirectoryEntry(_entries[i]).tag == tag) 
	            {
	                return _entries[i];
	            }
	        }
	        return null;
	    }
	    
		
	    public function getEntrySelector():int
	    {
	        return _entrySelector;
	    }
	
	    public function getNumTables():int
	    {
	        return _numTables;
	    }
	
	    public function getRangeShift():int
	    {
	        return _rangeShift;
	    }
	
	    public function getSearchRange():int
	    {
	        return _searchRange;
	    }
	
	    public function getVersion():int
	    {
	        return _version;
	    }		
		
	    public function toString():String
	     {
	        var sb:String = "Offset Table\n------ -----";
	        sb += "\n  sfnt version:     " + Fixed.floatValue(_version);
	        sb += "\n  numTables =       " + _numTables;
	        sb += "\n  searchRange =     " + _searchRange;
	        sb += "\n  entrySelector =   " + _entrySelector;
	        sb += "\n  rangeShift =      " + _rangeShift;
	        sb += "\n\n";
	        
	        for (var i:int = 0; i < _numTables; i++) 
	        {
	            sb += i + ". " + _entries[i].toString() + "\n";
	        }
	        return sb;
	    }		
	
	}
}