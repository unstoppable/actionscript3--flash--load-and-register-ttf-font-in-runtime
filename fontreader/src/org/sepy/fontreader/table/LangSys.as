package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class LangSys
	{
	    private var _lookupOrder:int;
	    private var _reqFeatureIndex:int;
	    private var _featureCount:int;
	    private var _featureIndex:Array;
	    
	    public function LangSys( di:ByteArray ):void
	    {
	        _lookupOrder     = di.readUnsignedShort();
	        _reqFeatureIndex = di.readUnsignedShort();
	        _featureCount    = di.readUnsignedShort();
	        _featureIndex    = new Array(_featureCount);
	        
	        for (var i:uint = 0; i < _featureCount; i++)
	        {
	            _featureIndex[i] = di.readUnsignedShort();
	        }
	    }
	    
	    public function getLookupOrder():int
	    {
	        return _lookupOrder;
	    }
	    
	    public function getReqFeatureIndex():int
	    {
	        return _reqFeatureIndex;
	    }
	    
	    public function getFeatureCount():int
	    {
	        return _featureCount;
	    }
	    
	    public function getFeatureIndex(i:uint):int
	    {
	        return _featureIndex[i];
	    }
	
	    internal function isFeatureIndexed(n:int):Boolean
	    {
	        for (var i:uint = 0; i < _featureCount; i++)
	        {
	            if (_featureIndex[i] == n)
	            {
	                return true;
	            }
	        }
	        return false;
	    }		
	}
}