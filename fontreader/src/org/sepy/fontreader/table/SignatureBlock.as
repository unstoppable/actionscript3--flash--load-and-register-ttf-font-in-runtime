package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class SignatureBlock
	{
	    private var reserved1:int;
	    private var reserved2:int;
	    private var signatureLen:int;
	    private var signature:ByteArray;
	    
	    public function SignatureBlock(di:ByteArray):void
	    {
	        reserved1 = di.readUnsignedShort();
	        reserved2 = di.readUnsignedShort();
	        signatureLen = di.readInt();
	        signature = new ByteArray();
	        di.readBytes(signature, 0, signatureLen);
	    }
	
	    public function toString():String
	    {
	        var sb:StringBuffer = new StringBuffer();
	        for (var i:uint = 0; i < signatureLen; i += 16) 
	        {
	            if (signatureLen - i >= 16) 
	            {
	            	signature.position = i;
	                sb.append( signature.readUTFBytes(16)).append("\n");
	            } else {
	            	signature.position = i;
	                sb.append( signature.readUTFBytes(signatureLen - i) ).append("\n");
	            }
	        }
	        return sb.toString();
	    }
	}
}