package org.sepy.fontreader.table
{
	import flash.errors.IOError;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	public class GlyfCompositeDescript extends GlyfDescript
	{
		private var _components:Array = new Array();		// GlyfCompositeComp ( ArrayList<GlyfCompositeComp> )
		
	    public function GlyfCompositeDescript( parentTable:GlyfTable, glyphIndex:int, di:ByteArray ):void
	    {
	        super(parentTable, glyphIndex, int(-1), di);
	        // Get all of the composite components
	        var comp:GlyfCompositeComp;
	        
	        var firstIndex:int   = 0;
	        var firstContour:int = 0;
	        
	        try 
	        {
	            do 
	            {
	                _components.push(comp = new GlyfCompositeComp(firstIndex, firstContour, di));
	                var desc:GlyfDescript = parentTable.getDescription(comp.getGlyphIndex());
	                if (desc != null) 
	                {
	                    firstIndex   += desc.getPointCount();
	                    firstContour += desc.getContourCount();
	                }
	            } while ((comp.getFlags() & GlyfCompositeComp.MORE_COMPONENTS) != 0);
	
	            // Are there hinting intructions to read?
	            if ((comp.getFlags() & GlyfCompositeComp.WE_HAVE_INSTRUCTIONS) != 0) 
	            {
	                readInstructions(di, di.readShort());
	            }
	            
	        } catch (e:IOError) {
	            throw e;
	        }
	    }
	
	    override public function getEndPtOfContours( i:int ):int
	    {
	        var c:GlyfCompositeComp = getCompositeCompEndPt(i);
	        if (c != null) 
	        {
	            var gd:IGlyphDescription = _parentTable.getDescription(c.getGlyphIndex());
	            return gd.getEndPtOfContours(i - c.getFirstContour()) + c.getFirstIndex();
	        }
	        return 0;
	    }
	

	    override public function getFlags( i:int ):int
	    {
	        var c:GlyfCompositeComp = getCompositeComp(i);
	        if (c != null) 
	        {
	            var gd:IGlyphDescription = _parentTable.getDescription(c.getGlyphIndex());
	            return gd.getFlags(i - c.getFirstIndex());
	        }
	        return 0;
	    }
	
	    override public function getXCoordinate( i:int ):int
	    {
	        var c:GlyfCompositeComp = getCompositeComp(i);
	        if (c != null) 
	        {
	            var gd:IGlyphDescription = _parentTable.getDescription(c.getGlyphIndex());
	            var n:int = i - c.getFirstIndex();
	            var x:int = gd.getXCoordinate(n);
	            var y:int = gd.getYCoordinate(n);
	            var x1:int = c.scaleX(x, y);
	            
	            x1 += c.getXTranslate();
	            return x1;
	        }
	        return 0;
	    }
	
	    override public function getYCoordinate( i:int ):int
	    {
	        var c:GlyfCompositeComp = getCompositeComp(i);
	        if (c != null) 
	        {
	            var gd:IGlyphDescription = _parentTable.getDescription(c.getGlyphIndex());
	            var n:int = i - c.getFirstIndex();
	            var x:int = gd.getXCoordinate(n);
	            var y:int = gd.getYCoordinate(n);
	            var y1:int = c.scaleY(x, y);
	            y1 += c.getYTranslate();
	            return y1;
	        }
	        return 0;
	    }
	
	    override public function isComposite():Boolean
	    {
	        return true;
	    }
	
	    override public function getPointCount():int
	    {
	        var c:GlyfCompositeComp = GlyfCompositeComp(_components[_components.length - 1]);
	        var gd:IGlyphDescription = _parentTable.getDescription(c.getGlyphIndex());
	        if (gd != null) 
	        {
	            return c.getFirstIndex() + gd.getPointCount();
	        } else {
	            return 0;
	        }
	    }
	
	    override public function getContourCount():int
	    {
	        var c:GlyfCompositeComp = GlyfCompositeComp(_components[_components.length - 1]);
	        return c.getFirstContour() + _parentTable.getDescription(c.getGlyphIndex()).getContourCount();
	    }
	
	    public function getComponentIndex( i:int ):int
	    {
	        return  GlyfCompositeComp(_components[i]).getFirstIndex();
	    }
	
	    public function getComponentCount():int
	    {
	        return _components.length;
	    }
	
	    public function getComponent( i:int ):GlyfCompositeComp
	    {
	        return GlyfCompositeComp(_components[i]);
	    }
	

	    internal function getCompositeComp( i:int ):GlyfCompositeComp
	    {
	        var c:GlyfCompositeComp;
	        for (var n:int = 0; n < _components.length; n++)
	        {
	            c = GlyfCompositeComp(_components[n]);
	            var gd:IGlyphDescription = _parentTable.getDescription(c.getGlyphIndex());
	            if (c.getFirstIndex() <= i && i < (c.getFirstIndex() + gd.getPointCount()))
	            {
	                return c;
	            }
	        }
	        return null;
	    }
	
	    internal function getCompositeCompEndPt( i:int ):GlyfCompositeComp
	    {
	        var c:GlyfCompositeComp;
	        for (var j:int = 0; j < _components.length; j++)
	        {
	            c = GlyfCompositeComp(_components[j]);
	            var gd:IGlyphDescription = _parentTable.getDescription(c.getGlyphIndex());
	            if (c.getFirstContour() <= i && i < (c.getFirstContour() + gd.getContourCount()))
	            {
	                return c;
	            }
	        }
	        return null;
	    }
	}
}