package fox
{
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.tags.TagDefineFont2;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	import com.codeazur.as3swf.tags.TagFrameLabel;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	import com.codeazur.as3swf.timeline.Frame;
	import com.codeazur.as3swf.timeline.Scene;

	import flash.utils.ByteArray;

	public class SwfBuilder
	{
		public static const FONT_CLASS_NAME_PERFIX:String="FONT";
		private static var MAGIC_BYTE_HEX:String='10002e0000000011074c4955484f4e470039493a5c70353433313635343132335c78685f70686f746f5c666f6e74636f6e766572746f72546573745c7372633b3b4c4955484f4e472e61730568656c6c6f3348692074686572652c206e69636520746f206d65657420796f752120476c616420796f752063616e2072656164206d65203a290f4c4955484f4e472f4c4955484f4e470a666c6173682e7465787404466f6e74064f626a6563741c5f5f676f5f746f5f63746f725f646566696e6974696f6e5f68656c700466696c6538493a5c70353433313635343132335c78685f70686f746f5c666f6e74636f6e766572746f72546573745c7372635c4c4955484f4e472e617303706f73023939175f5f676f5f746f5f646566696e6974696f6e5f68656c70023535050501160216071801000407020107030807020903000002000000060000000200020a020b0d0c0e0f020b0d0c10010102090400010000000102010144010002000103000101040503d030470000010102050619f103f007d030ef0104000af009d049002c05f00a85d5f00b470000020201010421d030f103f00565005d036603305d026602305d02660258001d1d6801f103f003470000';

		public function SwfBuilder()
		{
		}

		protected function hex2bytes(str:String):ByteArray
		{
			var ba:ByteArray=new ByteArray();
			var length:uint=str.length;
			for (var i:uint=0; i < length; i+=2)
			{
				var hexByte:String=str.substr(i, 2);
				var byte:uint=parseInt(hexByte, 16);
				ba.writeByte(byte);
			}
			ba.position=0;
			return ba;
		}

		protected function bytes2hex(bytes:ByteArray):String
		{
			var hexs:String="";
			while (bytes.bytesAvailable)
			{
				var hex:String=bytes.readUnsignedByte().toString(16);
				while (hex.length != 2)
				{
					hex="0" + hex;
				}
				hexs+=hex;
			}
			return hexs;
		}

		protected function string2hex(str:String):String
		{
			var ba:ByteArray=new ByteArray();
			ba.writeUTFBytes(str);
			ba.position=0;
			return bytes2hex(ba);
		}

		private function getMagicBytes(name:String):ByteArray
		{
			var magic:String=MAGIC_BYTE_HEX.replace(/4c4955484f4e47/g, string2hex(name));
			return hex2bytes(magic);
		}


		public function builderFontSwf(tags:Array):ByteArray
		{

			var frameName:String="LHW1987654@GMAIL.COM";

			var swfTemp:SWF=new SWF();
			swfTemp.tags.push(new TagFileAttributes());

			var tagf:TagFrameLabel=new TagFrameLabel();
			tagf.frameName=frameName;
			swfTemp.tags.push(tagf);

			var tsc:TagSymbolClass=new TagSymbolClass();


			var f:Frame=new Frame();

			var len:int=tags.length;
			for (var i:int=1; i <= len; i++)
			{
				var fongtag:TagDefineFont2=tags[i - 1];
				fongtag.characterId=i;
				var fontdata:SWFData=new SWFData();
				fongtag.publish(fontdata, 10);
				fontdata.position=0;
				
				var name:String=i.toString();
				while (name.length < 3)
				{
					name="0" + name;
				}
				name=FONT_CLASS_NAME_PERFIX + name;

				//abc
				var abc:TagDoABC=new TagDoABC();
				abc.lazyInitializeFlag=false;
				abc.bytes.writeBytes(getMagicBytes(name));
				swfTemp.tags.push(abc);

				//font
				swfTemp.tags.push(fongtag);

				//font to abc
				var sy:SWFSymbol=new SWFSymbol();
				sy.name=name;
				sy.tagId=i;
				tsc.symbols.push(sy);
				f.characters.push(i);
			}

			swfTemp.tags.push(tsc);

			//show
			swfTemp.tags.push(new TagShowFrame());

			//end
			swfTemp.tags.push(new TagEnd());
			swfTemp.scenes.push(new Scene(0, frameName));

			swfTemp.frames.push(f);

			// Publish the generated SWF
			var swfdata:ByteArray=new ByteArray();
			swfTemp.publish(swfdata);

			return swfdata;
		}
	}
}