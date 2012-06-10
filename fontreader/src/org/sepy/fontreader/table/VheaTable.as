package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	import org.sepy.fontreader.utils.Fixed;
	
	public class VheaTable extends Table
	{
	    private var _version:int;
	    private var _ascent:int;
	    private var _descent:int;
	    private var _lineGap:int;
	    private var _advanceHeightMax:int;
	    private var _minTopSideBearing:int;
	    private var _minBottomSideBearing:int;
	    private var _yMaxExtent:int;
	    private var _caretSlopeRise:int;
	    private var _caretSlopeRun:int;
	    private var _metricDataFormat:int;
	    private var _numberOfLongVerMetrics:int;
	
	    public function VheaTable( de:DirectoryEntry, di:ByteArray ):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = vhea;
	        
	        _version = di.readInt();
	        _ascent = di.readShort();
	        _descent = di.readShort();
	        _lineGap = di.readShort();
	        _advanceHeightMax = di.readShort();
	        _minTopSideBearing = di.readShort();
	        _minBottomSideBearing = di.readShort();
	        _yMaxExtent = di.readShort();
	        _caretSlopeRise = di.readShort();
	        _caretSlopeRun = di.readShort();
	        
	        for (var i:uint = 0; i < 5; ++i) {
	            di.readShort();
	        }
	        _metricDataFormat = di.readShort();
	        _numberOfLongVerMetrics = di.readUnsignedShort();
	    }
	
	    public function getAdvanceHeightMax():int
	    {
	        return _advanceHeightMax;
	    }
	
	    public function getAscent():int
	    {
	        return _ascent;
	    }
	
	    public function getCaretSlopeRise():int
	    {
	        return _caretSlopeRise;
	    }
	
	    public function getCaretSlopeRun():int
	    {
	        return _caretSlopeRun;
	    }
	
	    public function getDescent():int
	    {
	        return _descent;
	    }
	
	    public function getLineGap():int
	    {
	        return _lineGap;
	    }
	
	    public function getMetricDataFormat():int
	    {
	        return _metricDataFormat;
	    }
	
	    public function getMinTopSideBearing():int
	    {
	        return _minTopSideBearing;
	    }
	
	    public function getMinBottomSideBearing():int
	    {
	        return _minBottomSideBearing;
	    }
	
	    public function getNumberOfLongVerMetrics():int
	    {
	        return _numberOfLongVerMetrics;
	    }
	
	    public function getYMaxExtent():int
	    {
	        return _yMaxExtent;
	    }
	
	    public function toString():String
	    {
	        return new StringBuffer()
	            .append("'vhea' Table - Vertical Header\n------------------------------")
	            .append("\n        'vhea' version:       ").append(Fixed.floatValue(_version))
	            .append("\n        xAscender:            ").append(_ascent)
	            .append("\n        xDescender:           ").append(_descent)
	            .append("\n        xLineGap:             ").append(_lineGap)
	            .append("\n        advanceHeightMax:     ").append(_advanceHeightMax)
	            .append("\n        minTopSideBearing:    ").append(_minTopSideBearing)
	            .append("\n        minBottomSideBearing: ").append(_minBottomSideBearing)
	            .append("\n        yMaxExtent:           ").append(_yMaxExtent)
	            .append("\n        horizCaretSlopeNum:   ").append(_caretSlopeRise)
	            .append("\n        horizCaretSlopeDenom: ").append(_caretSlopeRun)
	            .append("\n        reserved0:            0")
	            .append("\n        reserved1:            0")
	            .append("\n        reserved2:            0")
	            .append("\n        reserved3:            0")
	            .append("\n        reserved4:            0")
	            .append("\n        metricDataFormat:     ").append(_metricDataFormat)
	            .append("\n        numOf_LongVerMetrics: ").append(_numberOfLongVerMetrics)
	            .toString();
	    }
	}

}