package org.sephiroth.errors
{
	public class NonImplementationError extends Error
	{
		public function NonImplementationError(message:String="", id:int=0)
		{
			super(message, id);
		}
		
	}
}