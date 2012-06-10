package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class LtshTable extends Table
	{
		private var de:DirectoryEntry;
	    private var version:uint;
	    private var numGlyphs:uint;
	    private var yPels:Array; // int
	    
	    public function LtshTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry( de.clone() );
	        _type = LTSH;
	        
	        version   = di.readUnsignedShort();
	        numGlyphs = di.readUnsignedShort();
	        yPels     = new Array( numGlyphs );
	        
	        for (var i:uint = 0; i < numGlyphs; i++)
	        {
	            yPels[i] = di.readUnsignedByte();
	        }
	    }
	    
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        
	        sb.append("'LTSH' Table - Linear Threshold Table\n-------------------------------------")
	            .append("\n 'LTSH' Version:       ").append(version)
	            .append("\n Number of Glyphs:     ").append(numGlyphs)
	            .append("\n\n   Glyph #   Threshold\n   -------   ---------\n");

	        for (var i:uint = 0; i < numGlyphs; i++)
	        {
	            sb.append("   ").append(i).append(".        ").append(yPels[i]) .append("\n");
	        }
	        return sb.toString();
	    }		
	}
}