package org.sepy.fontreader.table
{
	public class ID 
	{
	    // Platform IDs
	    public static const platformUnicode:int = 0;
	    public static const platformMacintosh:int = 1;
	    public static const platformISO:int = 2;
	    public static const platformMicrosoft:int = 3;
	
	    // Unicode Encoding IDs
	    public static const encodingUnicode10Semantics:int = 0;
	    public static const encodingUnicode11Semantics:int = 1;
	    public static const encodingISO10646Semantics:int = 2;
	    public static const encodingUnicode20Semantics:int = 3;
	    
	    // Microsoft Encoding IDs
		// public static const encodingUndefined:int = 0;
		// public static const encodingUGL:int = 1;
	    public static const encodingSymbol:int = 0;
	    public static const encodingUnicode:int = 1;
	    public static const encodingShiftJIS:int = 2;
	    public static const encodingPRC:int = 3;
	    public static const encodingBig5:int = 4;
	    public static const encodingWansung:int = 5;
	    public static const encodingJohab:int = 6;
	    public static const encodingUCS4:int = 10;
	
	    // Macintosh Encoding IDs
	    public static const encodingRoman:int = 0;
	    public static const encodingJapanese:int = 1;
	    public static const encodingChinese:int = 2;
	    public static const encodingKorean:int = 3;
	    public static const encodingArabic:int = 4;
	    public static const encodingHebrew:int = 5;
	    public static const encodingGreek:int = 6;
	    public static const encodingRussian:int = 7;
	    public static const encodingRSymbol:int = 8;
	    public static const encodingDevanagari:int = 9;
	    public static const encodingGurmukhi:int = 10;
	    public static const encodingGujarati:int = 11;
	    public static const encodingOriya:int = 12;
	    public static const encodingBengali:int = 13;
	    public static const encodingTamil:int = 14;
	    public static const encodingTelugu:int = 15;
	    public static const encodingKannada:int = 16;
	    public static const encodingMalayalam:int = 17;
	    public static const encodingSinhalese:int = 18;
	    public static const encodingBurmese:int = 19;
	    public static const encodingKhmer:int = 20;
	    public static const encodingThai:int = 21;
	    public static const encodingLaotian:int = 22;
	    public static const encodingGeorgian:int = 23;
	    public static const encodingArmenian:int = 24;
	    public static const encodingMaldivian:int = 25;
	    public static const encodingTibetan:int = 26;
	    public static const encodingMongolian:int = 27;
	    public static const encodingGeez:int = 28;
	    public static const encodingSlavic:int = 29;
	    public static const encodingVietnamese:int = 30;
	    public static const encodingSindhi:int = 31;
	    public static const encodingUninterp:int = 32;
	
	    // ISO Encoding IDs
	    public static const encodingASCII:int = 0;
	    public static const encodingISO10646:int = 1;
	    public static const encodingISO8859_1:int = 2;
	
	    // Microsoft Language IDs
	    public static const languageSQI:int = 0x041c;
	    public static const languageEUQ:int = 0x042d;
	    public static const languageBEL:int = 0x0423;
	    public static const languageBGR:int = 0x0402;
	    public static const languageCAT:int = 0x0403;
	    public static const languageSHL:int = 0x041a;
	    public static const languageCSY:int = 0x0405;
	    public static const languageDAN:int = 0x0406;
	    public static const languageNLD:int = 0x0413;
	    public static const languageNLB:int = 0x0813;
	    public static const languageENU:int = 0x0409;
	    public static const languageENG:int = 0x0809;
	    public static const languageENA:int = 0x0c09;
	    public static const languageENC:int = 0x1009;
	    public static const languageENZ:int = 0x1409;
	    public static const languageENI:int = 0x1809;
	    public static const languageETI:int = 0x0425;
	    public static const languageFIN:int = 0x040b;
	    public static const languageFRA:int = 0x040c;
	    public static const languageFRB:int = 0x080c;
	    public static const languageFRC:int = 0x0c0c;
	    public static const languageFRS:int = 0x100c;
	    public static const languageFRL:int = 0x140c;
	    public static const languageDEU:int = 0x0407;
	    public static const languageDES:int = 0x0807;
	    public static const languageDEA:int = 0x0c07;
	    public static const languageDEL:int = 0x1007;
	    public static const languageDEC:int = 0x1407;
	    public static const languageELL:int = 0x0408;
	    public static const languageHUN:int = 0x040e;
	    public static const languageISL:int = 0x040f;
	    public static const languageITA:int = 0x0410;
	    public static const languageITS:int = 0x0810;
	    public static const languageLVI:int = 0x0426;
	    public static const languageLTH:int = 0x0427;
	    public static const languageNOR:int = 0x0414;
	    public static const languageNON:int = 0x0814;
	    public static const languagePLK:int = 0x0415;
	    public static const languagePTB:int = 0x0416;
	    public static const languagePTG:int = 0x0816;
	    public static const languageROM:int = 0x0418;
	    public static const languageRUS:int = 0x0419;
	    public static const languageSKY:int = 0x041b;
	    public static const languageSLV:int = 0x0424;
	    public static const languageESP:int = 0x040a;
	    public static const languageESM:int = 0x080a;
	    public static const languageESN:int = 0x0c0a;
	    public static const languageSVE:int = 0x041d;
	    public static const languageTRK:int = 0x041f;
	    public static const languageUKR:int = 0x0422;
	
	    // Macintosh Language IDs
	    public static const languageEnglish:int = 0;
	    public static const languageFrench:int = 1;
	    public static const languageGerman:int = 2;
	    public static const languageItalian:int = 3;
	    public static const languageDutch:int = 4;
	    public static const languageSwedish:int = 5;
	    public static const languageSpanish:int = 6;
	    public static const languageDanish:int = 7;
	    public static const languagePortuguese:int = 8;
	    public static const languageNorwegian:int = 9;
	    public static const languageHebrew:int = 10;
	    public static const languageJapanese:int = 11;
	    public static const languageArabic:int = 12;
	    public static const languageFinnish:int = 13;
	    public static const languageGreek:int = 14;
	    public static const languageIcelandic:int = 15;
	    public static const languageMaltese:int = 16;
	    public static const languageTurkish:int = 17;
	    public static const languageYugoslavian:int = 18;
	    public static const languageChinese:int = 19;
	    public static const languageUrdu:int = 20;
	    public static const languageHindi:int = 21;
	    public static const languageThai:int = 22;
	
	    // Name IDs
	    public static const nameCopyrightNotice:int = 0;
	    public static const nameFontFamilyName:int = 1;
	    public static const nameFontSubfamilyName:int = 2;
	    public static const nameUniqueFontIdentifier:int = 3;
	    public static const nameFullFontName:int = 4;
	    public static const nameVersionString:int = 5;
	    public static const namePostscriptName:int = 6;
	    public static const nameTrademark:int = 7;
	    public static const nameManufacturerName:int = 8;
	    public static const nameDesigner:int = 9;
	    public static const nameDescription:int = 10;
	    public static const nameURLVendor:int = 11;
	    public static const nameURLDesigner:int = 12;
	    public static const nameLicenseDescription:int = 13;
	    public static const nameLicenseInfoURL:int = 14;
	    public static const namePreferredFamily:int = 16;
	    public static const namePreferredSubfamily:int = 17;
	    public static const nameCompatibleFull:int = 18;
	    public static const nameSampleText:int = 19;
	    public static const namePostScriptCIDFindfontName:int = 20;
	
	
	    public static function getPlatformName( platformId:int ):String
	    {
	        switch (platformId)
	        {
	            case platformUnicode:   return "Unicode";
	            case platformMacintosh: return "Macintosh";
	            case platformISO:       return "ISO";
	            case platformMicrosoft: return "Microsoft";
	            default:                return "Custom";
	        }
	    }
	
	    public static function getEncodingName( platformId:int, encodingId:int ):String
	    {
	        if ( platformId == platformUnicode )
	        {
	            // Unicode specific encodings
	            switch ( encodingId )
	            {
	                case encodingUnicode10Semantics: return "Unicode 1.0 semantics";
	                case encodingUnicode11Semantics: return "Unicode 1.1 semantics";
	                case encodingISO10646Semantics:  return "ISO 10646:1993 semantics";
	                case encodingUnicode20Semantics: return "Unicode 2.0 and onwards semantics";
	                default:                         return "";
	            }
	
	        } else if ( platformId == platformMacintosh )
	        {
	            // Macintosh specific encodings
	            switch (encodingId) 
	            {
	                case encodingRoman:      return "Roman";
	                case encodingJapanese:   return "Japanese";
	                case encodingChinese:    return "Chinese";
	                case encodingKorean:     return "Korean";
	                case encodingArabic:     return "Arabi";
	                case encodingHebrew:     return "Hebrew";
	                case encodingGreek:      return "Greek";
	                case encodingRussian:    return "Russian";
	                case encodingRSymbol:    return "RSymbol";
	                case encodingDevanagari: return "Devanagari";
	                case encodingGurmukhi:   return "Gurmukhi";
	                case encodingGujarati:   return "Gujarati";
	                case encodingOriya:      return "Oriya";
	                case encodingBengali:    return "Bengali";
	                case encodingTamil:      return "Tamil";
	                case encodingTelugu:     return "Telugu";
	                case encodingKannada:    return "Kannada";
	                case encodingMalayalam:  return "Malayalam";
	                case encodingSinhalese:  return "Sinhalese";
	                case encodingBurmese:    return "Burmese";
	                case encodingKhmer:      return "Khmer";
	                case encodingThai:       return "Thai";
	                case encodingLaotian:    return "Laotian";
	                case encodingGeorgian:   return "Georgian";
	                case encodingArmenian:   return "Armenian";
	                case encodingMaldivian:  return "Maldivian";
	                case encodingTibetan:    return "Tibetan";
	                case encodingMongolian:  return "Mongolian";
	                case encodingGeez:       return "Geez";
	                case encodingSlavic:     return "Slavic";
	                case encodingVietnamese: return "Vietnamese";
	                case encodingSindhi:     return "Sindhi";
	                case encodingUninterp:   return "Uninterpreted";
	                default:                 return "";
	            }
	
	        } else if ( platformId == platformISO )
	        {
	            // ISO specific encodings
	            switch ( encodingId )
	            {
	                case encodingASCII:     return "7-bit ASCII";
	                case encodingISO10646:  return "ISO 10646";
	                case encodingISO8859_1: return "ISO 8859-1";
	                default:                return "";
	            }
	
	        } else if ( platformId == platformMicrosoft )
	        {
	            // Windows specific encodings
	            switch ( encodingId )
	            {
	                case encodingSymbol:   return "Symbol";
	                case encodingUnicode:  return "Unicode";
	                case encodingShiftJIS: return "ShiftJIS";
	                case encodingPRC:      return "PRC";
	                case encodingBig5:     return "Big5";
	                case encodingWansung:  return "Wansung";
	                case encodingJohab:    return "Johab";
	                case 7:                return "Reserved";
	                case 8:                return "Reserved";
	                case 9:                return "Reserved";
	                case encodingUCS4:     return "UCS-4";
	                default:               return "";
	            }
	        }
	        return "";
	    }
	
	    public static function getLanguageName( platformId:int, languageId:int ):String
	    {
	        if ( platformId == platformMacintosh )
	        {
	            switch ( languageId )
	            {
	                case languageEnglish: return "English";
	                case languageFrench: return "French";
	                case languageGerman:  return "German";
	                case languageItalian: return "Italian";
	                case languageDutch: return "Dutch";
	                case languageSwedish: return "Swedish";
	                case languageSpanish: return "Spanish";
	                case languageDanish: return "Danish";
	                case languagePortuguese: return "Portuguese";
	                case languageNorwegian: return "Norwegian";
	                case languageHebrew: return "Hebrew";
	                case languageJapanese: return "Japanese";
	                case languageArabic: return "Arabic";
	                case languageFinnish: return "Finnish";
	                case languageGreek: return "Greek";
	                case languageIcelandic: return "Icelandic";
	                case languageMaltese: return "Maltese";
	                case languageTurkish: return "Turkish";
	                case languageYugoslavian: return "Yugoslavian";
	                case languageChinese: return "Chinese";
	                case languageUrdu: return "Urdu";
	                case languageHindi: return "Hindi";
	                case languageThai: return "Thai";
	                default: return "";
	            }
	        } else if ( platformId == platformMicrosoft )
	        {
	            switch ( languageId )
	            {
	                case languageSQI: return "Albanian (Albania)";
	                case languageEUQ: return "Basque (Basque)";
	                case languageBEL: return "Byelorussian (Byelorussia)";
	                case languageBGR: return "Bulgarian (Bulgaria)";
	                case languageCAT: return "Catalan (Catalan)";
	                case languageSHL: return "Croatian (Croatian)";
	                case languageCSY: return "Czech (Czech)";
	                case languageDAN: return "Danish (Danish)";
	                case languageNLD: return "Dutch (Dutch (Standard))";
	                case languageNLB: return "Dutch (Belgian (Flemish))";
	                case languageENU: return "English (American)";
	                case languageENG: return "English (British)";
	                case languageENA: return "English (Australian)";
	                case languageENC: return "English (Canadian)";
	                case languageENZ: return "English (New Zealand)";
	                case languageENI: return "English (Ireland)";
	                case languageETI: return "Estonian (Estonia)";
	                case languageFIN: return "Finnish (Finnish)";
	                case languageFRA: return "French (French (Standard))";
	                case languageFRB: return "French (Belgian)";
	                case languageFRC: return "French (Canadian)";
	                case languageFRS: return "French (Swiss)";
	                case languageFRL: return "French (Luxembourg)";
	                case languageDEU: return "German (German (Standard))";
	                case languageDES: return "German (Swiss)";
	                case languageDEA: return "German (Austrian)";
	                case languageDEL: return "German (Luxembourg)";
	                case languageDEC: return "German (Liechtenstein)";
	                case languageELL: return "Greek (Greek)";
	                case languageHUN: return "Hungarian (Hungarian)";
	                case languageISL: return "Icelandic (Icelandic)";
	                case languageITA: return "Italian (Italian (Standard))";
	                case languageITS: return "Italian (Swiss)";
	                case languageLVI: return "Latvian (Latvia)";
	                case languageLTH: return "Lithuanian (Lithuania)";
	                case languageNOR: return "Norwegian (Norwegian (Bokmal))";
	                case languageNON: return "Norwegian (Norwegian (Nynorsk))";
	                case languagePLK: return "Polish (Polish)";
	                case languagePTB: return "Portuguese (Portuguese (Brazilian))";
	                case languagePTG: return "Portuguese (Portuguese (Standard))";
	                case languageROM: return "Romanian (Romania)";
	                case languageRUS: return "Russian (Russian)";
	                case languageSKY: return "Slovak (Slovak)";
	                case languageSLV: return "Slovenian (Slovenia)";
	                case languageESP: return "Spanish (Spanish (Traditional Sort))";
	                case languageESM: return "Spanish (Mexican)";
	                case languageESN: return "Spanish (Spanish (Modern Sort))";
	                case languageSVE: return "Swedish (Swedish)";
	                case languageTRK: return "Turkish (Turkish)";
	                case languageUKR: return "Ukrainian (Ukraine)";
	                default: return "";
	            }
	        }
	        return "";
	    }
	
	    public static function getNameName( nameId:int ):String
	    {
	        switch ( nameId )
	        {
	            case nameCopyrightNotice: return "Copyright notice";
	            case nameFontFamilyName: return "Font Family name";
	            case nameFontSubfamilyName: return "Font Subfamily name";
	            case nameUniqueFontIdentifier: return "Unique font identifier";
	            case nameFullFontName: return "Full font name";
	            case nameVersionString: return "Version string";
	            case namePostscriptName: return "Postscript name";
	            case nameTrademark: return "Trademark";
	            case nameManufacturerName: return "Manufacturer Name";
	            case nameDesigner: return "Designer";
	            case nameDescription: return "Description";
	            case nameURLVendor: return "URL Vendor";
	            case nameURLDesigner: return "URL Designer";
	            case nameLicenseDescription: return "License Description";
	            case nameLicenseInfoURL: return "License Info URL";
	            case namePreferredFamily: return "Preferred Family";
	            case namePreferredSubfamily: return "Preferred Subfamily";
	            case nameCompatibleFull: return "Compatible Full";
	            case nameSampleText: return "Sample text";
	            case namePostScriptCIDFindfontName: return "PostScript CID findfont name";
	            default: return "";
	        }
	    }
	}

}