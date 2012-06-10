
package org.sepy.fontreader.table
{
	
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class BaseTable extends Table 
	{
	    private var _version:int;
	    private var _horizAxisOffset:uint;
	    private var _vertAxisOffset:uint;
	    private var _horizAxis:Axis;
	    private var _vertAxis:Axis;
	    private var _buf:ByteArray;
	
	    /** 
	    * Creates a new instance of BaseTable 
	    * 
	    */
	    function BaseTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = BASE;
	
	        // Load entire table into a buffer, and create another input stream
			_buf = new ByteArray();
	        di.readBytes( _buf, 0, _de.length );
	        var di2:ByteArray = getDataInputForOffset(0);
	
	        _version         = di2.readInt();
	        _horizAxisOffset = di2.readUnsignedShort();
	        _vertAxisOffset  = di2.readUnsignedShort();
	        
	        if (_horizAxisOffset != 0)
	        {
	            _horizAxis = new Axis(_horizAxisOffset, this);
	        }
	        
	        if (_vertAxisOffset != 0)
	        {
	            _vertAxis = new Axis(_vertAxisOffset, this);
	        }
	        
	        // Let go of the buffer
	        _buf = null;
	    }
	    
	    
	    public function getDataInputForOffset(offset:int):ByteArray 
	    {
	    	var position:uint = _buf.position;
	    	var _bytes:ByteArray = new ByteArray();
	    	_buf.readBytes(_bytes, offset);
	    	_buf.position = position;
	    	return _bytes;
	    }
	    
	    public static function tagAsString(tag:int):String
	    {
	        var c:String = "";
	        c += String.fromCharCode((tag >> 24) & 0xff);
	        c += String.fromCharCode((tag >> 16) & 0xff);
	        c += String.fromCharCode((tag >> 8) & 0xff);
	        c += String.fromCharCode(tag & 0xff);
	        return c;
	    }
	    
	    public function toString():String
	    {
	        var sb:String = "; 'BASE' Table - Baseline\n;-------------------------------------\n\n" + 
	            "BASEHeader BASEHeaderT" + (0).toExponential(16) + 
	            "\n" + _version.toString(16) + 
	            "\nAxisT" + _horizAxisOffset.toString(16) + 
	            "\nAxisT" + _vertAxisOffset.toString(16);
	            
	        if (_horizAxis != null) 
	        {
	            sb + "\n" + _horizAxis.toString();
	        }
	        
	        if (_vertAxis != null) 
	        {
	            sb += "\n" + _vertAxis.toString();
	        }
	        return sb;
	    }

	}

}


import flash.utils.ByteArray;
import org.sepy.fontreader.utils.StringBuffer;
import org.sepy.fontreader.table.BaseTable;
	

class BaseCoord 
{
    virtual public function getBaseCoordFormat():int { return 0 };
	virtual public function getCoordinate():int { return 0 };
}


class BaseCoordFormat1 extends BaseCoord 
{

    private var _coordinate:int;
    
    public function BaseCoordFormat1(di:ByteArray):void
    {
        _coordinate = di.readShort();
    }

    override public function getBaseCoordFormat():int 
    {
        return 1;
    }
    
    override public function getCoordinate():int
	{
        return _coordinate;
    }
}


class BaseCoordFormat2 extends BaseCoord 
{

    private var _coordinate:int;
    private var _referenceGlyph:int;
    private var _baseCoordPoint:int;
    
    public function BaseCoordFormat2(di:ByteArray):void
    {
        _coordinate     = di.readShort();
        _referenceGlyph = di.readUnsignedShort();
        _baseCoordPoint = di.readUnsignedShort();
    }

    override public function getBaseCoordFormat():int 
    {
        return 2;
    }
    
    override public function getCoordinate():int
    {
        return _coordinate;
    }
    
}


class BaseCoordFormat3 extends BaseCoord 
{

    private var _coordinate:int;
    private var _deviceTableOffset:int;
    
    public function BaseCoordFormat3(di:ByteArray):void
    {
        _coordinate        = di.readShort();
        _deviceTableOffset = di.readUnsignedShort();
    }

    override public function getBaseCoordFormat():int
    {
        return 2;
    }
    
    override public function getCoordinate():int
    {
        return _coordinate;
    }
    
}


class FeatMinMaxRecord 
{
    
    private var _tag:int;
    private var _minCoordOffset:int;
    private var _maxCoordOffset:int;
    
    public function FeatMinMaxRecord(di:ByteArray):void
    {
        _tag = di.readInt();
        _minCoordOffset = di.readUnsignedShort();
        _maxCoordOffset = di.readUnsignedShort();
    }
}

