import UIKit

class IssuesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationItems()
    }
    
    private func setupNavigationItems() {
        self.navigationItem.title = "Issues"
    }
}
