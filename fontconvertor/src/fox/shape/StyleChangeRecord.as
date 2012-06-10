package fox.shape
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFShapeRecordStyleChange;

	public final class StyleChangeRecord extends SWFShapeRecordStyleChange
	{

		public static const NEW_STYLES:uint=0x10;
		public static const LINESTYLE:uint=0x08;
		public static const FILLSTYLE1:uint=0x04;
		public static const FILLSTYLE0:uint=0x02;
		public static const MOVETO:uint=0x01;

		private var flags:uint;

		public function StyleChangeRecord(data:SWFData=null, states:uint=0, fillBits:uint=0, lineBits:uint=0, level:uint=1)
		{
			super(data, states, fillBits, lineBits, level);
		}

		public function setFlags(flags:int):void
		{
			this.flags=flags;

			stateNewStyles=(flags & NEW_STYLES) != 0;
			stateLineStyle=(flags & LINESTYLE) != 0;
			stateFillStyle1=(flags & FILLSTYLE1) != 0;
			stateFillStyle0=(flags & FILLSTYLE0) != 0;
			stateMoveTo=(flags & MOVETO) != 0;
		}

		public function addFlags(fg:int):void
		{
			this.flags=this.flags | fg;
			
			stateNewStyles=(flags & NEW_STYLES) != 0;
			stateLineStyle=(flags & LINESTYLE) != 0;
			stateFillStyle1=(flags & FILLSTYLE1) != 0;
			stateFillStyle0=(flags & FILLSTYLE0) != 0;
			stateMoveTo=(flags & MOVETO) != 0;
		}

		public function setDeltaX(deltaX:int):void
		{
			this.moveDeltaX=deltaX;
		}

		public function setDeltaY(deltaY:int):void
		{
			this.moveDeltaY=deltaY;
		}

		public function setFillStyle1(fillStyle1:int):void
		{
			this.fillStyle1=fillStyle1;
		}

		public function setLineStyle(lineStyle:int):void
		{
			this.lineStyle=lineStyle;
		}

	}
}