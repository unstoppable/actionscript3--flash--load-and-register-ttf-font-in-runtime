package fox
{
	import flash.events.Event;

	public class FontEvent extends Event
	{
		public static const FONT_READY:String="fontReady";

		public var fonts:Array=[];

		public function FontEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}

		public override function clone():Event
		{
			var e:FontEvent=new FontEvent(type, bubbles, cancelable);
			e.fonts=fonts.concat([]);
			return e;
		}
	}
}