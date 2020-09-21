import RxSwift

class Service {
    
    private var api: ApiProtocol
    
    init(api: ApiProtocol) {
        self.api = api
    }
    
    func requestIssues(of repo: String) -> Observable<[Issue]> {
        return self.api.requestIssues(of: repo).asObservable()
    }
    
    func requestPullRequests(of repo: String) -> Observable<[PullRequest]> {
        return self.api.requestPullRequests(of: repo).asObservable()
    }
}
