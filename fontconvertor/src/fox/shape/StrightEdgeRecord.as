package fox.shape
{
	import com.codeazur.as3swf.data.SWFShapeRecordStraightEdge;

	public final class StrightEdgeRecord extends SWFShapeRecordStraightEdge
	{

		public function setDeltaX(deltaX:int):void
		{
			this.deltaX=deltaX;
		}

		public function setDeltaY(deltaY:int):void
		{
			this.deltaY=deltaY;
		}

		public static function newLine(deltaX:int, deltaY:int):StrightEdgeRecord
		{
			var sr:StrightEdgeRecord=new StrightEdgeRecord();
			sr.generalLineFlag=true;
			sr.setDeltaX(deltaX);
			sr.setDeltaY(deltaY);
			return sr;
		}

		public static function newHLine(deltaX:int):StrightEdgeRecord
		{
			var sr:StrightEdgeRecord=new StrightEdgeRecord();
			sr.setDeltaX(deltaX);
			return sr;
		}

		public static function newVLine(deltaY:int):StrightEdgeRecord
		{
			var sr:StrightEdgeRecord=new StrightEdgeRecord();
			sr.vertLineFlag=true;
			sr.setDeltaY(deltaY);
			return sr;
		}

	}
}