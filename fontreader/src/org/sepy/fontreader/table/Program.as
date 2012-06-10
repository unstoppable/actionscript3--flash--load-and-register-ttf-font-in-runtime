package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class Program extends Table
	{
	    private var instructions:Array;		// short[]
	
	    public function getInstructions():Array
	    {
	        return instructions;
	    }
	
	    internal function readInstructions( di:ByteArray, count:int ):void
	    {
	        instructions = new Array( count );
	        
	        for (var i:uint = 0; i < count; i++)
	        {
	            instructions[i] = di.readUnsignedByte();
	        }
	    }
	}
}