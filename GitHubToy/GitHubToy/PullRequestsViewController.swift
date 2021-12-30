import UIKit

import RxSwift

class PullRequestsViewModel {
    
    var pullRequests: BehaviorSubject<[PullRequest]> = BehaviorSubject(value: [])
    
    private let service: Service
    private let disposeBag: DisposeBag
    
    init(service: Service) {
        self.service = service
        self.disposeBag = DisposeBag()
    }
    
    func requestPullRequests(of repo: String) {
        self.service.requestPullRequests(of: repo)
            .subscribe(onNext: { pullRequests in
                self.pullRequests.onNext(pullRequests)
            })
            .disposed(by: self.disposeBag)
    }
}

class PullRequestsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: PullRequestsViewModel = PullRequestsViewModel(service: Service(api: ApiV3()))
    private var pullRequests: [PullRequest] = []
    private var disposeBag: DisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationItems()
        
        self.setupTableView()
        
        self.observeViewModel()
        
        self.viewModel.requestPullRequests(of: TargetRepo.current.url)
    }
    
    private func setupNavigationItems() {
        self.navigationItem.title = "PullRequests"
    }
    
    private func setupTableView() {
        self.tableView.dataSource = self
    }
    
    private func observeViewModel() {
        self.viewModel.pullRequests.subscribe(onNext: { pullRequests in
            self.pullRequests = pullRequests
            self.tableView.reloadData()
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pullRequest = self.pullRequests[indexPath.row]
        let cellId = String(describing: PullRequestsListCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PullRequestsListCell
        cell.textLabel?.text = pullRequest.title
        return cell
    }
}

class PullRequestsListCell: UITableViewCell {
    
}
