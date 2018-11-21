//
//  ParserModel.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation
import UIKit

class ParserModel {
    var htmlString: String {
        didSet {
            htmlString = ParserConstants.openingDefault + htmlString + ParserConstants.closingDefault
        }
    }
    var parseStackStringForm: [String] = []
    var initialFont: UIFont
    
    init(htmlString: String, initialFont: UIFont) {
        self.htmlString = htmlString
        self.initialFont = initialFont
    }
}
