
import UIKit

class ViewController: UIViewController, InputAccessoryViewDelegate, InputViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomViewBottomSpace: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.textView.becomeFirstResponder()
    }
    
    func setupTextView() {
        self.updateTextInputViewAsKeyboard()
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
    
    @IBAction func toggleButtonDidTap(_ sender: UIButton) {
        self.toggleTextInputView()
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
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        self.bottomViewBottomSpace.constant = frame.height - self.view.safeAreaInsets.bottom
    }
    
    @objc
    func keyboardWillHide(_ notification: Notification) {
        self.bottomViewBottomSpace.constant = 0
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
