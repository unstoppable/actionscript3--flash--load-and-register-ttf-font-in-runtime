package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class LookupList
	{

	    private var _lookupCount:uint;
	    private var _lookupOffsets:Array;
	    private var _lookups:Array;
	
		public function LookupList( dis:ByteArray, offset:uint, factory:ILookupSubtableFactory):void
		{
			var i:uint;
	        dis.position = offset;

	        _lookupCount   = dis.readUnsignedShort();
	        _lookupOffsets = new Array( _lookupCount );
	        _lookups       = new Array( _lookupCount );
	        
	        for (i = 0; i < _lookupCount; i++)
	        {
	            _lookupOffsets[i] = dis.readUnsignedShort();
	        }
	        
	        for (i = 0; i < _lookupCount; i++)
	        {
	            _lookups[i] = new Lookup(factory, dis, offset + _lookupOffsets[i]);
	        }
	    }
	
	
	    public function get lookupCount():uint
	    {
	        return _lookupCount;
	    }
	    
	    public function getLookupOffset(i:uint):uint
	    {
	        return _lookupOffsets[i];
	    }
	    
	    public function getLookup(i:uint):Lookup
	    {
	        return _lookups[i];
	    }
	
	    public function getLookupFeature(feature:Feature, index:int):String
	    {
	        if (feature.lookupCount > index)
	        {
	            var i:uint = feature.getLookupListIndex(index);
	            return _lookups[i];
	        }
	        return null;
	    }
	}
}