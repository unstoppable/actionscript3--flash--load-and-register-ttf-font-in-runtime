package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class ScriptList
	{
		
	    private var _scriptCount:uint = 0;
	    private var _scriptRecords:Array;
	    private var _scripts:Array;
	    
	    public function ScriptList(dis:ByteArray, offset:int):void
	    {
	        // Ensure we're in the right place
	        dis.position = 0;
	        dis.position = offset;
	        
	        // Start reading
	        _scriptCount   = dis.readUnsignedShort();
	        _scriptRecords = new Array(_scriptCount);
	        _scripts = new Array(_scriptCount);
	        
	        var i:uint;
	        for (i = 0; i < _scriptCount; i++) 
	        {
	            _scriptRecords[i] = new ScriptRecord(dis);
	        }
	        for (i = 0; i < _scriptCount; i++) {
	            _scripts[i] = new Script( dis, offset + ScriptRecord(_scriptRecords[i]).offset );
	        }
	    }
	
	    public function getScriptCount():uint
	    {
	        return _scriptCount;
	    }
	    
	    public function getScriptRecord(i:uint):ScriptRecord
	    {
	        return _scriptRecords[i];
	    }
	    
	    public function getScript(i:uint):Script
	    {
	        return _scripts[i];
	    }
	    
	    public function findScript( tag:String ):String
	    {
	        if (tag.length != 4) {
	            return null;
	        }
	        
	        var tagVal:int = ((tag.charCodeAt(0) << 24) | (tag.charCodeAt(1) << 16) | (tag.charCodeAt(2) << 8) | tag.charCodeAt(3));
	            
	        for (var i:uint = 0; i < _scriptCount; i++) {
	            if (_scriptRecords[i].getTag() == tagVal) {
	                return _scripts[i];
	            }
	        }
	        return null;
	    }		
	}
}