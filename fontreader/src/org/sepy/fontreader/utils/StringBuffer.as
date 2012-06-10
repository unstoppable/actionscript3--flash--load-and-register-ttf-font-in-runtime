
package org.sepy.fontreader.utils
{
	public class StringBuffer
	{
		private var _buffer:String;
		
		public function StringBuffer(buf:String=""):void
		{
			_buffer = buf;
		}
		
		public function append(obj:Object):StringBuffer
		{
			_buffer += obj.toString();
			return this;
		}
		
		public function toString():String
		{
			return _buffer;
		}
	}
}