
import UIKit

protocol InputAccessoryViewDelegate: class {
    
    func switchKeyboardButtonDidTap()
    func dismissKeyboardButtonDidTap()
}

class InputAccessoryView: UIView {
    
    weak var delegate: InputAccessoryViewDelegate?
    
    @IBAction func switchButtonDidTap(_ sender: UIButton) {
        self.delegate?.switchKeyboardButtonDidTap()
    }
    
    @IBAction func dismissButtonDidTap(_ sender: UIButton) {
        self.delegate?.dismissKeyboardButtonDidTap()
    }
}
