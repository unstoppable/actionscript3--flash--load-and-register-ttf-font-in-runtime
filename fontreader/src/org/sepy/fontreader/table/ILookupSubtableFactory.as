package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	
	public interface ILookupSubtableFactory
	{
		function read(type:int, dis:ByteArray, offset:int):ILookupSubtable;
	}
}