
import UIKit

class ViewController: UIViewController, InputAccessoryViewDelegate, InputViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextView()
    }
    
    func setupTextView() {
        let inputAccessoryView = Bundle.main.loadNibNamed("InputAccessoryView", owner: self, options: nil)?.first as! InputAccessoryView
        inputAccessoryView.delegate = self
        self.textView.inputAccessoryView = inputAccessoryView
        self.textView.becomeFirstResponder()
    }
    
    func updateTextViewInputView() {
        if self.textView.inputView == nil {
            let inputView = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.first as! InputView
            inputView.delegate = self
            self.textView.inputView = inputView
        } else {
            self.textView.inputView = nil
        }
        self.textView.reloadInputViews()
    }
    
    @IBAction func dismissKeyboardButtonDidTap(_ sender: UIButton) {
        self.textView.resignFirstResponder()
    }
    
    // MARK: - InputAccessoryViewDelegate
    func switchKeyboardButtonDidTap() {
        self.updateTextViewInputView()
    }
    
    func dismissKeyboardButtonDidTap() {
        self.textView.resignFirstResponder()
    }
    
    // MARK: - InputViewDelegate
    func topLeftButtonDidTap() {
        
    }
    
    func topRightButtonDidTap() {
        
    }
    
    func bottomLeftButtonDidTap() {
        
    }
    
    func bottomRightButtonDidTap() {
        
    }
}
