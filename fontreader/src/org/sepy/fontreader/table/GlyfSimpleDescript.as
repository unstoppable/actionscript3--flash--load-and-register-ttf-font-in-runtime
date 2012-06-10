package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.exception.ArrayIndexOutOfBoundsException;
	import org.sepy.fontreader.utils.StringBuffer;
	import org.sepy.fontreader.Disassembler;
	
	public class GlyfSimpleDescript extends GlyfDescript
	{
	    private var _endPtsOfContours:Array;		// int[]
	    private var _flags:Array;					// byte[]
	    private var _xCoordinates:Array;			// short[]
	    private var _yCoordinates:Array;			// short[]
	    private var _count:int;
	
	    public function GlyfSimpleDescript( parentTable:GlyfTable, glyphIndex:int, numberOfContours:int, di:ByteArray):void
	    {
	        super(parentTable, glyphIndex, numberOfContours, di);
	        
	        _endPtsOfContours = new Array( numberOfContours );
	        
	        for (var i:uint = 0; i < numberOfContours; i++)
	        {
	            _endPtsOfContours[i] = di.readShort();
	        }
	
	        _count = _endPtsOfContours[numberOfContours-1] + 1;
	        _flags        = new Array( _count );
	        _xCoordinates = new Array( _count );
	        _yCoordinates = new Array( _count );
	
	        var instructionCount:int = di.readShort();
	        readInstructions(di, instructionCount);
	        readFlags(_count, di);
	        readCoords(_count, di);
	    }
	
	    override public function getEndPtOfContours( i:int ):int
	    {
	        return _endPtsOfContours[i];
	    }
	
	    override public function getFlags( i:int ):int
	    {
	        return _flags[i];
	    }
	
	    override public function getXCoordinate( i:int ):int
	    {
	        return _xCoordinates[i];
	    }
	
	    override public function getYCoordinate( i:int ):int
	    {
	        return _yCoordinates[i];
	    }
	
	    override public function isComposite():Boolean
	    {
	        return false;
	    }
	
	    override public function getPointCount():int
	    {
	        return _count;
	    }
	
	    override public function getContourCount():int
	    {
	        return getNumberOfContours();
	    }

	    /**
	     * The table is stored as relative values, but we'll store them as absolutes
	     */
	    internal function readCoords( count:int, di:ByteArray ):void
	    {
	        var x:int = 0;
	        var y:int = 0;
	        var i:uint;
	        
	        for (i = 0; i < count; i++)
	        {
	            if ((_flags[i] & xDual) != 0)
	            {
	                if ((_flags[i] & xShortVector) != 0)
	                {
	                    x += di.readUnsignedByte();
	                }
	            } else 
	            {
	                if ((_flags[i] & xShortVector) != 0)
	                {
	                    x += -(di.readUnsignedByte());
	                } else
	                {
	                    x += di.readShort();
	                }
	            }
	            _xCoordinates[i] = x;
	        }
	
	        for (i = 0; i < count; i++)
	        {
	            if ((_flags[i] & yDual) != 0)
	            {
	                if ((_flags[i] & yShortVector) != 0)
	                {
	                    y += di.readUnsignedByte();
	                }
	            } else
	            {
	                if ((_flags[i] & yShortVector) != 0)
	                {
	                    y += -(di.readUnsignedByte());
	                } else
	                {
	                    y += di.readShort();
	                }
	            }
	            _yCoordinates[i] = y;
	        }
	    }
	
	    /**
	     * The flags are run-length encoded
	     */
	    private function readFlags( flagCount:int, di:ByteArray):void
		{
	        try
	        {
	            for (var index:int = 0; index < flagCount; index++)
	            {
	                _flags[index] = di.readByte();
	                if ((_flags[index] & repeat) != 0)
	                {
	                    var repeats:int = di.readByte();
	                    for (var i:int = 1; i <= repeats; i++)
	                    {
	                        _flags[index + i] = _flags[index];
	                    }
	                    index += repeats;
	                }
	            }
	        } catch (e:ArrayIndexOutOfBoundsException)
	        {
	            trace("error: array index out of bounds");
	        }
	    }
	    
	    override public function toString():String
	    {
	    	var i:int;
	        var sb:StringBuffer = new StringBuffer();
	        sb.append(super.toString());
	        sb.append("\n\n        EndPoints\n        ---------");
	        
	        for (i = 0; i < _endPtsOfContours.length; i++)
	        {
	            sb.append("\n          ").append(i).append(": ").append(_endPtsOfContours[i]);
	        }
	        sb.append("\n\n          Length of Instructions: ");
	        sb.append( getInstructions().length).append("\n");
	        
	        sb.append( Disassembler.disassemble(getInstructions(), 8) );
	        sb.append("\n        Flags\n        -----");
	        
	        for (i = 0; i < _flags.length; i++)
	        {
	            sb.append("\n          ").append(i).append(":  ");
	            if ((_flags[i] & 0x20) != 0) {
	                sb.append("YDual ");
	            } else {
	                sb.append("      ");
	            }
	            if ((_flags[i] & 0x10) != 0) {
	                sb.append("XDual ");
	            } else {
	                sb.append("      ");
	            }
	            if ((_flags[i] & 0x08) != 0) {
	                sb.append("Repeat ");
	            } else {
	                sb.append("       ");
	            }
	            if ((_flags[i] & 0x04) != 0) {
	                sb.append("Y-Short ");
	            } else {
	                sb.append("        ");
	            }
	            if ((_flags[i] & 0x02) != 0) {
	                sb.append("X-Short ");
	            } else {
	                sb.append("        ");
	            }
	            if ((_flags[i] & 0x01) != 0) {
	                sb.append("On");
	            } else {
	                sb.append("  ");
	            }
	        }
	        sb.append("\n\n        Coordinates\n        -----------");
	        var oldX:int = 0;
	        var oldY:int = 0;
	        
	        for (i = 0; i < _xCoordinates.length; i++)
	        {
	            sb.append("\n          ").append(i)
	                .append(": Rel (").append(_xCoordinates[i] - oldX)
	                .append(", ").append(_yCoordinates[i] - oldY)
	                .append(")  ->  Abs (").append(_xCoordinates[i])
	                .append(", ").append(_yCoordinates[i]).append(")");
	            oldX = _xCoordinates[i];
	            oldY = _yCoordinates[i];
	        }
	        return sb.toString();
	    }
	}
}