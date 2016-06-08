import Foundation

#if (arch(i386) || arch(x86_64)) && os(iOS)
import libxmlSimu
#else
import libxml
#endif

@objc
class NGEDigitalAssetVideoSubtitleLanguageType : NSObject{
    
    var closed: Bool?
    
    var type: String?
    
    /**
    the type's underlying value
    */
    var value: String?
    
    func readAttributes(reader: xmlTextReaderPtr) {
        
        let closedAttrName = UnsafePointer<xmlChar>(NSString(stringLiteral: "closed").UTF8String)
        let closedAttrValue = xmlTextReaderGetAttribute(reader, closedAttrName)
        if(closedAttrValue != nil) {
            
            self.closed = (String.fromCString(UnsafePointer<CChar>(closedAttrValue)) == "true")
            xmlFree(closedAttrValue)
        }
        let typeAttrName = UnsafePointer<xmlChar>(NSString(stringLiteral: "type").UTF8String)
        let typeAttrValue = xmlTextReaderGetAttribute(reader, typeAttrName)
        if(typeAttrValue != nil) {
            
            self.type = String.fromCString(UnsafePointer<CChar>(typeAttrValue))
            xmlFree(typeAttrValue)
        }
    }
    
    init(reader: xmlTextReaderPtr) {
        let _complexTypeXmlDept = xmlTextReaderDepth(reader)
        super.init()
        
        self.readAttributes(reader)
        
        var _readerOk = xmlTextReaderRead(reader)
        var _currentNodeType = xmlTextReaderNodeType(reader)
        var _currentXmlDept = xmlTextReaderDepth(reader)
        
        while(_readerOk > 0 && _currentNodeType != 0/*XML_READER_TYPE_NONE*/ && _complexTypeXmlDept < _currentXmlDept) {
            
            if(_currentNodeType == 1/*XML_READER_TYPE_ELEMENT*/ || _currentNodeType == 3/*XML_READER_TYPE_TEXT*/) {
                let _currentElementNameXmlChar = xmlTextReaderConstLocalName(reader)
                let _currentElementName = String.fromCString(UnsafePointer<CChar>(_currentElementNameXmlChar))
                if("#text" == _currentElementName){
                    let contentValue = xmlTextReaderConstValue(reader)
                    if(contentValue != nil) {
                        let value = String.fromCString(UnsafePointer<CChar>(contentValue))
                        self.value = value
                    }
                } else  if(true) {
                    print("Ignoring unexpected in NGEDigitalAssetVideoSubtitleLanguageType: \(_currentElementName)")
                    if superclass != NSObject.self {
                        break
                    }
                }
            }
            _readerOk = xmlTextReaderRead(reader)
            _currentNodeType = xmlTextReaderNodeType(reader)
            _currentXmlDept = xmlTextReaderDepth(reader)
        }
        
    }
    
    /*var dictionary: [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        if(self.closed != nil) {
            
            dict["closed"] = self.closed!
            
        }
        
        if(self.type != nil) {
            
            dict["type"] = self.type!
            
        }
        
        if(self.value != nil) {
            
            dict["value"] = self.value!
            
        }
        
        return dict
    }*/
    
}

