package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.TFont;
	import org.sepy.fontreader.TFontCollection;
	

	public class TableFactory 
	{
	
	    public static function create(fc:TFontCollection, font:TFont, de:DirectoryEntry, dis:ByteArray):Table
	    {
	        var t:Table = null;
	        if (fc != null) 
	        {
	            t = fc.getTable(de);
	            if (t != null) 
	            {
	                return t;
	            }
	        }
	        
	        var tag:int = de.tag;
	        
	        //trace('** [TAG]: ' + tag, dis.bytesAvailable);
	        
	        // Create the table
	        switch (tag) 
	        {
		        case Table.BASE:
		            t = new BaseTable(de, dis);
		            break;
		        case Table.CFF:
		            //t = new CffTable(de, dis);
		            break;
		        case Table.DSIG:
		            t = new DsigTable(de, dis);
		            break;
		        case Table.EBDT:
		            break;
		        case Table.EBLC:
		            break;
		        case Table.EBSC:
		            break;
		        case Table.GDEF:
		            break;
		        case Table.GPOS:
		            //t = new GposTable(de, dis);
		            break;
		        case Table.GSUB:
		            t = new GsubTable(de, dis);
		            break;
		        case Table.JSTF:
		            break;
		        case Table.LTSH:
		            t = new LtshTable(de, dis);
		            break;
		        case Table.MMFX:
		            break;
		        case Table.MMSD:
		            break;
		        case Table.OS_2:
		            t = new Os2Table(de, dis);
		            break;
		        case Table.PCLT:
		            t = new PcltTable(de, dis);
		            break;
		        case Table.VDMX:
		            t = new VdmxTable(de, dis);
		            break;
		        case Table.cmap:
		            t = new CmapTable(de, dis);
		            break;
		        case Table.cvt:
		            t = new CvtTable(de, dis);
		            break;
		        case Table.fpgm:
		            t = new FpgmTable(de, dis);
		            break;
		        case Table.fvar:
		            break;
		        case Table.gasp:
		            t = new GaspTable(de, dis);
		            break;
		        case Table.glyf:
		            t = new GlyfTable(de, dis, font.getMaxpTable(), font.getLocaTable());
		            break;
		        case Table.hdmx:
		            t = new HdmxTable(de, dis, font.getMaxpTable());
		            break;
		        case Table.head:
		            t = new HeadTable(de, dis);
		            break;
		        case Table.hhea:
		            t = new HheaTable(de, dis);
		            break;
		        case Table.hmtx:
		            t = new HmtxTable(de, dis, font.getHheaTable(), font.getMaxpTable());
		            break;
		        case Table.kern:
		            t = new KernTable(de, dis);
		            break;
		        case Table.loca:
		            t = new LocaTable(de, dis, font.getHeadTable(), font.getMaxpTable());
		            break;
		        case Table.maxp:
		            t = new MaxpTable(de, dis);
		            break;
		        case Table.name:
		            t = new NameTable(de, dis);
		            break;
		        case Table.prep:
		            t = new PrepTable(de, dis);
		            break;
		        case Table.post:
		            t = new PostTable(de, dis);
		            break;
		        case Table.vhea:
		            t = new VheaTable(de, dis);
		            break;
		        case Table.vmtx:
		            t = new VmtxTable(de, dis, font.getVheaTable(), font.getMaxpTable());
		            break;
	        }
	        
	        // If we have a font collection, add this table to it
	        if ((fc != null) && (t != null)) {
	            fc.addTable(t);
	        }
	        return t;
	    }
	}

}