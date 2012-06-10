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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import org.sepy.fontreader.table.DirectoryEntry;
	import org.sepy.fontreader.table.TTCHeader;
	import org.sepy.fontreader.table.Table;

	public class TFontCollection extends EventDispatcher
	{
		
		private var _bytes:ByteArray;
		private var _fonts:Array;			// Font[]
		private var _tables:Array = [];
		private var _ttcHeader:TTCHeader;
		private var _pathName:String;
		private var _fileName:String;
		
		public function TFontCollection(target:IEventDispatcher=null)
		{
			super(target);
		}
		
	    public function get pathName():String
	    {
	        return _pathName;
	    }
	
	    public function get fileName():String
	    {
	        return _fileName;
	    }		
		
	    public function getTable(de:DirectoryEntry):Table
	    {
	        for (var i:int = 0; i < _tables.length; i++) 
	        {
	            var table:Table = _tables[i];
	            if ((table.directoryEntry.tag == de.tag) && (table.directoryEntry.offset == de.offset))
	            {
	                return table;
	            }
	        }
	        return null;
	    }

    	public function getTtcHeader():TTCHeader 
    	{
        	return _ttcHeader;
    	}

    	public function addTable(table:Table):void
    	{
        	_tables.push(table);
	    }
		
	    public function getFont( i:uint ):TFont
	    {
	        return _fonts[i];
	    }
	    
	    public function getFontCount():uint
	    {
	        return _fonts.length;
	    }		
		
		/**
		 * create a new FontCollection from a font file
		 * @param file the Font file
		 * @parma pathName fontfile name
		 * @return 
		 * 
		 */
		public static function create(file:URLStream, pathName:String = "" ):TFontCollection
		{
	        var fc:TFontCollection = new TFontCollection();
    	    fc.read(file, pathName);
        	return fc;
	    }
		
		
		protected function read(file:URLStream, pathName:String = ""):void
		{
			_pathName = pathName;
			_bytes = new ByteArray();
			file.readBytes(_bytes, 0, file.bytesAvailable);
			if(TTCHeader.isTTC(_bytes))
			{
				// This is a TrueType font collection
				_bytes.position = 0;
	            _ttcHeader = new TTCHeader( _bytes );
	            _fonts = new Array( _ttcHeader.directoryCount );
	            for (var i:uint = 0; i < _ttcHeader.directoryCount; i++) 
	            {
	                _fonts[i] = new TFont(this);
	                _fonts[i].read(_bytes, _ttcHeader.getTableDirectory(i), 0);
	            }				
			} else {
				// This is a standalone font
				_bytes.position = 0;
				_fonts = new Array(1);
				_fonts[0] = new TFont(this);
				_fonts[0].read(_bytes, 0, 0);
			}
			file.close();
		}
	}
}