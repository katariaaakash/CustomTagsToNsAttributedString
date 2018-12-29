//
//  Tags.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation
import UIKit

class Tag {
    var tagName: String
    var attributes: [String: Any]
    var featureContainer:FeatureContainer?
    
    init(tagName:String, attributes: [String: Any]) {
        self.tagName = tagName
        self.attributes = attributes
        self.featureContainer = FeatureContainer()
    }
    
    func defaultAttribute() {
        
    }
}

class B_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "b", attributes: attributes)
        defaultAttribute()
    }
    
    override func defaultAttribute() {
        featureContainer?.isBold = true
    }
}

class I_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "i", attributes: attributes)
        defaultAttribute()
    }
    
    override func defaultAttribute() {
        featureContainer?.isItalics = true
    }
}

class Big_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "big", attributes: attributes)
        defaultAttribute()
    }
    
    override func defaultAttribute() {
        featureContainer?.fontSize = 16.0
    }
}

class Small_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "small", attributes: attributes)
        defaultAttribute()
    }
    
    override func defaultAttribute() {
        featureContainer?.fontSize = 12.0
    }
}

class Normal_Tag: Tag {
    var initFeature: FeatureContainer
    init(tagName: String, attributes: [String : Any], initFeature: FeatureContainer) {
        self.initFeature = initFeature
        super.init(tagName: "normal", attributes: attributes)
        defaultAttribute()
    }
    
    override func defaultAttribute() {
        featureContainer?.color = initFeature.color ?? ParserConstants.defaultTextColor
        featureContainer?.fontSize = initFeature.fontSize ?? 14.0
        featureContainer?.fontType = initFeature.fontType ?? "Arial"
        featureContainer?.isBold = initFeature.isBold ?? false
        featureContainer?.isItalics = initFeature.isItalics ?? false
    }
}

class Br_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "br", attributes: attributes)
        defaultAttribute()
    }
    
    override func defaultAttribute() {
    }
}

class Strike_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "strike", attributes: attributes)
        defaultAttribute()
    }
    
    override func defaultAttribute() {
        featureContainer?.isStrikedThrough = true
    }
}

class Font_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "font", attributes: attributes)
        defaultAttribute()
        applyAttributes()
    }
    
    override func defaultAttribute() {
    }
    
    func applyAttributes() {
        for (key, value) in attributes {
            guard let value = value as? String else {
                return
            }
            switch key {
            case "color":
                featureContainer?.color = UIColor().hexToColor(hexString: value, alpha: 1.0)
                break
            default: break
            }
        }
    }
}

