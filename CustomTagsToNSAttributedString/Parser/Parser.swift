//
//  Parser.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation
import UIKit

protocol ParserDelegate: class {
    func unableToParse(_ message: String)
    func tagClassNotDefined(_ tag: String)
}
class Parser {
    var parserModel: ParserModel
    weak var delegate: ParserDelegate?
    
    init(parserModel: ParserModel) {
        self.parserModel = parserModel
    }
    
    func parseString() -> NSAttributedString?{
        self.parseHtmlString()
        let attrString = self.getAttributedString()
        if attrString != nil {
            return attrString
        }
        delegate?.unableToParse(ParserConstants.unableToParseMessage)
        return nil
    }
}

extension Parser {
    func getTagFromString(tag:String, attributes:[String]) -> Tag? {
        guard let tag: Tag = ParserUtils.getTag(tag: tag, attributes: attributes, initFeature: parserModel.initialFeatureContainer) else {
            return nil
        }
        return tag
    }
    
    func getFeatureFromTag(stringParts: [String]) -> FeatureContainer? {
        let tag:String = stringParts[0]
        var attributes:[String] = []
        if stringParts.count > 1 {
            attributes = Array(stringParts[1...stringParts.count-1])
        }
        guard let tagObj:Tag = ParserUtils.getTag(tag: tag, attributes: attributes, initFeature: parserModel.initialFeatureContainer) else {
            self.delegate?.unableToParse(ParserConstants.badString)
            return nil
        }
        return tagObj.featureContainer
    }
    
    func getAttributedString() -> NSAttributedString? {
        let finalAttributedString:NSMutableAttributedString = NSMutableAttributedString.init()
        var partialUnParsedString: String = ParserConstants.emptyString
        var features:[FeatureContainer] = []
        for elem in self.parserModel.parseStackStringForm {
            guard elem.count > 0 else {
                return nil
            }
            if elem.hasPrefix(ParserConstants.openingTagLimiter) {
                guard let openingTag = elem.deletePrefix(prefix: ParserConstants.openingTagLimiter) else {
                    delegate?.unableToParse(ParserConstants.unableToParseMessage)
                    return nil
                }
                let stringParts = openingTag.components(separatedBy: ParserConstants.singleSpace)
                if let featureFromTag = getFeatureFromTag(stringParts: stringParts) {
                    if features.count == 0 {
                        features.append(featureFromTag)
                    }
                    else {
                        features.append(ParserUtils.getUpdatedFeature(topFeature: features[features.count-1], incomingFeature: featureFromTag))
                    }
                }
                else {
                    self.delegate?.unableToParse(ParserConstants.badString)
                    return nil
                }
            } else if elem.hasPrefix(ParserConstants.closingTagLimiter) {
                features.popLast()
            } else {
                partialUnParsedString = elem
                if let partialAttrString = ParserUtils.getPartialAttributedString(partialUnParsedString: partialUnParsedString, feature: features[features.count - 1]) {
                    finalAttributedString.append(partialAttrString)
                }
                else {
                    self.delegate?.unableToParse(ParserConstants.badString)
                    return nil
                }
            }
        }
        return finalAttributedString
    }
    
    func parseHtmlString() {
        var parseStack:[String] = []
        var partialString:String = ParserConstants.emptyString
        var state = 0;
        for (index, char) in self.parserModel.htmlString.enumerated() {
            if char == ParserConstants.leftTagBodyBracket {
                switch state {
                case 0: state = 1
                partialString = ParserConstants.emptyString
                    break
                case 1: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 2:
                    if partialString != ParserConstants.emptyString  {
                        parseStack.append(partialString)
                    }
                    if index + 1 < self.parserModel.htmlString.count && self.parserModel.htmlString[index + 1] == "/" {
                        state = 3
                    } else {
                        state = 1
                    }
                    partialString = ParserConstants.emptyString
                    break
                case 3: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 4: delegate?.unableToParse(ParserConstants.badString)
                    return
                default: delegate?.unableToParse(ParserConstants.badString)
                    return
                }
            } else if char == ParserConstants.rightTagBodyBracket {
                switch state {
                case 0: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 1: state = 2
                if partialString != ParserConstants.emptyString  {
                    parseStack.append(ParserConstants.openingTagLimiter + partialString)
                }
                partialString = ParserConstants.emptyString
                    break
                case 2: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 3: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 4: state = 2
                if partialString != ParserConstants.emptyString  {
                    parseStack.append(partialString)
                }
                partialString = ParserConstants.emptyString
                    break
                default: delegate?.unableToParse(ParserConstants.badString)
                    return
                }
            } else if char == ParserConstants.forwardSlash {
                switch state {
                case 0: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 1: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 2: partialString += String(char)
                    break
                case 3: state = 4
                partialString += String(ParserConstants.closingTagLimiter)
                    break
                case 4: delegate?.unableToParse(ParserConstants.badString)
                    return
                default: delegate?.unableToParse(ParserConstants.badString)
                    return
                }
            } else {
                switch state {
                case 0: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 1: partialString += String(char)
                    break
                case 2: partialString += String(char)
                    break
                case 3: delegate?.unableToParse(ParserConstants.badString)
                    return
                case 4: partialString += String(char)
                default: delegate?.unableToParse(ParserConstants.badString)
                    return
                }
            }
        }
        for elem in parseStack {
            self.parserModel.parseStackStringForm.append(elem)
        }
        for elem in self.parserModel.parseStackStringForm {
            print(elem)
        }
    }
}
