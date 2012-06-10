package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class HdmxTable extends Table
	{
	    private var _version:uint;
	    private var _numRecords:int;
	    private var _sizeDeviceRecords:int;
	    private var _records:Array;		// DeviceRecord[]
	
	    public function HdmxTable( de:DirectoryEntry, di:ByteArray, maxp:MaxpTable ):void
	    {
	        _de   = DirectoryEntry( de.clone() );
	        _type = hdmx;
	        
	        _version           = di.readUnsignedShort();
	        _numRecords        = di.readShort();
	        _sizeDeviceRecords = di.readInt();
	        _records = new Array( _numRecords );
	        
	        for (var i:int = 0; i < _numRecords; ++i)
	        {
	            _records[i] = new DeviceRecord(maxp.getNumGlyphs(), di);
	        }
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        sb.append("'hdmx' Table - Horizontal Device Metrics\n----------------------------------------\n");
	        sb.append("Size = ").append(_de.length).append(" bytes\n")
	            .append("\t'hdmx' version:         ").append(_version).append("\n")
	            .append("\t# device records:       ").append(_numRecords).append("\n")
	            .append("\tRecord length:          ").append(_sizeDeviceRecords).append("\n");

	        for (var i:int = 0; i < _numRecords; ++i)
	        {
	            sb.append("\tDevRec ").append(i)
	                .append(": ppem = ").append(_records[i].getPixelSize())
	                .append(", maxWid = ").append(_records[i].getMaxWidth())
	                .append("\n");
	            for (var j:int = 0; j < _records[i].getWidths().length; ++j)
	            {
	                sb.append("    ").append(j).append(".   ").append(_records[i].getWidths()[j]).append("\n");
	            }
	            sb.append("\n\n");
	        }
	        return sb.toString();
	    }
	}
}
	import flash.utils.ByteArray;
	


class DeviceRecord
{
    private var _pixelSize:int;
    private var _maxWidth:int;
    private var _widths:Array;		// short[]

    /**
     * 
     * @param numGlyphs
     * @param di
     * @throws IOError
     */
    function DeviceRecord( numGlyphs:int, di:ByteArray):void
    {
        _pixelSize = di.readByte();
        _maxWidth  = di.readByte();
        _widths    = new Array( numGlyphs );
        
        for (var i:int = 0; i < numGlyphs; ++i)
        {
            _widths[i] = di.readByte();
        }
    }

    public function getPixelSize():int
    {
        return _pixelSize;
    }
    
    public function getMaxWidth():int
    {
        return _maxWidth;
    }
    
    public function getWidths():Array
    {
        return _widths;
    }
}