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
    
    @IBOutlet weak var outputParsedString: UILabel!
    @IBAction func parseButton(_ sender: Any) {
        guard let initialFont = UIFont.init(name: "Helvetica", size: 20) else {
            print("set a correct initial fontm or something went wrong")
            return
        }
        let parserModel = ParserModel.init(htmlString: "this is <b> bold </b> text", initialFont: initialFont)
        parser = Parser(parserModel: parserModel)
        parser.delegate = self
        parser.parseString()
    }
    @IBOutlet weak var htmlStringInput: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension ViewController: ParserDelegate {
    func unableToParse(_ message: String) {
        print(message)
    }
    func tagClassNotDefined(_ tag: String) {
        
    }
}
