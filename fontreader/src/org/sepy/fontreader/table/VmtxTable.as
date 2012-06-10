package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class VmtxTable extends Table
	{
	    private var _vMetrics:Array;		// int[]
	    private var _topSideBearing:Array;	// short[]
	
	    /**
	     * 
	     * @param de
	     * @param di
	     * @param vhea
	     * @param maxp
	     * @throws IOError
	     */
	    public function VmtxTable( de:DirectoryEntry, di:ByteArray, vhea:VheaTable, maxp:MaxpTable):void
	    {
	    	var i:int;
	        _de   = DirectoryEntry(de.clone());
	        _type = vmtx;
	        
	        _vMetrics = new Array( vhea.getNumberOfLongVerMetrics() );
	        for (i = 0; i < vhea.getNumberOfLongVerMetrics(); ++i) 
	        {
	            _vMetrics[i] = di.readUnsignedByte() << 24 | di.readUnsignedByte() << 16 | di.readUnsignedByte() << 8 | di.readUnsignedByte();
	        }
	        var tsbCount:int = maxp.getNumGlyphs() - vhea.getNumberOfLongVerMetrics();
	        
	        _topSideBearing = new Array( tsbCount );
	        for (i = 0; i < tsbCount; ++i) 
	        {
	            _topSideBearing[i] = di.readShort();
	        }
	    }
	
	    public function getAdvanceHeight( i:int ):int
	    {
	        if (_vMetrics == null) 
	        {
	            return 0;
	        }
	        if (i < _vMetrics.length) 
	        {
	            return _vMetrics[i] >> 16;
	        } else 
	        {
	            return _vMetrics[_vMetrics.length - 1] >> 16;
	        }
	    }
	
	    public function getTopSideBearing( i:int ):int
	    {
	        if (_vMetrics == null) 
	        {
	            return 0;
	        }
	        if (i < _vMetrics.length) 
	        {
	            return (_vMetrics[i] & 0xffff);
	        } else 
	        {
	            return _topSideBearing[i - _vMetrics.length];
	        }
	    }
	
	    public function toString():String
	    {
	    	var i:uint;
	        var sb:StringBuffer = new StringBuffer();
	        sb.append("'vmtx' Table - Vertical Metrics\n-------------------------------\n");
	        sb.append("Size = ").append(_de.length).append(" bytes, ")
	            .append(_vMetrics.length).append(" entries\n");
	        
	        for (i = 0; i < _vMetrics.length; i++) 
	        {
	            sb.append("        ").append(i)
	                .append(". advHeight: ").append(getAdvanceHeight(i))
	                .append(", TSdBear: ").append(getTopSideBearing(i))
	                .append("\n");
	        }
	        
	        for (i = 0; i < _topSideBearing.length; i++) 
	        {
	            sb.append("        TSdBear ").append(i + _vMetrics.length)
	                .append(": ").append(_topSideBearing[i])
	                .append("\n");
	        }
	        return sb.toString();
	    }		
	}
}