package org.sepy.fontreader.table
{
	public class Table implements ITable
	{
		
	    // Table constants
	    public static var BASE:int = 0x42415345; // Baseline data [OpenType]
	    public static var CFF :int = 0x43464620; // PostScript font program (compact font format) [PostScript]
	    public static var DSIG:int = 0x44534947; // Digital signature
	    public static var EBDT:int = 0x45424454; // Embedded bitmap data
	    public static var EBLC:int = 0x45424c43; // Embedded bitmap location data
	    public static var EBSC:int = 0x45425343; // Embedded bitmap scaling data
	    public static var GDEF:int = 0x47444546; // Glyph definition data [OpenType]
	    public static var GPOS:int = 0x47504f53; // Glyph positioning data [OpenType]
	    public static var GSUB:int = 0x47535542; // Glyph substitution data [OpenType]
	    public static var JSTF:int = 0x4a535446; // Justification data [OpenType]
	    public static var LTSH:int = 0x4c545348; // Linear threshold table
	    public static var MMFX:int = 0x4d4d4658; // Multiple master font metrics [PostScript]
	    public static var MMSD:int = 0x4d4d5344; // Multiple master supplementary data [PostScript]
	    public static var OS_2:int = 0x4f532f32; // OS/2 and Windows specific metrics [r]
	    public static var PCLT:int = 0x50434c54; // PCL5
	    public static var VDMX:int = 0x56444d58; // Vertical Device Metrics table
	    public static var cmap:int = 0x636d6170; // character to glyph mapping [r]
	    public static var cvt :int = 0x63767420; // Control Value Table
	    public static var fpgm:int = 0x6670676d; // font program
	    public static var fvar:int = 0x66766172; // Apple's font variations table [PostScript]
	    public static var gasp:int = 0x67617370; // grid-fitting and scan conversion procedure (grayscale)
	    public static var glyf:int = 0x676c7966; // glyph data [r]
	    public static var hdmx:int = 0x68646d78; // horizontal device metrics
	    public static var head:int = 0x68656164; // font header [r]
	    public static var hhea:int = 0x68686561; // horizontal header [r]
	    public static var hmtx:int = 0x686d7478; // horizontal metrics [r]
	    public static var kern:int = 0x6b65726e; // kerning
	    public static var loca:int = 0x6c6f6361; // index to location [r]
	    public static var maxp:int = 0x6d617870; // maximum profile [r]
	    public static var name:int = 0x6e616d65; // naming table [r]
	    public static var prep:int = 0x70726570; // CVT Program
	    public static var post:int = 0x706f7374; // PostScript information [r]
	    public static var vhea:int = 0x76686561; // Vertical Metrics header
	    public static var vmtx:int = 0x766d7478; // Vertical Metrics		
		
		protected var _de:DirectoryEntry;
		protected var _type:int;
		
		virtual public function get directoryEntry():DirectoryEntry
		{
			return _de;
		}
		
		virtual public function get type():int
		{
			return _type;
		}
		
	}
}