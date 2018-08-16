
import UIKit

protocol InputViewDelegate: class {
    func topLeftButtonDidTap()
    func topRightButtonDidTap()
    func bottomLeftButtonDidTap()
    func bottomRightButtonDidTap()
}

class InputView: UIInputView {
    
    weak var delegate: InputViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.allowsSelfSizing = false
    }
    
    @IBAction func topLeftButtonDidTap(_ sender: UIButton) {
        self.delegate?.topLeftButtonDidTap()
    }
    
    @IBAction func topRightButtonDidTap(_ sender: UIButton) {
        self.delegate?.topRightButtonDidTap()
    }
    
    @IBAction func bottomLeftButtonDidTap(_ sender: UIButton) {
        self.delegate?.bottomLeftButtonDidTap()
    }
    
    @IBAction func bottomRightButtonDidTap(_ sender: UIButton) {
        self.delegate?.bottomRightButtonDidTap()
    }
}
