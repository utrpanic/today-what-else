//
//  DetailViewController.swift
//  TypingAttributes
//
//  Created by boxjeon on 2017. 9. 28..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var foregroundColorButton: UIButton!
    @IBOutlet weak var underlineButton: UIButton!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem, let textView = self.textView {
            textView.text = detail.description
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
            configureView()
        }
    }

    @IBAction func didForegroundColorTap(_ sender: UIButton) {
        self.textView.typingAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.red,
        ]
    }
    
    @IBAction func didUnderlineTap(_ sender: UIButton) {
        self.textView.typingAttributes = [
            NSAttributedStringKey.underlineStyle.rawValue: NSUnderlineStyle.styleSingle.rawValue,
        ]
    }
    
}
