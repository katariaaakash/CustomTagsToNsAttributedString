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
    var font:UIFont?
    var color:UIColor?
    var link:String?
    
    init(font:UIFont?, color:UIColor?, link:String?) {
        self.font = font
        self.color = color
        self.link = link
    }
    
    init() {
        
    }
}
