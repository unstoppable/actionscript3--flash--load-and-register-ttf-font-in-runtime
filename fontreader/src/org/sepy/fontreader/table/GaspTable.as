package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class GaspTable extends Table
	{
	    private var version:uint;
	    private var numRanges:uint;
	    private var gaspRange:Array;	// GaspRange[]
	    
	    public function GaspTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry( de.clone() );
	        _type = gasp;
	        
	        version   = di.readUnsignedShort();
	        numRanges = di.readUnsignedShort();
	        gaspRange = new Array( numRanges );
	        
	        for (var i:uint = 0; i < numRanges; i++)
	        {
	            gaspRange[i] = new GaspRange(di);
	        }
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        sb.append("'gasp' Table - Grid-fitting And Scan-conversion Procedure\n---------------------------------------------------------");
	        sb.append("\n  'gasp' version:      ").append(version);
	        sb.append("\n  numRanges:           ").append(numRanges);
	        
	        for (var i:uint = 0; i < numRanges; i++)
	        {
	            sb.append("\n\n  gasp Range ").append(i).append("\n");
	            sb.append( GaspRange(gaspRange[i]).toString() );
	        }
	        return sb.toString();
	    }
	
	}
}