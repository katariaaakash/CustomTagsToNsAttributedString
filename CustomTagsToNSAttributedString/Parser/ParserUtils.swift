//
//  ParserUtils.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation
import UIKit

class ParserUtils {
    static func getTag(tag: String, attributes:[String]) -> Tag? {
        switch tag {
        case ParserConstants.TagTypes.bold.rawValue:
            return B_Tag(tagName: tag, attributes: getAttributeDictionary(attributes: attributes))
        case ParserConstants.TagTypes.italics.rawValue:
            return I_Tag(tagName: tag, attributes: getAttributeDictionary(attributes: attributes))
        case ParserConstants.TagTypes.small.rawValue:
            return Small_Tag(tagName: tag, attributes: getAttributeDictionary(attributes: attributes))
        case ParserConstants.TagTypes.big.rawValue:
            return Big_Tag(tagName: tag, attributes: getAttributeDictionary(attributes: attributes))
        case ParserConstants.TagTypes.font.rawValue:
            return Font_Tag(tagName: tag, attributes: getAttributeDictionary(attributes: attributes))
        case ParserConstants.TagTypes.normal.rawValue:
            return Normal_Tag(tagName: tag, attributes: getAttributeDictionary(attributes: attributes))
        default:
            return nil
        }
    }
    
    static func getAttributeDictionary(attributes: [String]) -> [String: Any] {
        var attributeDict:[String:Any] = [:]
        var singleAtrributeArrayForm:[String] = []
        for attribute in attributes {
            singleAtrributeArrayForm = attribute.components(separatedBy: "=")
            if singleAtrributeArrayForm.count == 2{
                attributeDict[singleAtrributeArrayForm[0]] = singleAtrributeArrayForm[1]
            }
        }
        return attributeDict
    }
    
    static func getPartialAttributedString(partialUnParsedString: String, feature: FeatureContainer) -> NSAttributedString? {
        guard let color = feature.color,
            let font = getFontFromFeature(feature: feature) else {
                return nil
        }
        let attribute = [NSAttributedString.Key.underlineColor: color,
                         NSAttributedString.Key.font: font]
        let nsAttributedString = NSAttributedString.init(string: partialUnParsedString, attributes: attribute)
        return nsAttributedString
    }
    
    static func getFontFromFeature(feature: FeatureContainer) -> UIFont? {
        guard let fontType: String = feature.fontType,
            let fontSize: CGFloat = feature.fontSize,
            let isBold: Bool = feature.isBold,
            let isItalics: Bool = feature.isItalics,
            var font: UIFont = UIFont.init(name: fontType, size: fontSize) else {
                return nil
        }
        if isBold {
            font = font.bold()
        }
        if isItalics {
            font = font.italic()
        }
        return font
    }
    
    static func getUpdatedFeature(topFeature: FeatureContainer, incomingFeature: FeatureContainer) -> FeatureContainer {
        var updatedFeature: FeatureContainer = FeatureContainer()
        if incomingFeature.color == nil {
            updatedFeature.color = topFeature.color
        } else {
            updatedFeature.color = incomingFeature.color
        }
        if incomingFeature.fontType == nil {
            updatedFeature.fontType = topFeature.fontType
        } else {
            updatedFeature.fontType = incomingFeature.fontType
        }
        if incomingFeature.fontSize == nil {
            updatedFeature.fontSize = topFeature.fontSize
        } else {
            updatedFeature.fontSize = incomingFeature.fontSize
        }
        if incomingFeature.isBold == nil {
            updatedFeature.isBold = topFeature.isBold
        } else {
            updatedFeature.isBold = incomingFeature.isBold
        }
        if incomingFeature.isItalics == nil {
            updatedFeature.isItalics = topFeature.isItalics
        } else {
            updatedFeature.isItalics = incomingFeature.isItalics
        }
        if incomingFeature.link == nil {
            updatedFeature.link = topFeature.link
        } else {
            updatedFeature.link = incomingFeature.link
        }
        return updatedFeature
    }
}

extension UIFont {
    func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        return UIFont(descriptor: descriptor!, size: 0)
    }
    
    func bold() -> UIFont {
        return withTraits(traits: .traitBold)
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }
    
    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }
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
        guard self.count != 0 else {
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
