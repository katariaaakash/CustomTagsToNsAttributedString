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
        parser = Parser(htmlString: htmlStringInput.text!)
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