class MinMax
{
    
    private var _minCoordOffset:int;
    private var _maxCoordOffset:int;
    private var _featMinMaxCount:int;
    private var _featMinMaxRecord:Array;
    
    function MinMax(minMaxOffset:int, bt:BaseTable):void
    {
        var di:ByteArray = bt.getDataInputForOffset(minMaxOffset);
        _minCoordOffset  = di.readUnsignedShort();
        _maxCoordOffset  = di.readUnsignedShort();
        _featMinMaxCount = di.readUnsignedShort();
        _featMinMaxRecord = new Array(_featMinMaxCount);
        for (var i:int = 0; i < _featMinMaxCount; ++i) 
        {
            _featMinMaxRecord[i] = new FeatMinMaxRecord(di);
        }
    }
}

class BaseValues extends Object
{
    
    private var _defaultIndex:int;
    private var _baseCoordCount:int;
    private var _baseCoordOffset:Array;
    private var _baseCoords:Array;
    
    function BaseValues(baseValuesOffset:int, bt:BaseTable):void
    {
        var di:ByteArray = bt.getDataInputForOffset(baseValuesOffset);
        _defaultIndex = di.readUnsignedShort();
        _baseCoordCount = di.readUnsignedShort();
        _baseCoordOffset = new Array(_baseCoordCount);
        for (var i:int = 0; i < _baseCoordCount; ++i) {
            _baseCoordOffset[i] = di.readUnsignedShort();
        }
        _baseCoords = new Array(_baseCoordCount);
        
        for (i = 0; i < _baseCoordCount; ++i) {
            var format:int = di.readUnsignedShort();
            switch (format) {
                case 1:
                    _baseCoords[i] = new BaseCoordFormat1(di);
                    break;
                case 2:
                    _baseCoords[i] = new BaseCoordFormat2(di);
                    break;
                case 3:
                    _baseCoords[i] = new BaseCoordFormat3(di);
                    break;
            }
        }
    }
}

class BaseLangSysRecord 
{
    
    private var _baseLangSysTag:int;
    private var _minMaxOffset:int;
    
    public function BaseLangSysRecord(di:ByteArray):void
    {
        _baseLangSysTag = di.readInt();
        _minMaxOffset = di.readUnsignedShort();
    }

    public function getBaseLangSysTag():int
    {
        return _baseLangSysTag;
    }
    
    public function getMinMaxOffset():int
    {
        return _minMaxOffset;
    }
}


class BaseScriptRecord 
{
    
    private var _baseScriptTag:int;
    private var _baseScriptOffset:int;

    public function BaseScriptRecord(di:ByteArray):void
    {
        _baseScriptTag = di.readInt();
        _baseScriptOffset = di.readUnsignedShort();
    }

    public function getBaseScriptTag():int
    {
        return _baseScriptTag;
    }
    
    public function getBaseScriptOffset():int
    {
        return _baseScriptOffset;
    }
}



class BaseScriptList 
{
    
    private var _thisOffset:int;
    private var _baseScriptCount:int;
    private var _baseScriptRecord:Array;
    private var _baseScripts:Array;
 
    public function BaseScriptList(baseScriptListOffset:int, bt:BaseTable):void
    {
        _thisOffset = baseScriptListOffset;
        var di:ByteArray = bt.getDataInputForOffset(baseScriptListOffset);
        _baseScriptCount = di.readUnsignedShort();
        _baseScriptRecord = new Array(_baseScriptCount);
        for (var i:int = 0; i < _baseScriptCount; ++i) 
        {
            _baseScriptRecord[i] = new BaseScriptRecord(di);
        }
        _baseScripts = new Array(_baseScriptCount);
        for (i = 0; i < _baseScriptCount; ++i) 
        {
            _baseScripts[i] = new BaseScript(baseScriptListOffset + _baseScriptRecord[i].getBaseScriptOffset(), bt);
        }
    }

    public function toString():String 
    {
        var sb:String =  "\nBaseScriptList BaseScriptListT" +  _thisOffset.toString(16) + "\n" + _baseScriptCount.toString(16);
        for (var i:int = 0; i < _baseScriptCount; ++i) 
        {
            sb += "\n                          ; BaseScriptRecord[" + i;
            sb += "]\n'" + BaseTable.tagAsString(_baseScriptRecord[i].getBaseScriptTag()) + "'";
            sb += "\nBaseScriptT" + (_thisOffset + _baseScriptRecord[i].getBaseScriptOffset()).toString(16);
        }
        for (i = 0; i < _baseScriptCount; ++i) 
        {
            sb += "\n" + _baseScripts[i].toString();
        }
        
        return sb;
    }
 }
 
 
