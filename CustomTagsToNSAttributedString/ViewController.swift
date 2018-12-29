//
//  ViewController.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var htmlStringInput: UITextField!
    @IBOutlet weak var outputParsedString: UITextView!
    @IBAction func parseButton(_ sender: Any) {
        guard let stringText = htmlStringInput.text else {
            print("set a correct initial fontm or something went wrong")
            return
        }
        let initialFeatureContainer:FeatureContainer = FeatureContainer();
        initialFeatureContainer.fontSize = 14.0
        initialFeatureContainer.fontType = "Arial"
        initialFeatureContainer.color = UIColor.black
        let parserWrapper = ParserWrapper.init(mString: stringText, initialFeature: initialFeatureContainer)
        if let attributedString = parserWrapper.Parse(){
            outputParsedString.attributedText = attributedString
        } else {
            outputParsedString.text = ParserConstants.unableToParse
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
