package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class NameRecord
	{
	    private var _platformId:int;
	    private var _encodingId:int;
	    private var _languageId:int;
	    private var _nameId:int;
	    private var  _stringLength:int;
	    private var _stringOffset:int;
	    private var _record:String;
	
	    /**
	     * 
	     * @param di
	     * @throws IOError
	     */
	    public function NameRecord( di:ByteArray ):void
	    {
	        _platformId   = di.readShort();
	        _encodingId   = di.readShort();
	        _languageId   = di.readShort();
	        _nameId       = di.readShort();
	        _stringLength = di.readShort();
	        _stringOffset = di.readShort();
	    }
	    
	    public function getEncodingId():int
	    {
	        return _encodingId;
	    }
	    
	    public function getLanguageId():int
	    {
	        return _languageId;
	    }
	    
	    public function getNameId():int
	    {
	        return _nameId;
	    }
	    
	    public function getPlatformId():int
	    {
	        return _platformId;
	    }
	
	    public function getRecordString():String
	    {
	        return _record;
	    }
	
	    /**
	     * 
	     * @param di
	     * @throws IOError
	     */
	    internal function loadString( di:ByteArray ):void
	    {
	        var sb:StringBuffer = new StringBuffer();
	        var i:int;
	        di.position += _stringOffset;
	        
	        if (_platformId == ID.platformUnicode)
	        {
	            // Unicode (big-endian)
	            for (i = 0; i < _stringLength/2; i++)
	            {
	                sb.append( String.fromCharCode(di.readUnsignedShort()) );
	            }
	        } else if (_platformId == ID.platformMacintosh) 
	        {
	
	            // Macintosh encoding, ASCII
	            for (i = 0; i < _stringLength; i++)
	            {
	                sb.append(String.fromCharCode(di.readByte()));
	            }
	        } else if (_platformId == ID.platformISO) 
	        {
	            
	            // ISO encoding, ASCII
	            for (i = 0; i < _stringLength; i++) 
	            {
	                sb.append( String.fromCharCode( di.readByte() ) );
	            }
	        } else if (_platformId == ID.platformMicrosoft) 
	        {
	            
	            // Microsoft encoding, Unicode
	            var c:uint;
	            
	            for (i = 0; i < _stringLength/2; i++) {
	                c = di.readUnsignedShort();
	                sb.append(String.fromCharCode(c));
	            }
	        }
	        _record = sb.toString();
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        sb.append("             Platform ID:       ").append(_platformId)
	            .append("\n             Specific ID:       ").append(_encodingId)
	            .append("\n             Language ID:       ").append(_languageId)
	            .append("\n             Name ID:           ").append(_nameId)
	            .append("\n             Length:            ").append(_stringLength)
	            .append("\n             Offset:            ").append(_stringOffset)
	            .append("\n\n").append(_record);
	        
	        return sb.toString();
	    }		
	}
}