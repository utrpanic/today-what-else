//
//  DetailViewController.swift
//  TypingAttributes
//
//  Created by boxjeon on 2017. 9. 28..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate, NSTextStorageDelegate {

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
        self.textView.font = UIFont.systemFont(ofSize: 16, weight: .ultraLight)
        self.textView.delegate = self
        self.textView.textStorage.delegate = self
        
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
            NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 18, weight: .ultraLight),
        ]
    }
    
    @IBAction func didUnderlineTap(_ sender: UIButton) {
        self.textView.typingAttributes = [
            NSAttributedStringKey.underlineStyle.rawValue: NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 18, weight: .ultraLight),
        ]
    }
    
    @IBAction func didBackgroundgroundColorTap(_ sender: UIButton) {
        self.textView.typingAttributes = [
            NSAttributedStringKey.backgroundColor.rawValue: UIColor.yellow,
        ]
    }

    @IBAction func didFontSizeTap(_ sender: UIButton) {
        self.textView.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
    }
    
    @IBAction func didFontColorTap(_ sender: UIButton) {
        self.textView.textColor = UIColor.cyan
    }
    
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print("before textView: \(textView.text)")
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("after textView: \(textView.text)")
    }
    
    // MARK: - NSTextStorageDelegate
    func textStorage(_ textStorage: NSTextStorage, willProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        print("before textStorage: \(textStorage.string)")
    }
    
    func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorageEditActions, range editedRange: NSRange, changeInLength delta: Int) {
        print("after textStorage: \(textStorage.string)")
    }
    
}
