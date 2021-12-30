import UIKit

import RxSwift

class IssuesViewModel {
    
    var issues: BehaviorSubject<[Issue]> = BehaviorSubject(value: [])
    
    private let service: Service
    private let disposeBag: DisposeBag
    
    init(service: Service) {
        self.service = service
        self.disposeBag = DisposeBag()
    }
    
    func requestIssues(of repo: String) {
        self.service.requestIssues(of: repo)
            .subscribe(onNext: { issues in
                self.issues.onNext(issues)
            })
            .disposed(by: self.disposeBag)
    }
}

class IssuesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: IssuesViewModel = IssuesViewModel(service: Service(api: ApiV3()))
    private var issues: [Issue] = []
    private var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationItems()
        
        self.setupTableView()
        
        self.observeViewModel()
        
        self.viewModel.requestIssues(of: TargetRepo.current.url)
    }
    
    private func setupNavigationItems() {
        self.navigationItem.title = "Issues"
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
    }
    
    private func observeViewModel() {
        self.viewModel.issues.subscribe(onNext: { issues in
            self.issues = issues
            self.tableView.reloadData()
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.issues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let issue = self.issues[indexPath.row]
        let cellId = String(describing: IssuesListCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! IssuesListCell
        cell.textLabel?.text = issue.title
        return cell
    }
}

class IssuesListCell: UITableViewCell {
    
}
