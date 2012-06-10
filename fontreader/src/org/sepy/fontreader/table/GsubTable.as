package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;

	public class GsubTable extends Table implements ILookupSubtableFactory
	{
			
	    private var _scriptList:ScriptList;
	    private var _featureList:FeatureList;
	    private var _lookupList:LookupList;

	    public function GsubTable( de:DirectoryEntry, di:ByteArray):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = GSUB;
	        
	        // Load into a temporary buffer, and create another input stream
	        var dis:ByteArray = new ByteArray();
	        di.readBytes( dis, 0, _de.length );
	
	        // GSUB Header
	        var version:int            = dis.readInt();
	        var scriptListOffset:uint  = dis.readUnsignedShort();
	        var featureListOffset:uint = dis.readUnsignedShort();
	        var lookupListOffset:uint  = dis.readUnsignedShort();
	
	        // Script List
	        _scriptList = new ScriptList(dis, scriptListOffset);
	
	        // Feature List
	        _featureList = new FeatureList(dis, featureListOffset);
	        
	        // Lookup List
	        _lookupList = new LookupList(dis, lookupListOffset, this);
	    }

		/**
		 * 1 - Single - Replace one glyph with one glyph 
		 * 2 - Multiple - Replace one glyph with more than one glyph 
		 * 3 - Alternate - Replace one glyph with one of many glyphs 
		 * 4 - Ligature - Replace multiple glyphs with one glyph 
		 * 5 - Context - Replace one or more glyphs in context 
		 * 6 - Chaining - Context Replace one or more glyphs in chained context
		 */		
		public function read(type:int, dis:ByteArray, offset:int):ILookupSubtable
		{
	        var s:ILookupSubtable = null;
	        
	        switch (type) 
	        {
	        	case 1:
	            	s = SingleSubst.read(dis, offset);
	            	break;
		        case 2:
		        case 3:
		            break;
		        case 4:
	    	        s = LigatureSubst.read(dis, offset);
	        	    break;
		        case 5:
		        case 6:
	    	        break;
	        }
	        return s;
		}
		

	    public function get scriptList():ScriptList
	    {
	        return _scriptList;
	    }
	
	    public function get featureList():FeatureList
	    {
	        return _featureList;
	    }
	
	    public function get lookupList():LookupList
	    {
	        return _lookupList;
	    }
	
	    public function toString():String
	    {
	        return "GSUB";
	    }
	    
	    public static function lookupTypeAsString(type:int):String
	    {
	        switch (type)
	        {
		        case 1:
		            return "Single";
		        case 2:
		            return "Multiple";
		        case 3:
		            return "Alternate";
		        case 4:
		            return "Ligature";
		        case 5:
		            return "Context";
		        case 6:
		            return "Chaining";
	        }
	        return "Unknown";
	    }
		
	}
}