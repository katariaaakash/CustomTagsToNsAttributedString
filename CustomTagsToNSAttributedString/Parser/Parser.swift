//
//  Parser.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation

protocol ParserDelegate: class {
    func unableToParse(_ message: String)
    func tagClassNotDefined(_ tag: String)
}
class Parser {
    var htmlString: String
    var parseStackStringForm: [String] = []
    weak var delegate: ParserDelegate?
    
    init(htmlString: String) {
        self.htmlString = ParserConstants.openingDefault + htmlString + ParserConstants.closingDefault
    }
    
    func parseString() -> NSAttributedString?{
        self.parseHtmlString()
        var attrString = self.getAttributedString()
        if attrString != nil {
            return attrString
        }
        delegate?.unableToParse(ParserConstants.unableToParseMessage)
        return nil
    }
}

extension Parser {
    func getAttributedString() -> NSAttributedString? {
        for elem in self.parseStackStringForm {
            guard elem.count > 0 else {
                return nil
            }
            if elem[0] == ParserConstants.openingTagLimiter {
                guard let openingTag = elem.popFront() else {
                    delegate?.unableToParse(ParserConstants.unableToParseMessage)
                    return nil
                }
                
            } else if elem[0] == ParserConstants.closingTagLimiter {
                
            } else {
                
            }
        }
        return nil
    }
    
    func parseHtmlString() {
        var parseStack:[String] = []
        var partialString:String = ""
        var state = 0;
        for (index, char) in self.htmlString.enumerated() {
            if char == "<" {
                switch state {
                case 0: state = 1
                partialString = ""
                    break
                case 1: delegate?.unableToParse("Bad string")
                    return
                case 2:
                    if partialString != ""  {
                        parseStack.append(partialString)
                    }
                    if index + 1 < htmlString.count && htmlString[index + 1] == "/" {
                        state = 3
                    } else {
                        state = 1
                    }
                    partialString = ""
                    break
                case 3: delegate?.unableToParse("Bad string")
                    return
                case 4: delegate?.unableToParse("Bad string")
                    return
                default: delegate?.unableToParse("Bad string")
                    return
                }
            } else if char == ">" {
                switch state {
                case 0: delegate?.unableToParse("Bad string")
                    return
                case 1: state = 2
                if partialString != ""  {
                    parseStack.append("\\" + partialString)
                }
                partialString = ""
                    break
                case 2: delegate?.unableToParse("Bad string")
                    return
                case 3: delegate?.unableToParse("Bad string")
                    return
                case 4: state = 2
                if partialString != ""  {
                    parseStack.append(partialString)
                }
                partialString = ""
                    break
                default: delegate?.unableToParse("Bad string")
                    return
                }
            } else if char == "/"{
                switch state {
                case 0: delegate?.unableToParse("Bad string")
                    return
                case 1: delegate?.unableToParse("Bad string")
                    return
                case 2: delegate?.unableToParse("Bad string")
                    return
                case 3: state = 4
                partialString += String(char)
                    break
                case 4: delegate?.unableToParse("Bad string")
                    return
                default: delegate?.unableToParse("Bad string")
                    return
                }
            } else {
                switch state {
                case 0: delegate?.unableToParse("Bad string")
                    return
                case 1: partialString += String(char)
                    break
                case 2: partialString += String(char)
                    break
                case 3: delegate?.unableToParse("Bad string")
                    return
                case 4: partialString += String(char)
                default: delegate?.unableToParse("Bad string")
                    return
                }
            }
        }
        for elem in parseStack {
            parseStackStringForm.append(elem)
        }
        for elem in parseStackStringForm {
            print(elem)
        }
    }
}

class Tag {
    var tagName:String
    var attributes:[[String: Any]]
    
    init(tagName:String, attributes: [[String: Any]]) {
        self.tagName = tagName
        self.attributes = attributes
    }
    
    func defaultAttribute() {
        
    }
}

class B_Tag: Tag {
    override init(tagName: String, attributes: [[String : Any]]) {
        super.init(tagName: "b", attributes: attributes)
    }
    
    override func defaultAttribute() {
        
    }
}

class I_Tag: Tag {
    
}

class Big_Tag: Tag {
    
}

class Small_Tag: Tag {
    
}

class Br_Tag: Tag {
    
}

class Font_Tag: Tag {
    
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
    func popFront() -> String? {
        guard self.count == 0 else {
            return nil
        }
        var res:String = ""
        for (index, char) in self.enumerated() {
            if index == 0 {
                continue
            } else {
                res += String(char)
            }
        }
        return res
    }
}

class ParserConstants {
    public static let openingTagLimiter:Character = "\\"
    public static let closingTagLimiter:Character = "/"
    public static let openingDefault:String = "<normal>"
    public static let closingDefault:String = "</normal>"
    public static let emptyString:String = ""
    public static let unableToParseMessage:String = "Unable to parse, something is wrong with your string"
}
