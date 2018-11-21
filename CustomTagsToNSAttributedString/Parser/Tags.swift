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
        featureContainer?.font 
    }
}

class I_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "b", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.font
    }
}

class Big_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "b", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.font
    }
}

class Small_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "b", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.font
    }
}

class Br_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "b", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.font
    }
}

class Font_Tag: Tag {
    override init(tagName: String, attributes: [String : Any]) {
        super.init(tagName: "b", attributes: attributes)
    }
    
    override func defaultAttribute() {
        featureContainer?.font
    }
}

