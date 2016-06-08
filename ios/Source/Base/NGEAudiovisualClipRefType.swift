import Foundation

#if (arch(i386) || arch(x86_64)) && os(iOS)
import libxmlSimu
#else
import libxml
#endif

@objc
class NGEAudiovisualClipRefType : NSObject{
    
    var sequence: Int?
    
    var seamless: Bool?
    
    var audioLanguage: String?
    
    var PresentationID: String!
    
    var EntryPointTimecode: NGETimecodeType?
    
    var ExitPointTimecode: NGETimecodeType?
    
    func readAttributes(reader: xmlTextReaderPtr) {
        
        let numFormatter = NSNumberFormatter()
        numFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        let sequenceAttrName = UnsafePointer<xmlChar>(NSString(stringLiteral: "sequence").UTF8String)
        let sequenceAttrValue = xmlTextReaderGetAttribute(reader, sequenceAttrName)
        if(sequenceAttrValue != nil) {
            
            self.sequence = numFormatter.numberFromString(String.fromCString(UnsafePointer<CChar>(sequenceAttrValue))!)!.integerValue
            xmlFree(sequenceAttrValue)
        }
        let seamlessAttrName = UnsafePointer<xmlChar>(NSString(stringLiteral: "seamless").UTF8String)
        let seamlessAttrValue = xmlTextReaderGetAttribute(reader, seamlessAttrName)
        if(seamlessAttrValue != nil) {
            
            self.seamless = (String.fromCString(UnsafePointer<CChar>(seamlessAttrValue)) == "true")
            xmlFree(seamlessAttrValue)
        }
        let audioLanguageAttrName = UnsafePointer<xmlChar>(NSString(stringLiteral: "audioLanguage").UTF8String)
        let audioLanguageAttrValue = xmlTextReaderGetAttribute(reader, audioLanguageAttrName)
        if(audioLanguageAttrValue != nil) {
            
            self.audioLanguage = String.fromCString(UnsafePointer<CChar>(audioLanguageAttrValue))
            xmlFree(audioLanguageAttrValue)
        }
    }
    
    init(reader: xmlTextReaderPtr) {
        let _complexTypeXmlDept = xmlTextReaderDepth(reader)
        super.init()
        
        let numFormatter = NSNumberFormatter()
        numFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        self.readAttributes(reader)
        
        var _readerOk = xmlTextReaderRead(reader)
        var _currentNodeType = xmlTextReaderNodeType(reader)
        var _currentXmlDept = xmlTextReaderDepth(reader)
        
        while(_readerOk > 0 && _currentNodeType != 0/*XML_READER_TYPE_NONE*/ && _complexTypeXmlDept < _currentXmlDept) {
            var handledInChild = false
            if(_currentNodeType == 1/*XML_READER_TYPE_ELEMENT*/ || _currentNodeType == 3/*XML_READER_TYPE_TEXT*/) {
                let _currentElementNameXmlChar = xmlTextReaderConstLocalName(reader)
                let _currentElementName = String.fromCString(UnsafePointer<CChar>(_currentElementNameXmlChar))
                if("PresentationID" == _currentElementName) {
                    
                    _readerOk = xmlTextReaderRead(reader)
                    _currentNodeType = xmlTextReaderNodeType(reader)
                    let PresentationIDElementValue = xmlTextReaderConstValue(reader)
                    if PresentationIDElementValue != nil {
                        
                        self.PresentationID = String.fromCString(UnsafePointer<CChar>(PresentationIDElementValue))
                        
                    }
                    _readerOk = xmlTextReaderRead(reader)
                    _currentNodeType = xmlTextReaderNodeType(reader)
                    
                } else if("EntryPointTimecode" == _currentElementName) {
                    
                    self.EntryPointTimecode = NGETimecodeType(reader: reader)
                    handledInChild = true
                    
                } else if("ExitPointTimecode" == _currentElementName) {
                    
                    self.ExitPointTimecode = NGETimecodeType(reader: reader)
                    handledInChild = true
                    
                } else   if(true) {
                    print("Ignoring unexpected in NGEAudiovisualClipRefType: \(_currentElementName)")
                    if superclass != NSObject.self {
                        break
                    }
                }
            }
            _readerOk = handledInChild ? xmlTextReaderReadState(reader) : xmlTextReaderRead(reader)
            _currentNodeType = xmlTextReaderNodeType(reader)
            _currentXmlDept = xmlTextReaderDepth(reader)
        }
        
    }
    
    /*var dictionary: [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        if(self.sequence != nil) {
            
            dict["sequence"] = self.sequence!
            
        }
        
        if(self.seamless != nil) {
            
            dict["seamless"] = self.seamless!
            
        }
        
        if(self.audioLanguage != nil) {
            
            dict["audioLanguage"] = self.audioLanguage!
            
        }
        
        if(self.PresentationID != nil) {
            
            dict["PresentationID"] = self.PresentationID!
            
        }
        
        if(self.EntryPointTimecode != nil) {
            dict["EntryPointTimecode"] = self.EntryPointTimecode!
        }
        
        if(self.ExitPointTimecode != nil) {
            dict["ExitPointTimecode"] = self.ExitPointTimecode!
        }
        
        return dict
    }*/
    
}

