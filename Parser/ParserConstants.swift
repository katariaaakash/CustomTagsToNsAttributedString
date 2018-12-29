//
//  ParserConstants.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation
import UIKit

class ParserConstants {
    public static let openingTagLimiter:String = "openDelimitter"
    public static let closingTagLimiter:String = "closingDelimitter"
    public static let forwardSlash:Character = "/"
    public static let backwardSlash:Character = "\\"
    public static let openingDefault:String = "<normal>"
    public static let closingDefault:String = "</normal>"
    public static let emptyString:String = ""
    public static let singleSpace:String = " "
    public static let unableToParseMessage:String = "Unable to parse, something is wrong with your string"
    public static let unableToParse:String = "Unable to parse"
    public static let badString:String = "Bad string"
    public static let leftTagBodyBracket:Character = "<"
    public static let rightTagBodyBracket:Character = ">"
    public static let breakTag:String = "<br>"
    public static let breakLine:String = "\n"
    public static let defaultTextColor:UIColor = UIColor.black
    
    
    
    public enum TagTypes: String {
        case normal = "normal"
        case bold = "b"
        case italics = "i"
        case small = "small"
        case big = "big"
        case font = "font"
        case br = "br"
        case strike = "strike"
    }
}
