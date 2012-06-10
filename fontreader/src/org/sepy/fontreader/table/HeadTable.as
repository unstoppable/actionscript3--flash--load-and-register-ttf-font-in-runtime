package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import org.sepy.fontreader.utils.StringBuffer;
	import org.sepy.fontreader.utils.Fixed;
	
	public class HeadTable extends Table
	{
	    private var _versionNumber:int;
	    private var _fontRevision:int;
	    private var _checkSumAdjustment:int;
	    private var _magicNumber:int;
	    private var _flags:int;
	    private var _unitsPerEm:int;
	    private var _created:Number;
	    private var _modified:Number;
	    private var _xMin:int;
	    private var _yMin:int;
	    private var _xMax:int;
	    private var _yMax:int;
	    private var _macStyle:int;
	    private var _lowestRecPPEM:int;
	    private var _fontDirectionHint:int;
	    private var _indexToLocFormat:int;
	    private var _glyphDataFormat:int;
	    
	    public function HeadTable(de:DirectoryEntry, di:ByteArray):void
	    {
	    	_de   = DirectoryEntry(de.clone());
			_type = head;	    	
	        _versionNumber = di.readInt();
	        _fontRevision  = di.readInt();
	        _checkSumAdjustment = di.readInt();
	        _magicNumber        = di.readInt();
	        _flags      = di.readShort();
	        _unitsPerEm = di.readShort();
	        _created    = di.readDouble();
	        _modified   = di.readDouble();
	        _xMin = di.readShort();
	        _yMin = di.readShort();
	        _xMax = di.readShort();
	        _yMax = di.readShort();
	        _macStyle      = di.readShort();
	        _lowestRecPPEM = di.readShort();
	        _fontDirectionHint = di.readShort();
	        _indexToLocFormat  = di.readShort();
	        _glyphDataFormat   = di.readShort();	    	
	    }
		
	    public function getIndexToLocFormat():int
	    {
	        return _indexToLocFormat;
	    }		

		public function getCheckSumAdjustment():int
		{
	        return _checkSumAdjustment;
	    }
	
	    public function getCreated():Number
	    {
	        return _created;
	    }
	
	    public function getFlags():int
	    {
	        return _flags;
	    }
	
	    public function getFontDirectionHint():int
	    {
	        return _fontDirectionHint;
	    }
	
	    public function getFontRevision():int
	    {
	        return _fontRevision;
	    }
	
	    public function getGlyphDataFormat():int
	    {
	        return _glyphDataFormat;
	    }
	
	    public function getLowestRecPPEM():int
	    {
	        return _lowestRecPPEM;
	    }
	
	    public function getMacStyle():int
	    {
	        return _macStyle;
	    }
	
	    public function getModified():Number
	    {
	        return _modified;
	    }
	
	
	    public function getUnitsPerEm():int
	    {
	        return _unitsPerEm;
	    }
	
	    public function getVersionNumber():int
	    {
	        return _versionNumber;
	    }
	
	    public function getXMax():int
	    {
	        return _xMax;
	    }
	
	    public function getXMin():int
	    {
	        return _xMin;
	    }
	
	    public function getYMax():int
	    {
	        return _yMax;
	    }
	
	    public function getYMin():int
	    {
	        return _yMin;
	    }
	    

	    public function toString():String
	    {
	        return new StringBuffer()
	            .append("'head' Table - Font Header\n--------------------------")
	            .append("\n  'head' version:      ").append(Fixed.floatValue(_versionNumber))
	            .append("\n  fontRevision:        ").append(Fixed.roundedFloatValue(_fontRevision, 8))
	            .append("\n  checkSumAdjustment:  0x").append((_checkSumAdjustment).toString(16))
	            .append("\n  magicNumber:         0x").append((_magicNumber).toString(16))
	            .append("\n  flags:               0x").append((_flags).toString(16))
	            .append("\n  unitsPerEm:          ").append(_unitsPerEm)
	            .append("\n  created:             ").append(_created)
	            .append("\n  modified:            ").append(_modified)
	            .append("\n  xMin:                ").append(_xMin)
	            .append("\n  yMin:                ").append(_yMin)
	            .append("\n  xMax:                ").append(_xMax)
	            .append("\n  yMax:                ").append(_yMax)
	            .append("\n  macStyle bits:       ").append((_macStyle).toString(16))
	            .append("\n  lowestRecPPEM:       ").append(_lowestRecPPEM)
	            .append("\n  fontDirectionHint:   ").append(_fontDirectionHint)
	            .append("\n  indexToLocFormat:    ").append(_indexToLocFormat)
	            .append("\n  glyphDataFormat:     ").append(_glyphDataFormat)
	            .toString();
	    }	    
		
	}
}