
import UIKit

// https://openradar.appspot.com/43081635

class ViewController: UIViewController, InputAccessoryViewDelegate, InputViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextView()
    }
    
    func setupTextView() {
        self.updateTextInputViewAsKeyboard()
        self.textView.becomeFirstResponder()
    }
    
    func updateTextInputViewAsKeyboard() {
        self.updateTextInputAccessoryView()
        self.textView.inputView = nil
        self.textView.reloadInputViews()
    }
    
    func updateTextInputViewAsButtons() {
        self.updateTextInputAccessoryView()
        let inputView = Bundle.main.loadNibNamed("InputView", owner: self, options: nil)?.first as! InputView
        inputView.delegate = self
        self.textView.inputView = inputView
        self.textView.reloadInputViews()
    }
    
    func toggleTextInputView() {
        if self.textView.inputView == nil {
            self.updateTextInputViewAsButtons()
        } else {
            self.updateTextInputViewAsKeyboard()
        }
    }
    
    func updateTextInputAccessoryView() {
        let inputAccessoryView = Bundle.main.loadNibNamed("InputAccessoryView", owner: self, options: nil)?.first as! InputAccessoryView
        inputAccessoryView.delegate = self
        self.textView.inputAccessoryView = inputAccessoryView
    }
    
    @IBAction func dismissKeyboardButtonDidTap(_ sender: UIButton) {
        self.textView.resignFirstResponder()
    }
    
    // MARK: - InputAccessoryViewDelegate
    func switchKeyboardButtonDidTap() {
        self.toggleTextInputView()
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
