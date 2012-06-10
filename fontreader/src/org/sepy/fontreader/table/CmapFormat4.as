package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.exception.ArrayIndexOutOfBoundsException;
	import org.sepy.fontreader.utils.StringBuffer;
	
	internal class CmapFormat4 extends CmapFormat
	{
	    private var _segCountX2:uint;
	    private var _searchRange:uint;
	    private var _entrySelector:uint;
	    private var _rangeShift:uint;
	    private var _endCode:Array;			// int[]
	    private var _startCode:Array;		// int[]
	    private var _idDelta:Array;			// int[]
	    private var _idRangeOffset:Array;	// int[]
	    private var _glyphIdArray:Array;	// int[]
	    private var _segCount:int;
	
	    public function CmapFormat4( di:ByteArray ):void
	    {
	        super(di);
	        _format = 4;
	        _segCountX2 = di.readUnsignedShort();
	        _segCount   = _segCountX2 / 2;
	        _endCode    = new Array( _segCount );
	        _startCode  = new Array( _segCount );
	        _idDelta    = new Array( _segCount );
	        _idRangeOffset = new Array( _segCount );
	        _searchRange   = di.readUnsignedShort();
	        _entrySelector = di.readUnsignedShort();
	        _rangeShift    = di.readUnsignedShort();
	        
	        var i:uint;
	        for (i = 0; i < _segCount; i++)
	        {
	            _endCode[i] = di.readUnsignedShort();
	        }
	        di.readUnsignedShort();
	        
	        for (i = 0; i < _segCount; i++)
	        {
	            _startCode[i] = di.readUnsignedShort();
	        }
	        
	        for (i = 0; i < _segCount; i++)
	        {
	            _idDelta[i] = di.readUnsignedShort();
	        }
	        
	        for (i = 0; i < _segCount; i++)
	        {
	            _idRangeOffset[i] = di.readUnsignedShort();
	        }
	
	        var count:int = (_length - (8*_segCount + 16)) / 2;
	        _glyphIdArray = new Array( count );
	        
	        for (i = 0; i < count; i++)
	        {
	            _glyphIdArray[i] = di.readUnsignedShort();
	        }
	    }
	
	    override public function get rangeCount():int
	    {
	        return _segCount;
	    }
	    
	    
	    /**
	     * 
	     * @param index
	     * @return 
	     * @throws ArrayIndexOutOfBoundsException
	     */
	    override public function getRange( index:int ):Range
	    {
	        if ( index < 0 || index >= _segCount )
	        {
	            throw new ArrayIndexOutOfBoundsException();
	        }
	        return new Range( _startCode[index], _endCode[index] );
	    }
	
	    override public function mapCharCode( charCode:int ):int
	    {
	        try 
	        {
	            for (var i:uint = 0; i < _segCount; i++)
	            {
	                if ( _endCode[i] >= charCode )
	                {
	                    if ( _startCode[i] <= charCode )
	                    {
	                        if ( _idRangeOffset[i] > 0 )
	                        {
	                            return _glyphIdArray[_idRangeOffset[i]/2 + (charCode - _startCode[i]) - (_segCount - i)];
	                        } else 
	                        {
	                            return (_idDelta[i] + charCode) % 65536;
	                        }
	                    } else 
	                    {
	                        break;
	                    }
	                }
	            }
	        } catch (e:ArrayIndexOutOfBoundsException)
	        {
	            trace("ArrayIndexOutOfBoundsException: Array out of bounds - " + e.message);
	        }
	        return 0;
	    }
	
	    override public function toString():String
	    {
	        return new StringBuffer()
	            .append(super.toString())
	            .append(", segCountX2: ")
	            .append(_segCountX2)
	            .append(", searchRange: ")
	            .append(_searchRange)
	            .append(", entrySelector: ")
	            .append(_entrySelector)
	            .append(", rangeShift: ")
	            .append(_rangeShift)
	            .append(", endCode: ")
	            .append(_endCode)
	            .append(", startCode: ")
	            .append(_endCode)
	            .append(", idDelta: ")
	            .append(_idDelta)
	            .append(", idRangeOffset: ")
	            .append(_idRangeOffset).toString();
	    }
	}
}