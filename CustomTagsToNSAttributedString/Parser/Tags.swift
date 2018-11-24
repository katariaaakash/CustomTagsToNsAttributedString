//
//  Tags.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation

class Tag {
    var tagName: String
    var attributes: [String: Any]
    var featureContainer:FeatureContainer?
    
    init(tagName:String, attributes: [String: Any]) {
        self.tagName = tagName
        self.attributes = attributes
    }
    
    func defaultAttribute() {
        
    }
}

class B_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "b", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.isBold = true
    }
}

class I_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "i", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.isItalics = true
    }
}

class Big_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "big", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.fontSize = 16.0
    }
}

class Small_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "small", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.fontSize = 12.0
    }
}

class Normal_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "normal", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.color = ParserConstants.defaultTextColor
        featureContainer?.fontSize = 14.0
        featureContainer?.fontType = "system"
        featureContainer?.isBold = false
        featureContainer?.isItalics = false
    }
}

class Br_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "br", attributes: attributes)
    }
    
    override func defaultAttribute() {
    }
}

class Font_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "font", attributes: attributes)
    }
    
    override func defaultAttribute() {
    }
}

