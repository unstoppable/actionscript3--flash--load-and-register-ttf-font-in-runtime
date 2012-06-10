package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class FeatureList
	{

	    private var _featureCount:uint;
	    private var _featureRecords:Array;
	    private var _features:Array;
	
	    public function FeatureList( dis:ByteArray, offset:uint):void
	    {
	        var i:uint;
	        dis.position = offset;
	        
	        // Start reading
	        _featureCount   = dis.readUnsignedShort();
	        _featureRecords = new Array( _featureCount );
	        _features       = new Array( _featureCount );

	        for (i = 0; i < _featureCount; i++)
	        {
	            _featureRecords[i] = new FeatureRecord(dis);
	        }
	        
	        for (i = 0; i < _featureCount; i++)
	        {
	            dis.position = 0;
	            dis.position += ( offset + FeatureRecord(_featureRecords[i]).offset );
	            _features[i] = new Feature(dis);
	        }
	    }
	
	    public function get featureCount():uint
	    {
	        return _featureCount;
	    }
	    
	    public function getFeatureRecord(i:uint):FeatureRecord
	    {
	        return _featureRecords[i];
	    }
	    
	    public function getFeature(i:uint):Feature
	    {
	        return _features[i];
	    }
	
	    public function findFeature(langSys:LangSys, tag:String):Feature
	    {
	        if (tag.length != 4) {
	            return null;
	        }
	    
	        var tagVal:int = ((tag.charCodeAt(0) << 24) | (tag.charCodeAt(1) << 16) | (tag.charCodeAt(2) << 8) | tag.charCodeAt(3));
	            
	        for (var i:uint = 0; i < _featureCount; i++) 
	        {
	            if (_featureRecords[i].getTag() == tagVal)
	            {
	                if (langSys.isFeatureIndexed(i))
	                {
	                    return _features[i];
	                }
	            }
	        }
	        return null;
	    }		
	}
}