//
//  ParserWrapper.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 29/12/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import Foundation

extension String {
    func markupstringToNSAttributedString(initialFeatureContainer:FeatureContainer) -> NSAttributedString? {
        let parserWrapper: ParserWrapper = ParserWrapper.init(mString: self, initialFeature: initialFeatureContainer)
        return parserWrapper.Parse()
    }
}

class ParserWrapper {
    var mString: String
    var initialFeature: FeatureContainer
    
    init(mString: String, initialFeature: FeatureContainer) {
        self.mString = mString
        self.initialFeature = initialFeature
    }
    
    func Parse() -> NSAttributedString? {
        var parser: Parser
        let parserModel = ParserModel.init(htmlString: mString, initialFeatureContainer: initialFeature)
        parser = Parser(parserModel: parserModel)
        parser.delegate = self
        return parser.parseString()
    }
}

extension ParserWrapper: ParserDelegate {
    func unableToParse(_ message: String) {
        print(message)
    }
    func tagClassNotDefined(_ tag: String) {
        
    }
}
