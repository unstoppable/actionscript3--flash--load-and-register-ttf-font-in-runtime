package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public class LigatureSubst implements ILookupSubtable
	{
		public function getTypeAsString():String
		{
			return null;
		}

	    public static function read( dis:ByteArray, offset:uint ):LigatureSubst
	    {
	        dis.position = offset;
	        var format:uint = dis.readUnsignedShort();
	        if (format == 1)
	            return new LigatureSubstFormat1( dis, offset );

	        return null;
	    }
		
	}
}