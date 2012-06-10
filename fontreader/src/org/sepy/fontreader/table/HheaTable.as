package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	import org.sepy.fontreader.utils.Fixed;
	
	public class HheaTable extends Table
	{
	    private var de:DirectoryEntry;
	    private var version:int;
	    private var ascender:int;
	    private var descender:int;
	    private var lineGap:int;
	    private var advanceWidthMax:int;
	    private var minLeftSideBearing:int;
	    private var minRightSideBearing:int;
	    private var xMaxExtent:int;
	    private var caretSlopeRise:int;
	    private var caretSlopeRun:int;
	    private var metricDataFormat:int;
	    private var numberOfHMetrics:int;
	
	    public function HheaTable(_de:DirectoryEntry, di:ByteArray):void
	    {
	        de = DirectoryEntry(_de.clone());
	        version = di.readInt();
	        ascender = di.readShort();
	        descender = di.readShort();
	        lineGap = di.readShort();
	        advanceWidthMax = di.readShort();
	        minLeftSideBearing = di.readShort();
	        minRightSideBearing = di.readShort();
	        xMaxExtent = di.readShort();
	        caretSlopeRise = di.readShort();
	        caretSlopeRun = di.readShort();
	        for (var i:int = 0; i < 5; i++) {
	            di.readShort();
	        }
	        metricDataFormat = di.readShort();
	        numberOfHMetrics = di.readShort();
	    }
	
	    public function getAdvanceWidthMax():int
	    {
	        return advanceWidthMax;
	    }
	
	    public function getAscender():int
	    {
	        return ascender;
	    }
	
	    public function getCaretSlopeRise():int
	    {
	        return caretSlopeRise;
	    }
	
	    public function getCaretSlopeRun():int
	    {
	        return caretSlopeRun;
	    }
	
	    public function getDescender():int
	    {
	        return descender;
	    }
	
	    public function getLineGap():int
	    {
	        return lineGap;
	    }
	
	    public function getMetricDataFormat():int
	    {
	        return metricDataFormat;
	    }
	
	    public function getMinLeftSideBearing():int
	    {
	        return minLeftSideBearing;
	    }
	
	    public function getMinRightSideBearing():int
	    {
	        return minRightSideBearing;
	    }
	
	    public function getNumberOfHMetrics():int
	    {
	        return numberOfHMetrics;
	    }
	
	    override public function get type():int
	    {
	        return hhea;
	    }
	
	    public function getXMaxExtent():int
	    {
	        return xMaxExtent;
	    }
	
	    public function toString():String {
	        return new StringBuffer()
	            .append("'hhea' Table - Horizontal Header\n--------------------------------")
	            .append("\n        'hhea' version:       ").append(Fixed.floatValue(version))
	            .append("\n        yAscender:            ").append(ascender)
	            .append("\n        yDescender:           ").append(descender)
	            .append("\n        yLineGap:             ").append(lineGap)
	            .append("\n        advanceWidthMax:      ").append(advanceWidthMax)
	            .append("\n        minLeftSideBearing:   ").append(minLeftSideBearing)
	            .append("\n        minRightSideBearing:  ").append(minRightSideBearing)
	            .append("\n        xMaxExtent:           ").append(xMaxExtent)
	            .append("\n        horizCaretSlopeNum:   ").append(caretSlopeRise)
	            .append("\n        horizCaretSlopeDenom: ").append(caretSlopeRun)
	            .append("\n        reserved0:            0")
	            .append("\n        reserved1:            0")
	            .append("\n        reserved2:            0")
	            .append("\n        reserved3:            0")
	            .append("\n        reserved4:            0")
	            .append("\n        metricDataFormat:     ").append(metricDataFormat)
	            .append("\n        numOf_LongHorMetrics: ").append(numberOfHMetrics)
	            .toString();
	    }
	    
	    /**
	     * Get a directory entry for this table.  This uniquely identifies the
	     * table in collections where there may be more than one instance of a
	     * particular table.
	     * @return A directory entry
	     */
	    override public function get directoryEntry():DirectoryEntry
	    {
	        return de;
	    }
	    
	}

}