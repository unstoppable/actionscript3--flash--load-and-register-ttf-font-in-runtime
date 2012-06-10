package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class NameTable extends Table
	{
	    private var _formatSelector:int;
	    private var _numberOfNameRecords:int;
	    private var _stringStorageOffset:int;
	    private var _records:Array;					// NameRecord[]
	
	    /**
	     * 
	     * @param de
	     * @param di
	     * @throws IOError
	     */
	    public function NameTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = name;
	        
	        _formatSelector      = di.readShort();
	        _numberOfNameRecords = di.readShort();
	        _stringStorageOffset = di.readShort();
	        _records = new Array( _numberOfNameRecords );
	        
	        var i:uint;
	        
	        for (i = 0; i < _numberOfNameRecords; i++)
	        {
	            _records[i] = new NameRecord(di);
	        }
	        
	        var buffer:ByteArray = new ByteArray();
	        var ins:ByteArray;
	        di.readBytes(buffer, 0, _de.length - _stringStorageOffset ); 
	        
	        
	        for (i = 0; i < _numberOfNameRecords; i++)
	        {
	        	ins = new ByteArray();
	        	buffer.position = 0;
	        	buffer.readBytes( ins );
	            NameRecord(_records[i]).loadString( ins );
	        }
	    }
	    
	    public function get nameRecordsCount():int
	    {
	    	// getNumberOfNameRecords()
	    	return _numberOfNameRecords;
	    }
	
	    public function getRecord( i:uint ):NameRecord
	    {
	        return _records[i];
	    }
	    
	    public function findRecordById( id:int ):NameRecord
	    {
	        for (var i:int = 0; i < _numberOfNameRecords; i++)
	        {
	            if (NameRecord(_records[i]).getNameId() == id)
	            {
	                return NameRecord(_records[i]);
	            }
	        }
	        return null;	
	    }
	
	    public function getRecordString( nameId:int ):String
	    {
	        for (var i:int = 0; i < _numberOfNameRecords; i++)
	        {
	            if (NameRecord(_records[i]).getNameId() == nameId)
	            {
	                return NameRecord(_records[i]).getRecordString();
	            }
	        }
	        return "";
	    }
	}
}