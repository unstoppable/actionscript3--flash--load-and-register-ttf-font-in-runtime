package org.sepy.fontreader.table
{
	import org.sepy.fontreader.utils.StringBuffer;
	import flash.utils.ByteArray;
	import flash.errors.IOError;
	
	public class CmapTable extends Table
	{
	    private var _version:uint;
	    private var _numTables:uint;
	    private var _entries:Array;		// CmapIndexEntry[]
	
	    public function CmapTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = cmap;
	        
	        _version   = di.readUnsignedShort();
	        _numTables = di.readUnsignedShort();
	        
	        var i:uint;
	        var bytesRead:int = 4;
	        _entries = new Array( _numTables );
	
	        for (i = 0; i < _numTables; i++)
	        {
	            _entries[i] = new CmapIndexEntry(di);
	            bytesRead += 8;
	        }
	
	        // Sort into their order of 'offset' field
	        _entries.sortOn("offset", Array.NUMERIC);
	
	        var lastOffset:int = 0;
	        var lastFormat:CmapFormat = null;
	        
	        for (i = 0; i < _numTables; i++)
	        {
	            if (CmapIndexEntry(_entries[i]).offset == lastOffset)
	            {
	                // This is a multiple entry
	                CmapIndexEntry(_entries[i]).format = lastFormat;
	                continue;
	                
	            } else if (CmapIndexEntry(_entries[i]).offset > bytesRead)
	            {
	                di.position += (CmapIndexEntry(_entries[i]).offset - bytesRead);
	            } else if (CmapIndexEntry(_entries[i]).offset != bytesRead)
	            {
	                // Something is missing...
	                throw new IOError('IOException');
	            }
	            
	            var formatType:uint = di.readUnsignedShort();
	            lastFormat = CmapFormat.create(formatType, di);
	            lastOffset = CmapIndexEntry(_entries[i]).offset;
	            CmapIndexEntry(_entries[i]).format = lastFormat;
	            bytesRead += lastFormat.length;
	        }
	    }
	
	    public function get version():uint
	    {
	        return _version;
	    }
	    
	    public function get tablesCount():uint
	    {
	        return _numTables;
	    }
	    
	    public function getCmapIndexEntry(i:uint):CmapIndexEntry
	    {
	        return _entries[i];
	    }
	    
	    /**
	    * Find the requested format
	    * 
	    */
	    public function getCmapFormat( platformId:int, encodingId:int ):CmapFormat
	    {
	        for (var i:uint = 0; i < _numTables; i++)
	        {
	            if (CmapIndexEntry(_entries[i]).platformId == platformId && CmapIndexEntry(_entries[i]).encodingId == encodingId)
	            {
	                return CmapIndexEntry(_entries[i]).format;
	            }
	        }
	        return null;
	    }
	    
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer().append("cmap\n");
	
	        for (var i:uint = 0; i < _numTables; i++)
	        {
	            sb.append("\t").append(CmapIndexEntry(_entries[i]).toString()).append("\n");
	        }
	        return sb.toString();
	    }		
	}
}