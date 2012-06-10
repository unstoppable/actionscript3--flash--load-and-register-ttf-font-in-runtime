package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class HmtxTable extends Table
	{
	    private var _hMetrics:Array;		// int[]
	    private var _leftSideBearing:Array;	// short[]
	
	    public function HmtxTable( de:DirectoryEntry, di:ByteArray, hhea:HheaTable, maxp:MaxpTable):void
	    {
	        _de   = DirectoryEntry( de.clone() );
	        _type = hmtx;
	        
	        var i:int;
	        _hMetrics = new Array( hhea.getNumberOfHMetrics() );
	        
	        for (i = 0; i < hhea.getNumberOfHMetrics(); ++i)
	        {
	            _hMetrics[i] = di.readUnsignedByte() << 24 | di.readUnsignedByte() << 16 | di.readUnsignedByte() << 8 | di.readUnsignedByte();
	        }
	        
	        var lsbCount:int = maxp.getNumGlyphs() - hhea.getNumberOfHMetrics();
	        
	        _leftSideBearing = new Array( lsbCount );
	        
	        for (i = 0; i < lsbCount; ++i)
	        {
	            _leftSideBearing[i] = di.readShort();
	        }
	    }
	
	
	    public function getAdvanceWidth( i:int ):int
	    {
	        if (_hMetrics == null)
	        {
	            return 0;
	        }
	        if (i < _hMetrics.length)
	        {
	            return _hMetrics[i] >> 16;
	        } else {
	            return _hMetrics[_hMetrics.length - 1] >> 16;
	        }
	    }
	
	    public function getLeftSideBearing( i:int ):int
	    {
	        if (_hMetrics == null)
	        {
	            return 0;
	        }
	        if (i < _hMetrics.length) 
	        {
	            return (_hMetrics[i] & 0xffff);
	        } else 
	        {
	            return _leftSideBearing[i - _hMetrics.length];
	        }
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        var i:int;
	        sb.append("'hmtx' Table - Horizontal Metrics\n---------------------------------\n");
	        sb.append("Size = ").append( _de.length ).append(" bytes, ").append(_hMetrics.length).append(" entries\n");
	            
	        for (i = 0; i < _hMetrics.length; i++) {
	            sb.append("        ").append(i)
	                .append(". advWid: ").append(getAdvanceWidth(i))
	                .append(", LSdBear: ").append(getLeftSideBearing(i))
	                .append("\n");
	        }
	        for (i = 0; i < _leftSideBearing.length; i++) {
	            sb.append("        LSdBear ").append(i + _hMetrics.length)
	                .append(": ").append(_leftSideBearing[i])
	                .append("\n");
	        }
	        return sb.toString();
	    }		
	}
}