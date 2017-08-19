//
//  SecondViewController.swift
//  WebConsultor
//
//  Created by Joaquín Jiménez García on 7/5/17.
//  Copyright © 2017 Joaquín Jiménez García. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var htmlText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        htmlText.text = urlContent as String!
    }
    
    @IBAction func refreshBtn(_ sender: Any) {
        htmlText.text = urlContent as String!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

