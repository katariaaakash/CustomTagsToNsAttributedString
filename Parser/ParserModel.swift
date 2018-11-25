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
    var htmlString: String
    var parseStackStringForm: [String] = []
    var initialFont: UIFont
    
    init(htmlString: String, initialFont: UIFont) {
        self.htmlString = ParserConstants.openingDefault + htmlString + ParserConstants.closingDefault
        self.htmlString = self.htmlString.replacingOccurrences(of: ParserConstants.breakTag, with: ParserConstants.breakLine, options: .literal, range: nil)
        self.initialFont = initialFont
    }
}
