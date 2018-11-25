//
//  ViewController.swift
//  CustomTagsToNSAttributedString
//
//  Created by Aakash Kataria on 21/11/18.
//  Copyright © 2018 Aakash Kataria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var parser: Parser!
    
    @IBOutlet weak var htmlStringInput: UITextField!
    @IBOutlet weak var outputParsedString: UITextView!
    @IBAction func parseButton(_ sender: Any) {
        guard let initialFont = UIFont.init(name: "Helvetica", size: 20),
            let stringText = htmlStringInput.text else {
            print("set a correct initial fontm or something went wrong")
            return
        }
        let parserModel = ParserModel.init(htmlString: stringText, initialFont: initialFont)
        parser = Parser(parserModel: parserModel)
        parser.delegate = self
        if let attributedString = parser.parseString(){
            outputParsedString.attributedText = attributedString
        } else {
            outputParsedString.text = ParserConstants.unableToParse
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: ParserDelegate {
    func unableToParse(_ message: String) {
        print(message)
    }
    func tagClassNotDefined(_ tag: String) {
        
    }
}
