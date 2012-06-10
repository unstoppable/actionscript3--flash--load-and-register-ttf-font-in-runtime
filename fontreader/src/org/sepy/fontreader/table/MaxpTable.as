package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.Fixed;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class MaxpTable extends Table
	{
	    private var versionNumber:int;
	    private var numGlyphs:int;
	    private var maxPoints:int;
	    private var maxContours:int;
	    private var maxCompositePoints:int;
	    private var maxCompositeContours:int;
	    private var maxZones:int;
	    private var maxTwilightPoints:int;
	    private var maxStorage:int;
	    private var maxFunctionDefs:int;
	    private var maxInstructionDefs:int;
	    private var maxStackElements:int;
	    private var maxSizeOfInstructions:int;
	    private var maxComponentElements:int;
	    private var maxComponentDepth:int;
	
	    public function MaxpTable(de:DirectoryEntry, di:ByteArray):void
	    {
	        _de   = DirectoryEntry(de.clone());
	        _type = maxp;
	        
	        versionNumber = di.readInt();
	        
	        // CFF fonts use version 0.5, TrueType fonts use version 1.0
	        if (versionNumber == 0x00005000) 
	        {
	            numGlyphs = di.readUnsignedShort();
	        } else if (versionNumber == 0x00010000) 
	        {
	            numGlyphs = di.readUnsignedShort();
	            maxPoints = di.readUnsignedShort();
	            maxContours = di.readUnsignedShort();
	            maxCompositePoints = di.readUnsignedShort();
	            maxCompositeContours = di.readUnsignedShort();
	            maxZones = di.readUnsignedShort();
	            maxTwilightPoints = di.readUnsignedShort();
	            maxStorage = di.readUnsignedShort();
	            maxFunctionDefs = di.readUnsignedShort();
	            maxInstructionDefs = di.readUnsignedShort();
	            maxStackElements = di.readUnsignedShort();
	            maxSizeOfInstructions = di.readUnsignedShort();
	            maxComponentElements = di.readUnsignedShort();
	            maxComponentDepth = di.readUnsignedShort();
	        }
	    }
	
	    public function getVersionNumber():int
	    {
	        return versionNumber;
	    }
	
	    public function getMaxComponentDepth():int
	    {
	        return maxComponentDepth;
	    }
	
	    public function getMaxComponentElements():int
	    {
	        return maxComponentElements;
	    }
	
	    public function getMaxCompositeContours():int
	    {
	        return maxCompositeContours;
	    }
	
	    public function getMaxCompositePoints():int {
	        return maxCompositePoints;
	    }
	
	    public function getMaxContours():int
	    {
	        return maxContours;
	    }
	
	    public function getMaxFunctionDefs():int
	    {
	        return maxFunctionDefs;
	    }
	
	    public function getMaxInstructionDefs():int
	    {
	        return maxInstructionDefs;
	    }
	
	    public function getMaxPoints():int
	    {
	        return maxPoints;
	    }
	
	    public function getMaxSizeOfInstructions():int
	    {
	        return maxSizeOfInstructions;
	    }
	
	    public function getMaxStackElements():int
	    {
	        return maxStackElements;
	    }
	
	    public function getMaxStorage():int
	    {
	        return maxStorage;
	    }
	
	    public function getMaxTwilightPoints():int
	    {
	        return maxTwilightPoints;
	    }
	
	    public function getMaxZones():int
	    {
	        return maxZones;
	    }
	
	    public function getNumGlyphs():int
	    {
	        return numGlyphs;
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        sb.append("'maxp' Table - Maximum Profile\n------------------------------")
	            .append("\n        'maxp' version:         ").append(Fixed.floatValue(versionNumber))
	            .append("\n        numGlyphs:              ").append(numGlyphs);
	        if (versionNumber == 0x00010000) {
	            sb.append("\n        maxPoints:              ").append(maxPoints)
	                .append("\n        maxContours:            ").append(maxContours)
	                .append("\n        maxCompositePoints:     ").append(maxCompositePoints)
	                .append("\n        maxCompositeContours:   ").append(maxCompositeContours)
	                .append("\n        maxZones:               ").append(maxZones)
	                .append("\n        maxTwilightPoints:      ").append(maxTwilightPoints)
	                .append("\n        maxStorage:             ").append(maxStorage)
	                .append("\n        maxFunctionDefs:        ").append(maxFunctionDefs)
	                .append("\n        maxInstructionDefs:     ").append(maxInstructionDefs)
	                .append("\n        maxStackElements:       ").append(maxStackElements)
	                .append("\n        maxSizeOfInstructions:  ").append(maxSizeOfInstructions)
	                .append("\n        maxComponentElements:   ").append(maxComponentElements)
	                .append("\n        maxComponentDepth:      ").append(maxComponentDepth);
	        } else {
	            sb.append("\n");
	        }
	        return sb.toString();
	    }
	}
}