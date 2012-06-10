package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	internal class LigatureSubstFormat1 extends LigatureSubst
	{
	    private var _coverageOffset:uint;
	    private var _ligSetCount:uint;
	    private var _ligatureSetOffsets:Array;
	    private var _coverage:Coverage;
	    private var _ligatureSets:Array;
	
	    public function LigatureSubstFormat1( dis:ByteArray,  offset:uint):void
	    {
	    	var i:uint;
	        _coverageOffset = dis.readUnsignedShort();
	        _ligSetCount    = dis.readUnsignedShort();
	        _ligatureSetOffsets = new Array( _ligSetCount) ;
	        _ligatureSets = new Array( _ligSetCount );
	        
	        for (i = 0; i < _ligSetCount; i++) {
	            _ligatureSetOffsets[i] = dis.readUnsignedShort();
	        }

	        dis.position = (offset + _coverageOffset);
	        _coverage = Coverage.read(dis);
	        
	        for (i = 0; i < _ligSetCount; i++) {
	            _ligatureSets[i] = new LigatureSet(dis, offset + _ligatureSetOffsets[i]);
	        }
	    }
	
	    public function getFormat():int {
	        return 1;
	    }
	
	    override public function getTypeAsString():String {
	        return "LigatureSubstFormat1";
	    }  		
	}
}