class BaseScript 
{
	        
    private var _thisOffset:int;
    private var _baseValuesOffset:int;
    private var _defaultMinMaxOffset:int;
    private var _baseLangSysCount:int;
    private var _baseLangSysRecord:Array;
    private var _baseValues:BaseValues;
    private var _minMax:Array;
    
    public function BaseScript(baseScriptOffset:int, bt:BaseTable):void
    {
        _thisOffset = baseScriptOffset;
        var di:ByteArray     = bt.getDataInputForOffset(baseScriptOffset);
        _baseValuesOffset    = di.readUnsignedShort();
        _defaultMinMaxOffset = di.readUnsignedShort();
        _baseLangSysCount    = di.readUnsignedShort();
        _baseLangSysRecord = new Array(_baseLangSysCount);
        _minMax = new Array();
        
        for (var i:int = 0; i < _baseLangSysCount; ++i) 
        {
            _baseLangSysRecord[i] = new BaseLangSysRecord(di);
        }
        
        if (_baseValuesOffset > 0) 
        {
            _baseValues = new BaseValues(baseScriptOffset + _baseValuesOffset, bt);
        }
        for (i = 0; i < _baseLangSysCount; ++i) 
        {
            _minMax[i] = new MinMax(baseScriptOffset + _baseLangSysRecord[i].getMinMaxOffset(), bt);
        }
    }

    public function toString():String
    {
        var sb:StringBuffer = new StringBuffer();
        sb.append("\nBaseScript BaseScriptT").append(_thisOffset.toString(16))
        sb.append("\nBaseValuesT").append((_thisOffset + _baseValuesOffset).toString(16))
        sb.append("\nMinMaxT").append( (_thisOffset + _defaultMinMaxOffset).toString(16))
        sb.append("\n");
        sb.append((_baseLangSysCount).toString(16));

        if (_baseValues != null) 
        {
            sb.append("\n").append(String(_baseValues));
        }
        return sb.toString();
    }
}


class BaseTagList 
{
    
    private var _thisOffset:int;
    private var _baseTagCount:int;
    private var _baselineTag:Array;
    
    public function BaseTagList(baseTagListOffset:int, bt:BaseTable):void
    {
        _thisOffset = baseTagListOffset;
        var di:ByteArray = bt.getDataInputForOffset(baseTagListOffset);
        _baseTagCount = di.readUnsignedShort();
        _baselineTag = new Array(_baseTagCount);
        for (var i:int = 0; i < _baseTagCount; ++i) 
        {
            _baselineTag[i] = di.readInt();
        }
    }

    public function toString():String 
    {
        var sb:StringBuffer = new StringBuffer()
            .append("\nBaseTagList BaseTagListT").append(_thisOffset.toString(16))
            .append("\n").append(_baseTagCount.toString(16));
        
        for (var i:int = 0; i < _baseTagCount; ++i) 
        {
            sb.append("\n'").append(BaseTable.tagAsString(_baselineTag[i])).append("'");
        }
        return sb.toString();
    }
}



class Axis 
{
    
    private var _thisOffset:int;
    private var _baseTagListOffset:int;
    private var _baseScriptListOffset:int;
    private var _baseTagList:BaseTagList ;
    private var _baseScriptList:BaseScriptList;

    public function Axis(axisOffset:int, bt:BaseTable):void
    {
        _thisOffset           = axisOffset;
        var di:ByteArray      = bt.getDataInputForOffset(axisOffset);
        _baseTagListOffset    = di.readUnsignedShort();
        _baseScriptListOffset = di.readUnsignedShort();
        
        if (_baseTagListOffset != 0) 
        {
            _baseTagList = new BaseTagList(axisOffset + _baseTagListOffset, bt);
        }
        if (_baseScriptListOffset != 0) 
        {
            _baseScriptList = new BaseScriptList( axisOffset + _baseScriptListOffset, bt);
        }
    }

    public function toString():String {
        return new StringBuffer()
            .append("\nAxis AxisT").append((_thisOffset).toString(16))
            .append("\nBaseTagListT").append((_thisOffset + _baseTagListOffset)..toString(16))
            .append("\nBaseScriptListT").append((_thisOffset + _baseScriptListOffset).toString(16))
            .append("\n").append(_baseTagList)
            .append("\n").append(_baseScriptList)
            .toString();
    }
}