package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class GlyfCompositeComp
	{
	    public static const ARG_1_AND_2_ARE_WORDS:int    = 0x0001;
	    public static const ARGS_ARE_XY_VALUES:int       = 0x0002;
	    public static const ROUND_XY_TO_GRID:int         = 0x0004;
	    public static const WE_HAVE_A_SCALE:int          = 0x0008;
	    public static const MORE_COMPONENTS:int          = 0x0020;
	    public static const WE_HAVE_AN_X_AND_Y_SCALE:int = 0x0040;
	    public static const WE_HAVE_A_TWO_BY_TWO:int     = 0x0080;
	    public static const WE_HAVE_INSTRUCTIONS:int     = 0x0100;
	    public static const USE_MY_METRICS:int           = 0x0200;
	
	    private var _firstIndex:int;
	    private var _firstContour:int;
	    private var _argument1:int;
	    private var _argument2:int;
	    private var _flags:int;
	    private var _glyphIndex:int;
	    private var _xscale:Number = 1.0;
	    private var _yscale:Number = 1.0;
	    private var _scale01:Number = 0.0;
	    private var _scale10:Number = 0.0;
	    private var _xtranslate:int = 0;
	    private var _ytranslate:int = 0;
	    private var _point1:int = 0;
	    private var _point2:int = 0;
	
	    /**
	     * 
	     * @param firstIndex
	     * @param firstContour
	     * @param di
	     * @throws IOError
	     */
	    public function GlyfCompositeComp( firstIndex:int, firstContour:int, di:ByteArray):void
	    {
	        _firstIndex   = firstIndex;
	        _firstContour = firstContour;
	        _flags        = di.readShort();
	        _glyphIndex   = di.readShort();
	
	        if ((_flags & ARG_1_AND_2_ARE_WORDS) != 0)
	        {
	            _argument1 = di.readShort();
	            _argument2 = di.readShort();
	        } else
	        {
	            _argument1 = di.readByte();
	            _argument2 = di.readByte();
	        }
	
	        if ((_flags & ARGS_ARE_XY_VALUES) != 0)
	        {
	            _xtranslate = _argument1;
	            _ytranslate = _argument2;
	        } else 
	        {
	            _point1 = _argument1;
	            _point2 = _argument2;
	        }
	
			var i:int;
	        if ((_flags & WE_HAVE_A_SCALE) != 0)
	        {
	            i = di.readShort();
	            _xscale = _yscale = Number(i) / 0x4000;
	        } else if ((_flags & WE_HAVE_AN_X_AND_Y_SCALE) != 0) {
	            i       = di.readShort();
	            _xscale = Number(i) / 0x4000;
	            i       = di.readShort();
	            _yscale = Number(i) / 0x4000;
	        } else if ((_flags & WE_HAVE_A_TWO_BY_TWO) != 0) {
	            i = di.readShort();
	            _xscale = Number(i) / 0x4000;
	            i = di.readShort();
	            _scale01 = Number(i) / 0x4000;
	            i = di.readShort();
	            _scale10 = Number(i) / 0x4000;
	            i = di.readShort();
	            _yscale = Number(i) / 0x4000;
	        }
	    }
	
	    public function getFirstIndex():int
	    {
	        return _firstIndex;
	    }
	
	    public function getFirstContour():int
	    {
	        return _firstContour;
	    }
	
	    public function getArgument1():int
	    {
	        return _argument1;
	    }
	
	    public function getArgument2():int
	    {
	        return _argument2;
	    }
	
	    public function getFlags():int
	    {
	        return _flags;
	    }
	
	    public function getGlyphIndex():int
	    {
	        return _glyphIndex;
	    }
	
	    public function getScale01():Number
	    {
	        return _scale01;
	    }
	
	    public function getScale10():Number
	    {
	        return _scale10;
	    }
	
	    public function getXScale():Number
	    {
	        return _xscale;
	    }
	
	    public function getYScale():Number
	    {
	        return _yscale;
	    }
	
	    public function getXTranslate():int
	    {
	        return _xtranslate;
	    }
	
	    public function getYTranslate():int
	    {
	        return _ytranslate;
	    }
	
	    /**
	     * Transforms an x-coordinate of a point for this component.
	     * @param x The x-coordinate of the point to transform
	     * @param y The y-coordinate of the point to transform
	     * @return The transformed x-coordinate
	     */
	    public function scaleX( x:int, y:int ):int
	    {
	        return int(Number(x) * _xscale + Number(y) * _scale10);
	    }
	
	    /**
	     * Transforms a y-coordinate of a point for this component.
	     * @param x The x-coordinate of the point to transform
	     * @param y The y-coordinate of the point to transform
	     * @return The transformed y-coordinate
	     */
	    public function scaleY( x:int, y:int ):int
	    {
	        return int(Number(x) * _scale01 + Number(y) * _yscale);
	    }
	}
}