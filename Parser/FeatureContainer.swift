//
//  FeatureContainer.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation
import UIKit

class FeatureContainer {
    var fontSize: CGFloat?
    var isBold: Bool?
    var isItalics: Bool?
    var fontType: String?
    var color:UIColor?
    var link:String?
    var isStrikedThrough:Bool?
    
    init() {
        
    }
    
    func union(oldFeature: FeatureContainer) -> FeatureContainer {
        let updatedFeature: FeatureContainer = FeatureContainer()
        if self.color == nil {
            updatedFeature.color = oldFeature.color
        } else {
            updatedFeature.color = self.color
        }
        if self.fontType == nil {
            updatedFeature.fontType = oldFeature.fontType
        } else {
            updatedFeature.fontType = self.fontType
        }
        if self.fontSize == nil {
            updatedFeature.fontSize = oldFeature.fontSize
        } else {
            updatedFeature.fontSize = self.fontSize
        }
        if self.isBold == nil {
            updatedFeature.isBold = oldFeature.isBold
        } else {
            updatedFeature.isBold = self.isBold
        }
        if self.isItalics == nil {
            updatedFeature.isItalics = oldFeature.isItalics
        } else {
            updatedFeature.isItalics = self.isItalics
        }
        if self.link == nil {
            updatedFeature.link = oldFeature.link
        } else {
            updatedFeature.link = self.link
        }
        if self.isStrikedThrough == nil {
            updatedFeature.isStrikedThrough = oldFeature.isStrikedThrough
        } else {
            updatedFeature.isStrikedThrough = self.isStrikedThrough
        }
        return updatedFeature
    }
}
