package org.sepy.fontreader
{
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class Disassembler
	{
	    /**
	     * 
	     * @param ip The current instruction pointer
	     * @return The new instruction pointer
	     */
	    public static function advanceIP( instructions:Array, ip:int ):int
	    {
	        var i:int = ip & 0xffff;
	        var dataCount:int;
	        ip++;
	        
	        if (Mnemonic.NPUSHB == instructions[i])
	        {
	            dataCount = instructions[++i];
	            ip += dataCount + 1;
	        } else if (Mnemonic.NPUSHW == instructions[i])
	        {
	            dataCount = instructions[++i];
	            ip += dataCount*2 + 1;
	        } else if (Mnemonic.PUSHB == (instructions[i] & 0xf8))
	        {
	            dataCount = ((instructions[i] & 0x07) + 1);
	            ip += dataCount;
	        } else if (Mnemonic.PUSHW == (instructions[i] & 0xf8))
	        {
	            dataCount = ((instructions[i] & 0x07) + 1);
	            ip += dataCount*2;
	        }
	        return ip;
	    }
	
	    public static function getPushCount( instructions:Array, ip:int ):int
	    {
	        var instr:int = instructions[ip & 0xffff];
	        
	        if ((Mnemonic.NPUSHB == instr) || (Mnemonic.NPUSHW == instr))
	        {
	            return instructions[(ip & 0xffff) + 1];
	        } else if ((Mnemonic.PUSHB == (instr & 0xf8)) || (Mnemonic.PUSHW == (instr & 0xf8)))
	        {
	            return ((instr & 0x07) + 1);
	        }
	        return 0;
	    }
	
	
	    public static function getPushData( instructions:Array, ip:int ):Array
	    {
	        var count:int = getPushCount(instructions, ip);
	        var data:Array = new Array( count ); // int[]
	        var i:int = ip & 0xffff;
	        var instr:int = instructions[i];
	        var j:int;
	        
	        if (Mnemonic.NPUSHB == instr)
	        {
	            for (j = 0; j < count; j++)
	            {
	                data[j] = instructions[i + j + 2];
	            }
	        } else if (Mnemonic.PUSHB == (instr & 0xf8))
	        {
	            for (j = 0; j < count; j++)
	            {
	                data[j] = instructions[i + j + 1];
	            }
	        } else if (Mnemonic.NPUSHW == instr)
	        {
	            for (j = 0; j < count; j++)
	            {
	                data[j] = (instructions[i + j*2 + 2] << 8) | instructions[i + j*2 + 3];
	            }
	        } else if (Mnemonic.PUSHW == (instr & 0xf8))
	        {
	            for (j = 0; j < count; j++)
	            {
	                data[j] = (instructions[i + j*2 + 1] << 8) | instructions[i + j*2 + 2];
	            }
	        }
	        return data;
	    }
	    
	
	     public static function disassemble( instructions:Array, leadingSpaces:int ):String
	     {
	        var sb:StringBuffer = new StringBuffer();
	        var ip:int = 0;
	        var i:int;
	        
	        while (ip < instructions.length)
	        {
	            for (i = 0; i < leadingSpaces; i++)
	            {
	                sb.append(" ");
	            }
	            
	            sb.append(ip).append(": ");
	            sb.append(Mnemonic.getMnemonic(instructions[ip]));
	            
	            if (getPushCount(instructions, ip) > 0)
	            {
	                var data:Array = getPushData(instructions, ip);		// int[]
	                for(var j:int = 0; j < data.length; j++)
	                {
	                    if ((instructions[ip] == Mnemonic.PUSHW) || (instructions[ip] == Mnemonic.NPUSHW))
	                    {
	                        sb.append(" ").append(data[j]);
	                    } else
	                    {
	                        sb.append(" ").append(data[j]);
	                    }
	                }
	            }
	            sb.append("\n");
	            ip = advanceIP(instructions, ip);
	        }
	        return sb.toString();
	    }
	}
}