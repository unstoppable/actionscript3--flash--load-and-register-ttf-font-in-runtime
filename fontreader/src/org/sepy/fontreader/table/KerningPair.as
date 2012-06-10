package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;

	public class KerningPair
	{

		private var _left:uint;
		private var _right:uint;
		private var _value:int;

		/**
		 *
		 * @param di
		 * @throws IOError
		 */
		public function KerningPair(di:ByteArray):void
		{
			_left=di.readUnsignedShort();
			_right=di.readUnsignedShort();
			_value=di.readShort();
		}

		public function get left():uint
		{
			return _left;
		}

		public function get right():uint
		{
			return _right;
		}

		public function get value():int
		{
			return _value;
		}

	}
}