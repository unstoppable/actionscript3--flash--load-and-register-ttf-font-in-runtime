package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.Disassembler;
	
	public class FpgmTable extends Program
	{
	    public function FpgmTable( de:DirectoryEntry, di:ByteArray ):void
	    {
        	_de = DirectoryEntry( de.clone() );
        	_type = fpgm;
	        readInstructions( di, de.length );
	    }

		public function toString():String
		{
			return Disassembler.disassemble( getInstructions(), 0);
		}
	}
}