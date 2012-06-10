package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class GlyfTable extends Table
	{
	    private var _descript:Array;	// GlyfDescript[]
	
	    public function GlyfTable( de:DirectoryEntry, di:ByteArray, maxp:MaxpTable, loca:LocaTable ):void
	    {
	        _de   = DirectoryEntry( de.clone() );
	        _type = glyf;
	        _descript = new Array( maxp.getNumGlyphs() );
	        
	        
	        // Buffer the whole table so we can randomly access it
	        var i:int;
	        var len:int;
	        var dis:ByteArray;
	        var numberOfContours:int;
	        var bais:ByteArray = new ByteArray();
	        di.readBytes( bais, 0, de.length );
	        
	        // Process all the simple glyphs
	        for (i = 0; i < maxp.getNumGlyphs(); i++)
	        {
	            len = loca.getOffset((i + 1)) - loca.getOffset(i);
	            if (len > 0)
	            {
	                bais.position = 0;
	                bais.position = loca.getOffset(i);
	                dis = new ByteArray();
	                bais.readBytes(dis);
	                
	                numberOfContours = dis.readShort();
	                if (numberOfContours >= 0)
	                {
	                    _descript[i] = new GlyfSimpleDescript(this, i, numberOfContours, dis);
	                }
	            } else
	            {
	                _descript[i] = null;
	            }
	        }
	
	        // Now do all the composite glyphs
	        for (i = 0; i < maxp.getNumGlyphs(); i++)
	        {
	            len = loca.getOffset((i + 1)) - loca.getOffset(i);
	            if (len > 0)
	            {
	                bais.position = 0;
	                bais.position = loca.getOffset(i);
	                
	                dis = new ByteArray();
	                bais.readBytes(dis);
	                
	                numberOfContours = dis.readShort();
	                if (numberOfContours < 0)
	                {
	                    _descript[i] = new GlyfCompositeDescript(this, i, dis);
	                }
	            }
	        }
	    }
	
	    public function getDescription( i:int ):GlyfDescript
	    {
	        if (i < _descript.length)
	        {
	            return _descript[i];
	        } else {
	            return null;
	        }
	    }
	}
}