//
//  ViewController.swift
//  TextViewDelegate
//
//  Created by gurren-l-macbook-pro on 2018. 7. 4..
//  Copyright © 2018년 boxjeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textView.delegate = self
    }

    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return false
    }


}

