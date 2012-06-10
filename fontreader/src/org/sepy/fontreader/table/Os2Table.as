package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class Os2Table extends Table
	{
	    private var _version:uint;
	    private var _xAvgCharWidth:int;
	    private var _usWeightClass:int;
	    private var _usWidthClass:int;
	    private var _fsType:int;
	    private var _ySubscriptXSize:int;
	    private var _ySubscriptYSize:int;
	    private var _ySubscriptXOffset:int;
	    private var _ySubscriptYOffset:int;
	    private var _ySuperscriptXSize:int;
	    private var _ySuperscriptYSize:int;
	    private var _ySuperscriptXOffset:int;
	    private var _ySuperscriptYOffset:int;
	    private var _yStrikeoutSize:int;
	    private var _yStrikeoutPosition:int;
	    private var _sFamilyClass:int;
	    private var _panose:Panose;
	    private var _ulUnicodeRange1:int;
	    private var _ulUnicodeRange2:int;
	    private var _ulUnicodeRange3:int;
	    private var _ulUnicodeRange4:int;
	    private var _achVendorID:int;
	    private var _fsSelection:int;
	    private var _usFirstCharIndex:uint;
	    private var _usLastCharIndex:uint;
	    private var _sTypoAscender:int;
	    private var _sTypoDescender:int;
	    private var _sTypoLineGap:int;
	    private var _usWinAscent:uint;
	    private var _usWinDescent:uint;
	    private var _ulCodePageRange1:int;
	    private var _ulCodePageRange2:int;
	    private var _sxHeight:int;
	    private var _sCapHeight:int;
	    private var _usDefaultChar:int;
	    private var _usBreakChar:int;
	    private var _usMaxContext:int;
	
	    public function Os2Table( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = OS_2;
	        
	        _version       = di.readUnsignedShort();
	        _xAvgCharWidth = di.readShort();
	        _usWeightClass = di.readUnsignedShort();
	        _usWidthClass  = di.readUnsignedShort();
	        _fsType          = di.readShort();
	        _ySubscriptXSize = di.readShort();
	        _ySubscriptYSize = di.readShort();
	        _ySubscriptXOffset = di.readShort();
	        _ySubscriptYOffset = di.readShort();
	        _ySuperscriptXSize = di.readShort();
	        _ySuperscriptYSize = di.readShort();
	        _ySuperscriptXOffset = di.readShort();
	        _ySuperscriptYOffset = di.readShort();
	        _yStrikeoutSize      = di.readShort();
	        _yStrikeoutPosition  = di.readShort();
	        _sFamilyClass        = di.readShort();
	        
	        var buf:ByteArray = new ByteArray();
	        di.readBytes(buf, 0, 10);
	        
	        _panose = new Panose(buf);
	        
	        _ulUnicodeRange1 = di.readInt();
	        _ulUnicodeRange2 = di.readInt();
	        _ulUnicodeRange3 = di.readInt();
	        _ulUnicodeRange4 = di.readInt();
	        _achVendorID = di.readInt();
	        _fsSelection = di.readShort();
	        _usFirstCharIndex = di.readUnsignedShort();
	        _usLastCharIndex  = di.readUnsignedShort();
	        _sTypoAscender    = di.readShort();
	        _sTypoDescender   = di.readShort();
	        _sTypoLineGap     = di.readShort();
	        _usWinAscent      = di.readUnsignedShort();
	        _usWinDescent     = di.readUnsignedShort();
	        _ulCodePageRange1 = di.readInt();
	        _ulCodePageRange2 = di.readInt();
	        
	        // OpenType 1.3
	        if (_version == 2) 
	        {
	            _sxHeight      = di.readShort();
	            _sCapHeight    = di.readShort();
	            _usDefaultChar = di.readUnsignedShort();
	            _usBreakChar   = di.readUnsignedShort();
	            _usMaxContext  = di.readUnsignedShort();
	        }
	    }
	
	    public function getVersion():uint
	    {
	        return _version;
	    }
	
	    public function getAvgCharWidth():int
	    {
	        return _xAvgCharWidth;
	    }
	
	    public function getWeightClass():int
	    {
	        return _usWeightClass;
	    }
	
	    public function getWidthClass():int
	    {
	        return _usWidthClass;
	    }
	
	    public function getLicenseType():int
	    {
	        return _fsType;
	    }
	
	    public function getSubscriptXSize():int
	    {
	        return _ySubscriptXSize;
	    }
	
	    public function getSubscriptYSize():int
	    {
	        return _ySubscriptYSize;
	    }
	
	    public function getSubscriptXOffset():int
	    {
	        return _ySubscriptXOffset;
	    }
	
	    public function getSubscriptYOffset():int
	    {
	        return _ySubscriptYOffset;
	    }
	
	    public function getSuperscriptXSize():int
	    {
	        return _ySuperscriptXSize;
	    }
	
	    public function getSuperscriptYSize():int
	    {
	        return _ySuperscriptYSize;
	    }
	
	    public function getSuperscriptXOffset():int
	    {
	        return _ySuperscriptXOffset;
	    }
	
	    public function getSuperscriptYOffset():int
	    {
	        return _ySuperscriptYOffset;
	    }
	
	    public function getStrikeoutSize():int
	    {
	        return _yStrikeoutSize;
	    }
	
	    public function getStrikeoutPosition():int
	    {
	        return _yStrikeoutPosition;
	    }
	
	    public function getFamilyClass():int
	    {
	        return _sFamilyClass;
	    }
	
	    public function getPanose():Panose
	    {
	        return _panose;
	    }
	
	    public function getUnicodeRange1():int
	    {
	        return _ulUnicodeRange1;
	    }
	
	    public function getUnicodeRange2():int
	    {
	        return _ulUnicodeRange2;
	    }
	
	    public function getUnicodeRange3():int
	    {
	        return _ulUnicodeRange3;
	    }
	
	    public function getUnicodeRange4():int
	    {
	        return _ulUnicodeRange4;
	    }
	
	    public function getVendorID():int
	    {
	        return _achVendorID;
	    }
	
	    public function getSelection():int
	    {
	        return _fsSelection;
	    }
	
	    public function getFirstCharIndex():uint
	    {
	        return _usFirstCharIndex;
	    }
	
	    public function getLastCharIndex():uint
	    {
	        return _usLastCharIndex;
	    }
	
	    public function getTypoAscender():int
	    {
	        return _sTypoAscender;
	    }
	
	    public function getTypoDescender():int
	    {
	        return _sTypoDescender;
	    }
	
	    public function getTypoLineGap():int
	    {
	        return _sTypoLineGap;
	    }
	
	    public function getWinAscent():uint
	    {
	        return _usWinAscent;
	    }
	
	    public function getWinDescent():uint
	    {
	        return _usWinDescent;
	    }
	
	    public function getCodePageRange1():int
	    {
	        return _ulCodePageRange1;
	    }
	
	    public function getCodePageRange2():int
	    {
	        return _ulCodePageRange2;
	    }
	
	    public function getXHeight():int
	    {
	        return _sxHeight;
	    }
	    
	    public function getCapHeight():int
	    {
	        return _sCapHeight;
	    }
	    
	    public function getDefaultChar():int
	    {
	        return _usDefaultChar;
	    }
	    
	    public function getBreakChar():int
	    {
	        return _usBreakChar;
	    }
	    
	    public function getMaxContext():int
	    {
	        return _usMaxContext;
	    }
	
	    public function toString():String
	    {
	        return new StringBuffer()
	            .append("'OS/2' Table - OS/2 and Windows Metrics\n---------------------------------------")
	            .append("\n  'OS/2' version:      ").append(_version)
	            .append("\n  xAvgCharWidth:       ").append(_xAvgCharWidth)
	            .append("\n  usWeightClass:       ").append(_usWeightClass)
	            .append("\n  usWidthClass:        ").append(_usWidthClass)
	            .append("\n  fsType:              0x").append((_fsType).toString(16))
	            .append("\n  ySubscriptXSize:     ").append(_ySubscriptXSize)
	            .append("\n  ySubscriptYSize:     ").append(_ySubscriptYSize)
	            .append("\n  ySubscriptXOffset:   ").append(_ySubscriptXOffset)
	            .append("\n  ySubscriptYOffset:   ").append(_ySubscriptYOffset)
	            .append("\n  ySuperscriptXSize:   ").append(_ySuperscriptXSize)
	            .append("\n  ySuperscriptYSize:   ").append(_ySuperscriptYSize)
	            .append("\n  ySuperscriptXOffset: ").append(_ySuperscriptXOffset)
	            .append("\n  ySuperscriptYOffset: ").append(_ySuperscriptYOffset)
	            .append("\n  yStrikeoutSize:      ").append(_yStrikeoutSize)
	            .append("\n  yStrikeoutPosition:  ").append(_yStrikeoutPosition)
	            .append("\n  sFamilyClass:        ").append(_sFamilyClass>>8)
	            .append("    subclass = ").append(_sFamilyClass&0xff)
	            .append("\n  PANOSE:              ").append(_panose.toString())
	            .append("\n  Unicode Range 1( Bits 0 - 31 ): ").append((_ulUnicodeRange1))
	            .append("\n  Unicode Range 2( Bits 32- 63 ): ").append((_ulUnicodeRange2).toString(16))
	            .append("\n  Unicode Range 3( Bits 64- 95 ): ").append((_ulUnicodeRange3).toString(16))
	            .append("\n  Unicode Range 4( Bits 96-127 ): ").append((_ulUnicodeRange4).toString(16))
	            .append("\n  achVendID:           '").append(getVendorIDAsString())
	            .append("'\n  fsSelection:         0x").append((_fsSelection).toString(16))
	            .append("\n  usFirstCharIndex:    0x").append((_usFirstCharIndex).toString(16))
	            .append("\n  usLastCharIndex:     0x").append((_usLastCharIndex).toString(16))
	            .append("\n  sTypoAscender:       ").append(_sTypoAscender)
	            .append("\n  sTypoDescender:      ").append(_sTypoDescender)
	            .append("\n  sTypoLineGap:        ").append(_sTypoLineGap)
	            .append("\n  usWinAscent:         ").append(_usWinAscent)
	            .append("\n  usWinDescent:        ").append(_usWinDescent)
	            .append("\n  CodePage Range 1( Bits 0 - 31 ): ").append((_ulCodePageRange1).toString(16))
	            .append("\n  CodePage Range 2( Bits 32- 63 ): ").append((_ulCodePageRange2).toString(16))
	            .toString();
	    }
	    
	    private function getVendorIDAsString():String
	    {
	        return new StringBuffer()
	            .append(String.fromCharCode((_achVendorID>>24)&0xff))
	            .append(String.fromCharCode((_achVendorID>>16)&0xff))
	            .append(String.fromCharCode((_achVendorID>>8)&0xff))
	            .append(String.fromCharCode((_achVendorID)&0xff))
	            .toString();
	    }

	}
}