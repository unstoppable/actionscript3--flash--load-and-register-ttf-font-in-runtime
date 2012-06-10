/*
*
* Copyright (c) 2011-2011 Liu
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
package fox.shape
{
	import com.codeazur.as3swf.data.SWFKerningRecord;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.tags.TagDefineFont2;


	import org.sepy.fontreader.TFont;
	import org.sepy.fontreader.geom.GlyphPoint;
	import org.sepy.fontreader.table.CmapFormat;
	import org.sepy.fontreader.table.GlyfDescript;
	import org.sepy.fontreader.table.GlyfTable;
	import org.sepy.fontreader.table.HeadTable;
	import org.sepy.fontreader.table.HmtxTable;
	import org.sepy.fontreader.table.ID;
	import org.sepy.fontreader.table.KernSubtable;
	import org.sepy.fontreader.table.KernTable;
	import org.sepy.fontreader.table.KerningPair;
	import org.sepy.fontreader.table.NameRecord;
	import org.sepy.fontreader.table.NameTable;
	import org.sepy.fontreader.table.Table;

	public class TTF2FFT
	{
		private static const HAS_LAYOUT:int=0x0080;
		private static const ITALIC:int=0x0002;
		private static const BOLD:int=0x0001;
		private static const ANSI:int=0x0010;
		private static const UNICODE:int=0x0020;
		private static const WIDE_CODES:int=0x0004;
		private static const WIDE_OFFSETS:int=0x0008;

		private static const TAG_END:int=0;
		private static const TAG_DEFINEFONT2:int=48;
		//private static final FixedTag END_TAG = new FixedTag(TAG_END);
		private static const LFC_TMARK:int=160;

		/** Units per EmSquare for FFTs */
		private static const FFT_UnitsPerEm:int=1024;

		public static function convert(ttf:TFont):TagDefineFont2
		{

			var fontTag:TagDefineFont2=new TagDefineFont2();
			fontTag.characterId=1;

			var nameTable:NameTable=ttf.getNameTable();
			var nameRecord:NameRecord=nameTable.getRecord(1);
			fontTag.fontName=nameRecord.getRecordString();

			var headTable:HeadTable=ttf.getHeadTable();
			var hmtxTable:HmtxTable=ttf.getHmtxTable();

			if (headTable == null)
			{
				// Bitmap fonts aren't required to have the head table.
				// We don't support them yet. XXX
				throw new Error("missing ttf head table; this ttf font not supported");
			}

			if (hmtxTable == null)
			{
				throw new Error("missing ttf hmtx (horiz. metrics) table; this ttf font not supported");
			}

			// Is font bold, italic, or bold-italic?
			var macStyle:int=headTable.getMacStyle();
			fontTag.bold=(macStyle & 0x1) != 0;
			fontTag.italic=(macStyle & 0x2) != 0;
			fontTag.hasLayout=true;

			var isUnicode:Boolean=false;

			// We have font metric info for the ttf

			const maxCodes:int=0xffff;
			var numCodes:int=0;

			var indexTable:Vector.<uint>=new Vector.<uint>();
			var maxCode:int=0;

			// Add Code 0 (not sure why this is needed. Probably some lfc reason
			fontTag.codeTable[0]=0;
			indexTable[0]=0;
			numCodes=1;

			// 3 tries
			const NUM_TRIES:int=3;
			var cmapPlats:Array=[ID.platformMicrosoft, ID.platformMacintosh, ID.platformMicrosoft];

			var cmapEncodes:Array=[ID.encodingUnicode, ID.encodingRoman, ID.encodingSymbol];

			var cmapIsUnicode:Array=[true, false, false];

			var tries:int=0;

			var cmapFmt:CmapFormat=null;
			var hasTmark:Boolean=false;
			var spaceIndex:int=0;

			for (var t:int=0; t < NUM_TRIES; t++)
			{

				cmapFmt=ttf.getCmapTable().getCmapFormat(cmapPlats[t], cmapEncodes[t]);
				// Find char codes
				if (cmapFmt != null)
				{
					for (var ch:int=0; ch < 0xffff; ch++)
					{
						var index:int=cmapFmt.mapCharCode(ch);

						if (ch == 32)
						{
							spaceIndex=index;
						}

						if (index != 0)
						{
							if (ch == LFC_TMARK)
							{
								hasTmark=true;
							}
							fontTag.codeTable[numCodes]=ch;
							indexTable[numCodes]=index;
							numCodes++;
							if (ch > maxCode)
							{
								maxCode=ch;
							}
						}
					}
				}
				if (numCodes > 1)
				{
					break;
				}
				isUnicode=cmapIsUnicode[t];
			}

			if (cmapFmt == null)
			{
				throw new Error("Can't find a cmap table in this font");
			}

			if (!hasTmark)
			{
				if (LFC_TMARK > maxCode)
				{
					maxCode=LFC_TMARK;
				}

				fontTag.codeTable[numCodes]=LFC_TMARK;
				indexTable[numCodes]=spaceIndex;
				numCodes++;
			}

			fontTag.ansi=!isUnicode;
			fontTag.wideCodes=(maxCode > 255);

			var glyfTable:GlyfTable=GlyfTable(ttf.getTable(Table.glyf));

			var numGlyphs:int=numCodes;

			var unitsPerEm:int=headTable.getUnitsPerEm();
			var factor:Number=FFT_UnitsPerEm / unitsPerEm;

			// Get glyph shapes, and bounds.
			for (var i:int=0; i < numGlyphs; i++)
			{
				var code:int=fontTag.codeTable[i];
				var glyf:GlyfDescript=glyfTable.getDescription(indexTable[i]);
				var glyph:TTFGlyph=null;

				if (glyf != null)
				{
					glyph=new TTFGlyph(glyf);
					glyph.scale(factor);
				}
				else
				{
				}

				var shape:FoxShape=new FoxShape();
				convertGlyphToShape(glyph, shape);
				fontTag.glyphShapeTable.push(shape);

				var rect:SWFRectangle=new SWFRectangle();

				var x:int;
				var w:int;
				var y:int;
				var h:int;

				if (glyf != null)
				{
					rect.xmin=Math.round(glyf.getXMinimum() * factor);
					rect.ymin=int(glyf.getYMaximum() * -factor);

					rect.xmax=int(glyf.getXMaximum() * factor);
					rect.ymax=Math.round(glyf.getYMinimum() * factor);
				}
				else
				{
					rect.xmin=0;
					rect.ymin=0;
					rect.ymax=0;
					rect.xmax=0;

					// Heuristic that hopefully works out ok for
					// missing glyfs. First try space. Then try index0
					glyf=glyfTable.getDescription(spaceIndex);
					if (glyf == null)
					{
						glyf=glyfTable.getDescription(0);
					}
					if (glyf != null)
					{
						rect.xmax=Math.round(glyf.getXMaximum() * factor);
					}

				}
				fontTag.fontBoundsTable.push(rect);
			}

			fontTag.wideOffsets=true;
			// Write ascent, descent, (external) leading
			fontTag.ascent=Math.round((ttf.getAscent() * factor));
			fontTag.descent=Math.round((ttf.getDescent() * -factor));
			fontTag.leading=fontTag.ascent + fontTag.descent - FFT_UnitsPerEm;


			///////////////////////////////////////////////////////////////////////// Write advance table
			for (i=0; i < numCodes; i++)
			{
				var _index:int=indexTable[i];
				fontTag.fontAdvanceTable.push(Math.round(hmtxTable.getAdvanceWidth(_index) * factor));
			}

			/////////////////////////////////////////////////////////////////////// Write kerning tables
			var nKern:int=0;
			var kernTable:KernTable=KernTable(ttf.getTable(Table.kern));
			var doKern:Boolean=true;

			if (kernTable != null)
			{
				if (doKern)
				{
					var kst:KernSubtable=kernTable.getSubtable(0);
					if (kst)
					{
						nKern=kst.getKerningPairCount();
						var goodKern:int=nKern;
						for (i=0; i < nKern; i++)
						{
							if (kst.getKerningPair(i).value == 0)
							{
								goodKern--;
							}
						}
						for (i=0; i < nKern; i++)
						{
							var pair:KerningPair=kst.getKerningPair(i);

							if (pair.value != 0)
							{
								var skr:SWFKerningRecord=new SWFKerningRecord();
								skr.code1=fontTag.codeTable[pair.left];
								skr.code2=fontTag.codeTable[pair.right];
								skr.adjustment=Math.round(pair.value * factor);
								fontTag.fontKerningTable.push(skr);
							}
						}
					}
				}
			}
			return fontTag;
		}

		private static function convertGlyphToShape(glyph:TTFGlyph, shape:FoxShape):void
		{

			if (glyph == null)
			{
				return;
			}
			var firstIndex:int=0;
			var count:int=0;

			// Add each contour to the shape.
			for (var i:int=0; i < glyph.getNumPoints(); i++)
			{
				count++;
				if (glyph.getPoint(i).endOfContour)
				{
					addContourToShape(shape, glyph, firstIndex, count);
					firstIndex=i + 1;
					count=0;
				}
			}
		}

		private static function addContourToShape(shape:FoxShape, glyph:TTFGlyph, startIndex:int, count:int):void
		{

			// If this is a single point on it's own, we can't do anything with it
			if (glyph.getPoint(startIndex).endOfContour)
			{
				return;
			}

			var offset:int=0;

			while (offset < count)
			{
				var p0:GlyphPoint=glyph.getPoint(startIndex + offset % count);
				var p1:GlyphPoint=glyph.getPoint(startIndex + (offset + 1) % count);

				if (offset == 0)
				{
					shape.movePenTo(p0.x, p0.y);
					if (startIndex == 0)
					{
						var scr:StyleChangeRecord=new StyleChangeRecord();
						scr.setFlags(StyleChangeRecord.FILLSTYLE1 | StyleChangeRecord.LINESTYLE);
						scr.setFillStyle1(1);
						scr.setLineStyle(0);
						shape.records.push(scr);
					}
				}

				if (p0.onCurve)
				{
					if (p1.onCurve)
					{
						shape.drawLineTo(p1.x, p1.y);
						offset++;
					}
					else
					{
						var p2:GlyphPoint=glyph.getPoint(startIndex + (offset + 2) % count);

						if (p2.onCurve)
						{
							shape.drawCurveTo(p1.x, p1.y, p2.x, p2.y);
						}
						else
						{
							shape.drawCurveTo(p1.x, p1.y, midValue(p1.x, p2.x), midValue(p1.y, p2.y));
						}
						offset+=2;
					}
				}
				else
				{
					if (!p1.onCurve)
					{
						shape.drawCurveTo(p0.x, p0.y, midValue(p0.x, p1.x), midValue(p0.y, p1.y));
					}
					else
					{
						shape.drawCurveTo(p0.x, p0.y, p1.x, p1.y);
					}
					offset++;
				}
			}
		}

		private static function midValue(a:int, b:int):int
		{
			return (a + b) / 2;
		}
	}
}
