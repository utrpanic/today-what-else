import UIKit

enum TargetRepo: Int, CaseIterable {
    
    case alamofire
    case apollo
    
    var url: String {
        switch self {
        case .alamofire: return "https://github.com/Alamofire/Alamofire"
        case .apollo: return "https://github.com/apollographql/apollo-ios"
        }
    }
    
    var isSelected: Bool {
        return self == TargetRepo.current
    }
    
    static var current: TargetRepo = .alamofire
}

enum TargetFilter: Int, CaseIterable {
    
    case open
    case closed
    
    var name: String {
        switch self {
        case .open: return "Open"
        case .closed: return "Closed"
        }
    }
    
    static var current: TargetFilter = .open
}


class SettingsViewContrlller: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationItems()
        
        self.setupTableView()
        
        self.setupSegmentedControl()
    }
    
    private func setupNavigationItems() {
        self.navigationItem.title = "Settings"
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func setupSegmentedControl() {
        self.segmentedControl.removeAllSegments()
        TargetFilter.allCases.forEach {
            self.segmentedControl.insertSegment(withTitle: $0.name, at: $0.rawValue, animated: false)
        }
        self.segmentedControl.selectedSegmentIndex = TargetFilter.current.rawValue
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        let filter = TargetFilter(rawValue: sender.selectedSegmentIndex)!
        TargetFilter.current = filter
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TargetRepo.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let repo = TargetRepo(rawValue: indexPath.row)!
        let cellId = String(describing: SettingsListCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SettingsListCell
        cell.textLabel?.text = repo.url
        cell.textLabel?.font = repo.isSelected ? UIFont.boldSystemFont(ofSize: 17) : UIFont.systemFont(ofSize: 17)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = TargetRepo(rawValue: indexPath.row)!
        TargetRepo.current = repo
        tableView.reloadData()
    }
}

class SettingsListCell: UITableViewCell {
    
}
