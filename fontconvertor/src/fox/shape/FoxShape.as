package fox.shape
{

	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFShape;
	import com.codeazur.as3swf.data.SWFShapeRecord;

	public final class FoxShape extends SWFShape
	{
		private var last_x:int=int.MAX_VALUE;
		private var last_y:int=int.MAX_VALUE;

		public function FoxShape(data:SWFData=null, level:uint=1, unitDivisor:Number=20)
		{
			super(data, level, unitDivisor);
		}

		public function drawCurveTo(cx:int, cy:int, ax:int, ay:int):void
		{
			var cer:CurvedEdgeRecord=new CurvedEdgeRecord();
			cer.controlDeltaX=cx - last_x;
			cer.controlDeltaY=cy - last_y;
			cer.anchorDeltaX=ax - cx;
			cer.anchorDeltaY=ay - cy;
			records.push(cer);
			last_x=ax;
			last_y=ay;
		}

		public function drawLineTo(x:int, y:int):void
		{
			var deltaX:int=x - last_x;
			var deltaY:int=y - last_y;
			if (deltaX == 0)
			{
				if (deltaY == 0)
					return;
				records.push(StrightEdgeRecord.newVLine(deltaY));
			}
			else if (deltaY == 0)
			{
				records.push(StrightEdgeRecord.newHLine(deltaX));
			}
			else
			{
				records.push(StrightEdgeRecord.newLine(deltaX, deltaY));
			}
			last_x=x;
			last_y=y;
		}

		public function movePenTo(x:int, y:int):void
		{
			var rd:SWFShapeRecord;
			if (records.length)
			{
				rd=records[records.length - 1];
			}

			var sc:StyleChangeRecord;
			if (!rd || !(rd is StyleChangeRecord))
			{
				sc=new StyleChangeRecord();
			}
			else
			{
				sc=rd as StyleChangeRecord
			}

			if (last_x != x || last_y != y)
			{
				sc.addFlags(StyleChangeRecord.MOVETO);
				sc.setDeltaX(x);
				sc.setDeltaY(y);
				records.push(sc);
				last_x=x;
				last_y=y;
			}
		}

	}
}