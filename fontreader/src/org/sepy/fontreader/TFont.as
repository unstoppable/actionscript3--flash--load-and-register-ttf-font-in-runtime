/*
 * 
 * Flash FontReader is a porting of the Typecast Java software
 *
 * Typecast - The Font Development Environment
 * Copyright (c) 2004-2007 David Schweinsberg
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.sepy.fontreader
{
	import flash.utils.ByteArray;
	
	import org.sepy.fontreader.table.CmapTable;
	import org.sepy.fontreader.table.DirectoryEntry;
	import org.sepy.fontreader.table.GlyfTable;
	import org.sepy.fontreader.table.HeadTable;
	import org.sepy.fontreader.table.HheaTable;
	import org.sepy.fontreader.table.HmtxTable;
	import org.sepy.fontreader.table.LocaTable;
	import org.sepy.fontreader.table.MaxpTable;
	import org.sepy.fontreader.table.NameTable;
	import org.sepy.fontreader.table.Os2Table;
	import org.sepy.fontreader.table.PostTable;
	import org.sepy.fontreader.table.Table;
	import org.sepy.fontreader.table.TableDirectory;
	import org.sepy.fontreader.table.TableFactory;
	import org.sepy.fontreader.table.VheaTable;
	import org.sepy.fontreader.geom.Glyph;
	
	public class TFont
	{
		private var _fc:TFontCollection;
		private var _tableDirectory:TableDirectory;
		private var _tables:Array;						// Table[]
		private var _head:HeadTable;
		private var _hhea:HheaTable;
		private var _maxp:MaxpTable;
		private var _loca:LocaTable;
		private var _vhea:VheaTable;
		private var _os2:Os2Table;
		private var _cmap:CmapTable;
		private var _glyf:GlyfTable;
		private var _hmtx:HmtxTable;
		private var _name:NameTable;
		private var _post:PostTable;
		
		public function TFont(fc:TFontCollection):void
		{
			_fc = fc;
		}
		
	    public function getTable( tableType:int ):Table
	    {
	        for (var i:int = 0; i < _tables.length; i++)
	        {
	            if ((_tables[i] != null) && (Table(_tables[i]).type == tableType))
	            {
	                return Table(_tables[i]);
	            }
	        }
	        return null;
	    }
	    
	    public function getOS2Table():Os2Table
	    {
	        return _os2;
	    }	    
		
    	public function getHheaTable():HheaTable
    	{
        	return _hhea;
	    }
	    
	    public function getHeadTable():HeadTable
	    {
	    	return _head;
	    }
	    
	    public function getMaxpTable():MaxpTable
	    {
	    	return _maxp;
	    }
	    
	    public function getLocaTable():LocaTable
	    {
	    	return _loca;
	    }
	    
	    public function getVheaTable():VheaTable
	    {
	    	return _vhea;
	    }
	    
    	public function getCmapTable():CmapTable 
    	{
        	return _cmap;
	    }
	    
	    public function getNameTable():NameTable
	    {
	    	return _name;
	    }
	    
	    public function getHmtxTable():HmtxTable
	    {
	    	return _hmtx;
	    }
	    
	    public function getAscent():int 
	    {
	        return _hhea.getAscender();
	    }
	
	    public function getDescent():int
	    {
	        return _hhea.getDescender();
	    }
	
	    public function getNumGlyphs():int
	    {
	        return _maxp.getNumGlyphs();
	    }
	    
	    public function getGlyph( i:int ):Glyph
	    {
	        return (_glyf.getDescription(i) != null) ? new Glyph( _glyf.getDescription(i), _hmtx.getLeftSideBearing(i), _hmtx.getAdvanceWidth(i)) : null;
	    }	    
	    
    	public function getTableDirectory():TableDirectory 
    	{
        	return _tableDirectory;
    	}
		
		private function readTable(dis:ByteArray, tablesOrigin:int, tag:int):Table
		{
	    	dis.position = 0;
	        var entry:DirectoryEntry = _tableDirectory.getEntryByTag(tag);
	        if (entry == null) 
	            return null;

	        dis.position += tablesOrigin + entry.offset;
	        return TableFactory.create(_fc, this, entry, dis);
	    }
	        
		
		/**
	     * @param dis OpenType/TrueType font file data.
	     * @param directoryOffset The Table Directory offset within the file.  For a
	     * regular TTF/OTF file this will be zero, but for a TTC (Font Collection)
	     * the offset is retrieved from the TTC header.  For a Mac font resource,
	     * offset is retrieved from the resource headers.
	     * @param tablesOrigin The point the table offsets are calculated from.
	     * Once again, in a regular TTF file, this will be zero.  In a TTC is is
	     * also zero, but within a Mac resource, it is the beggining of the
	     * individual font resource data.
	     */
		public function read( input:ByteArray, directoryOffset:int, tablesOrigin:int):void
		{
			input.position += directoryOffset;
			_tableDirectory = new TableDirectory( input );
			_tables = new Array(_tableDirectory.getNumTables());
			
			_head = HeadTable(readTable(input, tablesOrigin, Table.head));
			_hhea = HheaTable(readTable(input, tablesOrigin, Table.hhea));
			_maxp = MaxpTable(readTable(input, tablesOrigin, Table.maxp));
			_loca = LocaTable(readTable(input, tablesOrigin, Table.loca));
			_vhea = VheaTable(readTable(input, tablesOrigin, Table.vhea));
			
	        var index:uint = 0;
	        _tables[index++] = _head;
	        _tables[index++] = _hhea;
	        _tables[index++] = _maxp;
	        if (_loca != null)
	            _tables[index++] = _loca;

	        if (_vhea != null)
	            _tables[index++] = _vhea;
			
			// Load all other tables
	        for (var i:uint = 0; i < _tableDirectory.getNumTables(); i++) {
	            var entry:DirectoryEntry = _tableDirectory.getEntry(i);
	            if (entry.tag == Table.head
	                    || entry.tag == Table.hhea
	                    || entry.tag == Table.maxp
	                    || entry.tag == Table.loca
	                    || entry.tag == Table.vhea) {
	                continue;
	            }
	            input.position = 0;
	            input.position += tablesOrigin + entry.offset;
	            _tables[index] = TableFactory.create(_fc, this, entry, input);
	            ++index;
	        }

	        // commonly used tables
	        _cmap = CmapTable(getTable(Table.cmap));
	        _hmtx = HmtxTable(getTable(Table.hmtx));
	        _name = NameTable(getTable(Table.name));
	        _os2  = Os2Table(getTable(Table.OS_2));
	        _post = PostTable(getTable(Table.post));
	
	        // If this is a TrueType outline, 
	        // then we'll have at least the 'glyf' table
	        _glyf = GlyfTable(getTable(Table.glyf));
		}
	}
}