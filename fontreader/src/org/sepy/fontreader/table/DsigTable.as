package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class DsigTable extends Table
	{
	    private var version:int;
	    private var numSigs:uint;
	    private var flag:uint;
	    private var dsigEntry:Array;	// DsigEntry
	    private var sigBlocks:Array;	// SigBlock
	
	    /** 
	    * Creates new DsigTable 
	    */
	    public function DsigTable(de:DirectoryEntry, di:ByteArray):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = DSIG;
	        
	        version = di.readInt();
	        numSigs = di.readUnsignedShort();
	        flag = di.readUnsignedShort();
	        dsigEntry = new Array(numSigs);
	        sigBlocks = new Array(numSigs);
	        
	        var i:uint;
	        for (i = 0; i < numSigs; i++) 
	        {
	            dsigEntry[i] = new DsigEntry(di);
	        }
	        
	        for (i = 0; i < numSigs; i++)
	        {
	            sigBlocks[i] = new SignatureBlock(di);
	        }
	    }

	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer().append("DSIG\n");
	        for (var i:uint = 0; i < numSigs; i++) 
	        {
	            sb.append( SignatureBlock(sigBlocks[i]).toString());
	        }
	        return sb.toString();
	    }
	}
}