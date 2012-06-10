package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.Disassembler;
	
	public class PrepTable extends Program
	{
	    /**
	     * 
	     * @param de
	     * @param di
	     * @throws IOError
	     */
	    public function PrepTable( de:DirectoryEntry, di:ByteArray):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = prep;
	        readInstructions( di, de.length );
	    }
	
	    public function toString():String
	    {
	        return Disassembler.disassemble(getInstructions(), 0);
	    }
	    
	}
}