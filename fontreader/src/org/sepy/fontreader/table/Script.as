package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class Script
	{
	    private var _defaultLangSysOffset:int;
	    private var _langSysCount:int;
	    private var _langSysRecords:Array;
	    private var _defaultLangSys:LangSys;
	    private var _langSys:Array;
	    
	    public function Script( dis:ByteArray, offset:int ):void
	    {
	        dis.position = 0;
	        dis.position = offset;
	        
	        var i:uint;
	        
	        _defaultLangSysOffset = dis.readUnsignedShort();
	        _langSysCount = dis.readUnsignedShort();
	        if (_langSysCount > 0) 
	        {
	            _langSysRecords = new Array(_langSysCount);
	            for (i = 0; i < _langSysCount; i++) 
	            {
	                _langSysRecords[i] = new LangSysRecord(dis);
	            }
	        }
	
	        // Read the LangSys tables
	        if (_langSysCount > 0) 
	        {
	            _langSys = new Array(_langSysCount);
	            for ( i = 0; i < _langSysCount; i++) 
	            {
	                dis.position = 0;
	                dis.position += ( offset + LangSysRecord(_langSysRecords[i]).offset );
	                _langSys[i] = new LangSys(dis);
	            }
	        }
	        
	        if (_defaultLangSysOffset > 0) 
	        {
	            dis.position = 0;
	            dis.position += (offset + _defaultLangSysOffset);
	            _defaultLangSys = new LangSys(dis);
	        }
	    }
	
	    public function getLangSysCount():int
	    {
	        return _langSysCount;
	    }
	    
	    public function getLangSysRecord(i:uint):LangSysRecord
	    {
	        return _langSysRecords[i];
	    }
	
	    public function getDefaultLangSys():LangSys
	    {
	        return _defaultLangSys;
	    }
	
	    public function getLangSys(i:uint):LangSys
	    {
	        return _langSys[i];
	    }		
	}
}