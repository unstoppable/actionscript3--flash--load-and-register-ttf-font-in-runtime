package
{
	import caurina.transitions.properties.ColorShortcuts;

	import fl.data.DataProvider;

	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import fox.FontEvent;
	import fox.loader.TTFLoader;

	/**
	 * @author Liu
	 *
	 * dependency:
	 * 1. FontReader, convert TrueType fonts in graphics with Flex
	 * http://www.sephiroth.it/weblog/archives/2007/07/fontreader_convert_truetype_fonts_in.php
	 * 
	 * 2. as3swf is a low level Actionscript 3 library to parse, create, modify and publish SWF files.
	 * https://github.com/claus/as3swf/tree/
	 */
	[SWF(width="590", height="360", frameRate="31", backgroundColor="#FFFFFF")]
	public class TTFLoaderTester extends Sprite
	{
		protected var URL:String="http://portfolio.raisedtech.com/wp-content/uploads/2011/fonts/";
		protected var field:TextField;
		protected var skin:Skin;
		protected var _info:String;
		protected var _loading:Boolean=false;


		public function TTFLoaderTester()
		{
			super();
			//import font
			ToolTipDesign;
			ColorShortcuts.init();
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);

			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;


			initDesign();

			updateregisteredFonts();
		}

		protected function initDesign():void
		{
			skin=new Skin();
			this.addChild(skin);
			skin.fontTest.embedFonts=true;
			skin.fontTest.text="Please \nselect \na \nfont";
			skin.fontTest.border=true;
			skin.fontTest.antiAliasType=AntiAliasType.ADVANCED;
			field=skin.fontTest;
			info="Please select a font";


			skin.fontList.dataProvider=initFonts();
			;
			skin.fontList.addEventListener(Event.CHANGE, onFontListChanged);
			skin.loadbt.addEventListener(MouseEvent.CLICK, onStartLoadFont);
			skin.fontInput.text=skin.fontList.dataProvider.getItemAt(0).label;

			skin.fonts.addEventListener(Event.CHANGE, onFontsChanged);
		}

		protected function onFontsChanged(event:Event):void
		{
			updateFontInfo(skin.fonts.selectedItem.data);
		}

		public function get loading():Boolean
		{
			return _loading;
		}

		public function set loading(value:Boolean):void
		{
			_loading=value;
			skin.loadbt.enabled != value;
			skin.loadbt.label=value ? "Loading" : "load font";
		}

		protected function onStartLoadFont(event:MouseEvent):void
		{
			loadFont(skin.fontInput.text);
		}

		public function get info():String
		{
			return _info;
		}

		public function set info(value:String):void
		{
			_info=value;
			skin.info.text=value;
		}

		protected function onFontListChanged(event:Event):void
		{
			var font:String=skin.fontList.selectedItem.data;
			skin.fontInput.text=font;
			loadFont(font);
		}

		private function loadFont(font:String):void
		{
			if (this.loading == false)
			{
				if (this.loaderInfo.url.indexOf("http") == 0)
				{
					if (font.indexOf("http") != 0)
					{
						font=URL + font;
					}
				}

				this.loading=true;
				var loader:TTFLoader=new TTFLoader();
				addLoaderEventListener(loader);
				loader.load(new URLRequest(font));
			}
		}

		protected function onFontLoadError(event:ErrorEvent):void
		{
			removeLoaderEventListener(event);
			info=event.text;
			this.loading=false;
		}

		protected function onFontLoadComplete(event:Event):void
		{
			info="Encoding font";
		}

		protected function onFontLoadProgress(event:ProgressEvent):void
		{
			info="Loading " + Math.round((event.bytesLoaded / event.bytesTotal) * 100) + "%";
		}

		protected function addLoaderEventListener(loader:EventDispatcher):void
		{
			loader.addEventListener(FontEvent.FONT_READY, onFondReady);
			loader.addEventListener(ProgressEvent.PROGRESS, onFontLoadProgress);
			loader.addEventListener(Event.COMPLETE, onFontLoadComplete);
			loader.addEventListener(ErrorEvent.ERROR, onFontLoadError);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onFontLoadError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onFontLoadError);
		}

		protected function removeLoaderEventListener(event:Event):void
		{
			var loader:TTFLoader=TTFLoader(event.target);
			loader.removeEventListener(FontEvent.FONT_READY, onFondReady);
			loader.removeEventListener(ProgressEvent.PROGRESS, onFontLoadProgress);
			loader.removeEventListener(Event.COMPLETE, onFontLoadComplete);
			loader.removeEventListener(ErrorEvent.ERROR, onFontLoadError);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onFontLoadError);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onFontLoadError);
		}


		/**
		 * @private
		 */
		private function onFondReady(event:FontEvent):void
		{
			removeLoaderEventListener(event);
			trace("handler_complete", event.target.timer);
			var FONT_CLASS:Class=event.fonts[0];

			var font:Font=new FONT_CLASS();
			Font.registerFont(FONT_CLASS);

			updateFontInfo(font, event.target.timer);
			this.loading=false;

			updateregisteredFonts();
		}

		protected function updateFontInfo(font:Font, timer:int=0):void
		{
			var text:String="fontName:" + font.fontName;
			text+="\nfontStyle:" + font.fontStyle;
			text+="\nfontType:" + font.fontType;
			text+="\ntime cost:" + timer;
			info=font.fontName + " loaded";

			this.field.embedFonts=true;
			var tf:TextFormat=new TextFormat(font.fontName, 20);

			switch (font.fontStyle)
			{
				case FontStyle.BOLD:
					tf.bold=true;
					break;
				case FontStyle.BOLD_ITALIC:
					tf.bold=true;
					tf.italic=true;
					break;
				case FontStyle.ITALIC:
					tf.italic=true;
					break;
			}

			this.field.text=text + '\n';
			this.field.setTextFormat(tf, this.field.length - text.length - 1, this.field.length);
		}

		private function updateregisteredFonts():void
		{
			var data:DataProvider=new DataProvider();
			var arr:Array=Font.enumerateFonts();
			for each (var i:Font in arr)
			{
				data.addItem({label: i.fontName, data: i});
			}

			skin.fonts.dataProvider=data;

		}

		private function initFonts():DataProvider
		{

			var dataProvider:DataProvider=new DataProvider();


			//dataProvider.addItem({label: "../fonts/HELVE6.TTF", data: "../fonts/HELVE6.TTF"});

			//dataProvider.addItem({label: "../fonts/NeoSans.otf", data: "../fonts/NeoSans.otf"});

			dataProvider.addItem({label: "../fonts/HARLOWSI.TTF", data: "../fonts/HARLOWSI.TTF"});

			dataProvider.addItem({label: "../fonts/HARNGTON.TTF", data: "../fonts/HARNGTON.TTF"});

			dataProvider.addItem({label: "../fonts/HATTEN.TTF", data: "../fonts/HATTEN.TTF"});

			dataProvider.addItem({label: "../fonts/HERAKLES.TTF", data: "../fonts/HERAKLES.TTF"});

			dataProvider.addItem({label: "../fonts/HTOWERT.TTF", data: "../fonts/HTOWERT.TTF"});

			dataProvider.addItem({label: "../fonts/HTOWERTI.TTF", data: "../fonts/HTOWERTI.TTF"});

			dataProvider.addItem({label: "../fonts/impact.ttf", data: "../fonts/impact.ttf"});

			dataProvider.addItem({label: "../fonts/IMPRISHA.TTF", data: "../fonts/IMPRISHA.TTF"});

			dataProvider.addItem({label: "../fonts/INFROMAN.TTF", data: "../fonts/INFROMAN.TTF"});

			dataProvider.addItem({label: "../fonts/ITCBLKAD.TTF", data: "../fonts/ITCBLKAD.TTF"});

			dataProvider.addItem({label: "../fonts/ITCEDSCR.TTF", data: "../fonts/ITCEDSCR.TTF"});

			dataProvider.addItem({label: "../fonts/ITCKRIST.TTF", data: "../fonts/ITCKRIST.TTF"});

			dataProvider.addItem({label: "../fonts/jancieni.ttf", data: "../fonts/jancieni.ttf"});

			dataProvider.addItem({label: "../fonts/JOKERMAN.TTF", data: "../fonts/JOKERMAN.TTF"});

			dataProvider.addItem({label: "../fonts/times.ttf", data: "../fonts/times.ttf"});

			dataProvider.addItem({label: "../fonts/timesbd.ttf", data: "../fonts/timesbd.ttf"});

			dataProvider.addItem({label: "../fonts/timesbi.ttf", data: "../fonts/timesbi.ttf"});

			dataProvider.addItem({label: "../fonts/timesi.ttf", data: "../fonts/timesi.ttf"});

			dataProvider.addItem({label: "../fonts/trebuc.ttf", data: "../fonts/trebuc.ttf"});

			dataProvider.addItem({label: "../fonts/trebucbd.ttf", data: "../fonts/trebucbd.ttf"});

			dataProvider.addItem({label: "../fonts/trebucbi.ttf", data: "../fonts/trebucbi.ttf"});

			dataProvider.addItem({label: "../fonts/trebucit.ttf", data: "../fonts/trebucit.ttf"});

			dataProvider.addItem({label: "../fonts/tunga.ttf", data: "../fonts/tunga.ttf"});

			dataProvider.addItem({label: "../fonts/V5PRC___.TTF", data: "../fonts/V5PRC___.TTF"});

			dataProvider.addItem({label: "../fonts/V5PRD___.TTF", data: "../fonts/V5PRD___.TTF"});

			dataProvider.addItem({label: "../fonts/V5PRF___.TTF", data: "../fonts/V5PRF___.TTF"});

			dataProvider.addItem({label: "../fonts/verdana.ttf", data: "../fonts/verdana.ttf"});

			dataProvider.addItem({label: "../fonts/verdanab.ttf", data: "../fonts/verdanab.ttf"});

			dataProvider.addItem({label: "../fonts/verdanai.ttf", data: "../fonts/verdanai.ttf"});

			dataProvider.addItem({label: "../fonts/verdanaz.ttf", data: "../fonts/verdanaz.ttf"});

			dataProvider.addItem({label: "../fonts/VINERITC.TTF", data: "../fonts/VINERITC.TTF"});

			dataProvider.addItem({label: "../fonts/VIVALDII.TTF", data: "../fonts/VIVALDII.TTF"});

			dataProvider.addItem({label: "../fonts/VLADIMIR.TTF", data: "../fonts/VLADIMIR.TTF"});

			dataProvider.addItem({label: "../fonts/vrinda.ttf", data: "../fonts/vrinda.ttf"});

			dataProvider.addItem({label: "../fonts/webdings.ttf", data: "../fonts/webdings.ttf"});

			dataProvider.addItem({label: "../fonts/wingding.ttf", data: "../fonts/wingding.ttf"});

			dataProvider.addItem({label: "../fonts/WINGDNG2.TTF", data: "../fonts/WINGDNG2.TTF"});

			dataProvider.addItem({label: "../fonts/WINGDNG3.TTF", data: "../fonts/WINGDNG3.TTF"});

			dataProvider.addItem({label: "online Airacobra%20Alt.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra%20Alt.ttf"});

			dataProvider.addItem({label: "online Airacobra%20Condensed.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra%20Condensed.ttf"});

			dataProvider.addItem({label: "online Airacobra%20Expanded.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra%20Expanded.ttf"});

			dataProvider.addItem({label: "online Airacobra%20Extra%20Bold.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra%20Extra%20Bold.ttf"});

			dataProvider.addItem({label: "online Airacobra%20Italic.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra%20Italic.ttf"});

			dataProvider.addItem({label: "online Airacobra%20Leftalic.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra%20Leftalic.ttf"});

			dataProvider.addItem({label: "online Airacobra%20Light.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra%20Light.ttf"});

			dataProvider.addItem({label: "online Airacobra.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airacobra.ttf"});

			dataProvider.addItem({label: "online Airbag%20Street.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airbag%20Street.ttf"});

			dataProvider.addItem({label: "online AirCut%20Light.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AirCut%20Light.ttf"});

			dataProvider.addItem({label: "online Airmole%20Antique.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airmole%20Antique.ttf"});

			dataProvider.addItem({label: "online Airmole%20Shaded.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airmole%20Shaded.ttf"});

			dataProvider.addItem({label: "online Airmole%20Stripe.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airmole%20Stripe.ttf"});

			dataProvider.addItem({label: "online Airmole.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Airmole.ttf"});

			dataProvider.addItem({label: "online Akashi%20MF.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Akashi%20MF.ttf"});

			dataProvider.addItem({label: "online Ala%20Carte.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Ala%20Carte.ttf"});

			dataProvider.addItem({label: "online Aladdin%20Regular.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Aladdin%20Regular.ttf"});

			dataProvider.addItem({label: "online Alako-Bold.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alako-Bold.ttf"});

			dataProvider.addItem({label: "online Alan%20Den.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alan%20Den.ttf"});

			dataProvider.addItem({label: "online Alcohole.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alcohole.ttf"});

			dataProvider.addItem({label: "online Aldo's%20Moon.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Aldo's%20Moon.ttf"});

			dataProvider.addItem({label: "online Aldo's%20Nova.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Aldo's%20Nova.ttf"});

			dataProvider.addItem({label: "online Alexis%203D.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%203D.ttf"});

			dataProvider.addItem({label: "online Alexis%20Bold.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Bold.ttf"});

			dataProvider.addItem({label: "online Alexis%20Expanded%20Italic.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Expanded%20Italic.ttf"});

			dataProvider.addItem({label: "online Alexis%20Expanded.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Expanded.ttf"});

			dataProvider.addItem({label: "online Alexis%20Grunge.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Grunge.ttf"});

			dataProvider.addItem({label: "online Alexis%20Italic.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Italic.ttf"});

			dataProvider.addItem({label: "online Alexis%20Laser%20Italic.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Laser%20Italic.ttf"});

			dataProvider.addItem({label: "online Alexis%20Laser.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Laser.ttf"});

			dataProvider.addItem({label: "online Alexis%20Leftalic.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis%20Leftalic.ttf"});

			dataProvider.addItem({label: "online Alexis.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alexis.ttf"});

			dataProvider.addItem({label: "online Alianna.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alianna.ttf"});

			dataProvider.addItem({label: "online Alien%20Bold.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alien%20Bold.ttf"});

			dataProvider.addItem({label: "online Alien%20Ghost%202.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alien%20Ghost%202.ttf"});

			dataProvider.addItem({label: "online Alien%20League.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alien%20League.ttf"});

			dataProvider.addItem({label: "online Alien%20MarksmanRegular.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alien%20MarksmanRegular.ttf"});

			dataProvider.addItem({label: "online Alien%20Script.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alien%20Script.ttf"});

			dataProvider.addItem({label: "online alienation%20Outline.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/alienation%20Outline.ttf"});

			dataProvider.addItem({label: "online alienation.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/alienation.ttf"});

			dataProvider.addItem({label: "online AlienAutopsy.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AlienAutopsy.ttf"});

			dataProvider.addItem({label: "online Aliens%20ate%20my%20mum.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Aliens%20ate%20my%20mum.ttf"});

			dataProvider.addItem({label: "online Aliens.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Aliens.ttf"});

			dataProvider.addItem({label: "online alienwarping.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/alienwarping.ttf"});

			dataProvider.addItem({label: "online Alison%20Regular.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alison%20Regular.ttf"});

			dataProvider.addItem({label: "online Alix2.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alix2.ttf"});

			dataProvider.addItem({label: "online All%20Caps.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/All%20Caps.ttf"});

			dataProvider.addItem({label: "online Allegro%20BT.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Allegro%20BT.ttf"});

			dataProvider.addItem({label: "online AllHookedUp.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AllHookedUp.ttf"});

			dataProvider.addItem({label: "online Almagro%20Regular.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Almagro%20Regular.ttf"});

			dataProvider.addItem({label: "online Almonte%20Snow.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Almonte%20Snow.ttf"});

			dataProvider.addItem({label: "online Almonte%20Woodgrain.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Almonte%20Woodgrain.ttf"});

			dataProvider.addItem({label: "online Almonte.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Almonte.ttf"});

			dataProvider.addItem({label: "online Alpha%20%20CLOWN.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20%20CLOWN.ttf"});

			dataProvider.addItem({label: "online Alpha%20%20Niner%20i.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20%20Niner%20i.ttf"});

			dataProvider.addItem({label: "online Alpha%20%20Niner.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20%20Niner.ttf"});

			dataProvider.addItem({label: "online Alpha%20Beta%20BRK.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Beta%20BRK.ttf"});

			dataProvider.addItem({label: "online Alpha%20Dance.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Dance.ttf"});

			dataProvider.addItem({label: "online Alpha%20Flight%20Small%20Caps.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Flight%20Small%20Caps.ttf"});

			dataProvider.addItem({label: "online Alpha%20Flight%20Solid%20Small%20Caps.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Flight%20Solid%20Small%20Caps.ttf"});

			dataProvider.addItem({label: "online Alpha%20Flight%20Solid.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Flight%20Solid.ttf"});

			dataProvider.addItem({label: "online Alpha%20Flight.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Flight.ttf"});

			dataProvider.addItem({label: "online Alpha%20Romanie%20G98.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Romanie%20G98.ttf"});

			dataProvider.addItem({label: "online Alpha%20Romanie%20Outline%20G98.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Romanie%20Outline%20G98.ttf"});

			dataProvider.addItem({label: "online Alpha%20Sentry.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Sentry.ttf"});

			dataProvider.addItem({label: "online Alpha%20Test%20JL.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alpha%20Test%20JL.ttf"});

			dataProvider.addItem({label: "online Alphabeta.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alphabeta.ttf"});

			dataProvider.addItem({label: "online alphabold.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/alphabold.ttf"});

			dataProvider.addItem({label: "online AlphaMack%20AOE.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AlphaMack%20AOE.ttf"});

			dataProvider.addItem({label: "online AlphaMaleModern.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AlphaMaleModern.ttf"});

			dataProvider.addItem({label: "online AlphaRev%20Hollow.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AlphaRev%20Hollow.ttf"});

			dataProvider.addItem({label: "online AlphaRev.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AlphaRev.ttf"});

			dataProvider.addItem({label: "online AltamonteNF.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/AltamonteNF.ttf"});

			dataProvider.addItem({label: "online Alterna.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Alterna.ttf"});

			dataProvider.addItem({label: "online Amalgam%20Shadow.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amalgam%20Shadow.ttf"});

			dataProvider.addItem({label: "online Amalgam.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amalgam.ttf"});

			dataProvider.addItem({label: "online Amalgamate%20BRK.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amalgamate%20BRK.ttf"});

			dataProvider.addItem({label: "online Amalgamate%20O%20BRK.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amalgamate%20O%20BRK.ttf"});

			dataProvider.addItem({label: "online Amano.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amano.ttf"});

			dataProvider.addItem({label: "online Amazon.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amazon.ttf"});

			dataProvider.addItem({label: "online Amazone%20BT.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amazone%20BT.ttf"});

			dataProvider.addItem({label: "online Ambrosia.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Ambrosia.ttf"});

			dataProvider.addItem({label: "online Amelia%20BT.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amelia%20BT.ttf"});

			dataProvider.addItem({label: "online Amelia.ttf", data: "http://www.webpagepublicity.com/free-fonts/a/Amelia.ttf"});


			return dataProvider;


		}

	}
}
