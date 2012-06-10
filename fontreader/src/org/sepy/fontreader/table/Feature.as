package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class Feature
	{
	    private var _featureParams:uint;
	    private var _lookupCount:uint;
	    private var _lookupListIndex:Array;
	
	    public function Feature( di:ByteArray ):void
	    {
	        _featureParams = di.readUnsignedShort();
	        _lookupCount   = di.readUnsignedShort();
	        _lookupListIndex = new Array(_lookupCount);
	        
	        for (var i:uint = 0; i < _lookupCount; i++)
	        {
	            _lookupListIndex[i] = di.readUnsignedShort();
	        }
	    }
	
	    public function get lookupCount():uint
	    {
	        return _lookupCount;
	    }
	
	    public function getLookupListIndex(i:uint):uint
	    {
	        return _lookupListIndex[i];
	    }		
	}
}