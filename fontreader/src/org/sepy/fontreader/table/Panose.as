package org.sepy.fontreader.table
{
	import flash.utils.ByteArray;
	import org.sepy.fontreader.utils.StringBuffer;
	
	public class Panose
	{

	  private var bFamilyType:int = 0; // byte
	  private var bSerifStyle:int = 0;
	  private var bWeight:int = 0;
	  private var bProportion:int = 0;
	  private var bContrast:int = 0;
	  private var bStrokeVariation:int = 0;
	  private var bArmStyle:int = 0;
	  private var bLetterform:int = 0;
	  private var bMidline:int = 0;
	  private var bXHeight:int = 0;
	
	  public function Panose( panose:ByteArray ):void
	  {
	    bFamilyType  = panose.readByte();
	    bSerifStyle  = panose.readByte();
	    bWeight      = panose.readByte();
	    bProportion  = panose.readByte();
	    bContrast    = panose.readByte();
	    bStrokeVariation = panose.readByte();
	    bArmStyle   = panose.readByte();
	    bLetterform = panose.readByte();
	    bMidline    = panose.readByte();
	    bXHeight    = panose.readByte();
	  }
	
	  public function getFamilyType():int
	  {
	    return bFamilyType;
	  }
	  
	  public function getSerifStyle():int
	  {
	    return bSerifStyle;
	  }
	  
	  public function getWeight():int
	  {
	    return bWeight;
	  }
	
	  public function getProportion():int
	  {
	    return bProportion;
	  }
	  
	  public function getContrast():int
	  {
	    return bContrast;
	  }
	  
	  public function getStrokeVariation():int
	  {
	    return bStrokeVariation;
	  }
	  
	  public function getArmStyle():int
	  {
	    return bArmStyle;
	  }
	  
	  public function getLetterForm():int
	  {
	    return bLetterform;
	  }
	  
	  public function getMidline():int
	  {
	    return bMidline;
	  }
	  
	  public function getXHeight():int
	  {
	    return bXHeight;
	  }
	  
	  public function toString():String
	  {
	    var sb:StringBuffer = new StringBuffer();
	    sb.append((bFamilyType)).append(" ")
	      .append((bSerifStyle)).append(" ")
	      .append((bWeight)).append(" ")
	      .append((bProportion)).append(" ")
	      .append((bContrast)).append(" ")
	      .append((bStrokeVariation)).append(" ")
	      .append((bArmStyle)).append(" ")
	      .append((bLetterform)).append(" ")
	      .append((bMidline)).append(" ")
	      .append((bXHeight));
	    return sb.toString();
	  }

	}
}