package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class VdmxTable extends Table
	{
	    private var _version:uint;
	    private var _numRecs:uint;
	    private var _numRatios:uint;
	    private var _ratRange:Array;		// Ratio[]
	    private var _offset:Array;			// uint
	    private var _groups:Array;			// Group[]
	    
	    public function VdmxTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = VDMX;
	        
	        var i:uint;
	        
	        _version = di.readUnsignedShort();
	        _numRecs = di.readUnsignedShort();
	        _numRatios = di.readUnsignedShort();
	        _ratRange = new Array( _numRatios );
	        
	        for (i = 0; i < _numRatios; ++i)
	        {
	            _ratRange[i] = new Ratio(di);
	        }
	        
	        _offset = new Array( _numRatios );
	        
	        for (i = 0; i < _numRatios; ++i)
	        {
	            _offset[i] = di.readUnsignedShort();
	        }
	        
	        _groups = new Array( _numRecs );
	        
	        for (i = 0; i < _numRecs; ++i)
	        {
	            _groups[i] = new Group(di);
	        }
	    }

	    
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        
	        sb.append("'VDMX' Table - Precomputed Vertical Device Metrics\n")
	            .append("--------------------------------------------------\n")
	            .append("  Version:                 ").append(_version).append("\n")
	            .append("  Number of Hgt Records:   ").append(_numRecs).append("\n")
	            .append("  Number of Ratio Records: ").append(_numRatios).append("\n");
	        
	        for (var i:uint = 0; i < _numRatios; ++i)
	        {
	            sb.append("\n    Ratio Record #").append(i + 1).append("\n")
	                .append("\tCharSetId     ").append(_ratRange[i].getBCharSet()).append("\n")
	                .append("\txRatio        ").append(_ratRange[i].getXRatio()).append("\n")
	                .append("\tyStartRatio   ").append(_ratRange[i].getYStartRatio()).append("\n")
	                .append("\tyEndRatio     ").append(_ratRange[i].getYEndRatio()).append("\n")
	                .append("\tRecord Offset ").append(_offset[i]).append("\n");
	        }
	        sb.append("\n   VDMX Height Record Groups\n").append("   -------------------------\n");
	        
	        for (i = 0; i < _numRecs; ++i)
	        {
	            var group:Group = Group(_groups[i]);
	            
	            sb.append("   ").append(i + 1)
	                .append(".   Number of Hgt Records  ").append(group.getRecs()).append("\n")
	                .append("        Starting Y Pel Height  ").append(group.getStartSZ()).append("\n")
	                .append("        Ending Y Pel Height    ").append(group.getEndSZ()).append("\n");
	            for (var j:uint = 0; j < group.getRecs(); ++j)
	            {
	                sb.append("\n            ").append(j + 1)
	                    .append(". Pel Height= ").append(group.getEntry()[j].getYPelHeight()).append("\n")
	                    .append("               yMax=       ").append(group.getEntry()[j].getYMax()).append("\n")
	                    .append("               yMin=       ").append(group.getEntry()[j].getYMin()).append("\n");
	            }
	        }
	        return sb.toString();
	    }
	}
}
	import flash.utils.ByteArray;
	



class Group
{
    private var _recs:uint;
    private var _startsz:uint;
    private var _endsz:uint;
    private var _entry:Array;		// VTableRecord[]
    
    function Group( di:ByteArray ):void
    {
        _recs    = di.readUnsignedShort();
        _startsz = di.readUnsignedByte();
        _endsz   = di.readUnsignedByte();
        
        _entry = new Array( _recs );
        
        for (var i:uint = 0; i < _recs; ++i)
        {
            _entry[i] = new VTableRecord(di);
        }
    }

    public function getRecs():uint
    {
        return _recs;
    }
    
    public function getStartSZ():uint
    {
        return _startsz;
    }
    
    public function getEndSZ():uint
    {
        return _endsz;
    }
    
    public function getEntry():Array
    {
        return _entry;	// VTableRecord[] 
    }
}



class VTableRecord
{
    private var _yPelHeight:uint;
    private var _yMax:int;
    private var _yMin:int;
    
    function VTableRecord( di:ByteArray):void
    {
        _yPelHeight = di.readUnsignedShort();
        _yMax = di.readShort();
        _yMin = di.readShort();
    }

    public function getYPelHeight():uint
    {
        return _yPelHeight;
    }
    
    public function getYMax():int
    {
        return _yMax;
    }
    
    public function getYMin():int
    {
        return _yMin;
    }
}


class Ratio 
{
    private var _bCharSet:int;
    private var _xRatio:int;
    private var _yStartRatio:int;
    private var _yEndRatio:int;
    
    function Ratio( di:ByteArray):void
    {
        _bCharSet    = di.readByte();
        _xRatio      = di.readByte();
        _yStartRatio = di.readByte();
        _yEndRatio   = di.readByte();
    }

    public function getBCharSet():int
    {
        return _bCharSet;
    }
    
    public function getXRatio():int
    {
        return _xRatio;
    }
    
    public function getYStartRatio():int
    {
        return _yStartRatio;
    }
    
    public function getYEndRatio():int
    {
        return _yEndRatio;
    }
}