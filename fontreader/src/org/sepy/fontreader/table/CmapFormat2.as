package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.exception.ArrayIndexOutOfBoundsException;
	
	internal class CmapFormat2 extends CmapFormat
	{
	    
	    private var _subHeaderKeys:Array = new Array(256);	// int[]
	    private var _subHeaders:Array;						// SubHeader[]
	    private var _glyphIndexArray:Array;					// int[]
	
	    public function CmapFormat2( di:ByteArray ):void
	    {
	        super(di);
	        _format = 2;
	        var pos:int = 6;
	        
	        var highest:int = 0;
	        var i:uint;
	        
	        for (i = 0; i < 256; ++i)
	        {
	            _subHeaderKeys[i] = di.readUnsignedShort();
	            highest = Math.max(highest, _subHeaderKeys[i]);
	            pos += 2;
	        }
	        
	        var subHeaderCount:int = highest / 8 + 1;
	        _subHeaders = new Array( subHeaderCount );
	        
	        var indexArrayOffset:int = 8 * subHeaderCount + 518;
	        highest = 0;
	        for (i = 0; i < _subHeaders.length; ++i)
	        {
	            var sh:SubHeader  = new SubHeader();
	            sh._firstCode     = di.readUnsignedShort();
	            sh._entryCount    = di.readUnsignedShort();
	            sh._idDelta       = di.readShort();
	            sh._idRangeOffset = di.readUnsignedShort();
	            
	            pos += 8;
	            sh._arrayIndex = (pos - 2 + sh._idRangeOffset - indexArrayOffset) / 2;
	            
	            highest = Math.max(highest, sh._arrayIndex + sh._entryCount);
	            _subHeaders[i] = sh;
	        }
	        
	        _glyphIndexArray = new Array( highest );
	        
	        for (i = 0; i < _glyphIndexArray.length; ++i)
	        {
	            _glyphIndexArray[i] = di.readUnsignedShort();
	        }
	    }
	
	    override public function get rangeCount():int
	    {
	        return _subHeaders.length;
	    }
	    
	    /**
	     * 
	     * @param index
	     * @return 
	     * @throws ArrayIndexOutOfBoundsException
	     */
	    override public function getRange( index:int ):Range
	    {
	        if (index < 0 || index >= _subHeaders.length)
	        {
	            throw new ArrayIndexOutOfBoundsException();
	        }
	        
	        var highByte:int = 0;
	        if (index != 0)
	        {
	            for (var i:uint = 0; i < 256; ++i)
	            {
	                if (_subHeaderKeys[i] / 8 == index)
	                {
	                    highByte = i << 8;
	                    break;
	                }
	            }
	        }
	        return new Range( highByte | SubHeader(_subHeaders[index])._firstCode, highByte | ( SubHeader(_subHeaders[index])._firstCode + SubHeader(_subHeaders[index])._entryCount - 1) );
	    }
	    
	
	    override public function mapCharCode(charCode:int):int
	    {
	        var index:int = 0;
	        var highByte:int = charCode >> 8;
	        
	        if (highByte != 0)
	        {
	            index = _subHeaderKeys[highByte] / 8;
	        }
	        var sh:SubHeader = _subHeaders[index];
	        
	        var lowByte:int = charCode & 0xff;
	        if (lowByte < sh._firstCode || lowByte >= (sh._firstCode + sh._entryCount))
	            return 0;
	        
	        var glyphIndex:int = _glyphIndexArray[sh._arrayIndex + (lowByte - sh._firstCode)];
	        if (glyphIndex != 0)
	        {
	            glyphIndex += sh._idDelta;
	            glyphIndex %= 65536;
	        }
	        return glyphIndex;
	    }		
	}
}


class SubHeader 
{
    public var _firstCode:int;
    public var _entryCount:int;
    public var _idDelta:int;
    public var _idRangeOffset:int;
    public var _arrayIndex:int;
}
	    