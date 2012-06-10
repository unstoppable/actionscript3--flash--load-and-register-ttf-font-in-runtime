package fox.shape
{
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFShapeRecordCurvedEdge;

	public final class CurvedEdgeRecord extends SWFShapeRecordCurvedEdge
	{
		public function CurvedEdgeRecord(data:SWFData=null, numBits:uint=0, level:uint=1):void
		{
			super(data, numBits, level);
		}

		public function setControlDeltaX(controlDeltaX:int):void
		{
			this.controlDeltaX=controlDeltaX;
		}

		public function setControlDeltaY(controlDeltaY:int):void
		{
			this.controlDeltaY=controlDeltaY;
		}

		public function setAnchorDeltaX(anchorDeltaX:int):void
		{
			this.anchorDeltaX=anchorDeltaX;
		}

		public function setAnchorDeltaY(anchorDeltaY:int):void
		{
			this.anchorDeltaY=anchorDeltaY;
		}
	}
}