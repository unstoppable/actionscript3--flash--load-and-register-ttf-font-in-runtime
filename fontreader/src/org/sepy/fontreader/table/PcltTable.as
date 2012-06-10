package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class PcltTable extends Table
	{
	    private var version:int;
	    private var fontNumber:int;
	    private var pitch:uint;
	    private var xHeight:uint;
	    private var style:uint;
	    private var typeFamily:uint;
	    private var capHeight:uint;
	    private var symbolSet:uint;
	    private var typeface:Array = new Array(16); // char[]
	    private var characterComplement:Array = new Array(8);	// short[]
	    private var fileName:Array = new Array(6);	// char[]
	    private var strokeWeight:uint;
	    private var widthType:uint;
	    private var serifStyle:int;
	    private var reserved:int;
	
	    public function PcltTable( de:DirectoryEntry, di:ByteArray):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = PCLT;
	        
	        var i:uint;
	        
	        version    = di.readInt();
	        fontNumber = di.readInt();
	        pitch      = di.readUnsignedShort();
	        xHeight    = di.readUnsignedShort();
	        style      = di.readUnsignedShort();
	        typeFamily = di.readUnsignedShort();
	        capHeight  = di.readUnsignedShort();
	        symbolSet  = di.readUnsignedShort();
	        
	        for (i = 0; i < 16; i++)
	        {
	            typeface[i] = di.readUnsignedByte();
	        }
	        
	        for (i = 0; i < 8; i++)
	        {
	            characterComplement[i] = di.readUnsignedByte();
	        }
	        
	        for (i = 0; i < 6; i++)
	        {
	            fileName[i] = di.readUnsignedByte();
	        }
	        
	        strokeWeight = di.readUnsignedByte();
	        widthType    = di.readUnsignedByte();
	        serifStyle   = di.readByte();
	        reserved     = di.readByte();
	    }

	    
	    public function toString():String
	    {
	        return new StringBuffer()
	            .append("'PCLT' Table - Printer Command Language Table\n---------------------------------------------")
	            .append("\n        version:             0x").append((version).toString(16))
	            .append("\n        fontNumber:          ").append(fontNumber).append(" (0x").append((fontNumber).toString(16))
	            .append(")\n        pitch:               ").append(pitch)
	            .append("\n        xHeight:             ").append(xHeight)
	            .append("\n        style:               0x").append(style)
	            .append("\n        typeFamily:          0x").append(typeFamily >> 12)
	            .append(" ").append(typeFamily & 0xfff)
	            .append("\n        capHeight:           ").append(capHeight)
	            .append("\n        symbolSet:           ").append(symbolSet)
	            .append("\n        typeFace:            ").append(new String(typeface))
	            .append("\n        characterComplement  0x")
	            .append((characterComplement[0]).toString(16))
	            .append("\n        fileName:            ").append(new String(fileName))
	            .append("\n        strokeWeight:        ").append(strokeWeight)
	            .append("\n        widthType:           ").append(widthType)
	            .append("\n        serifStyle:          ").append(serifStyle)
	            .append("\n        reserved:            ").append(reserved)
	            .toString();
	    }

	}
}