import Foundation

import Alamofire
import RxSwift

protocol ApiProtocol {
    
    func requestIssues(of repo: String) -> Single<[Issue]>
    func requestPullRequests(of repo: String) -> Single<[PullRequest]>
}

private let token: String = "3881a990d2228e3a79508d097dbf7dfda70ced4c"

class ApiV3: ApiProtocol {
    
    private var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers["Authorization"] = "Bearer \(token)"
        return headers
    }
    
    func requestIssues(of repo: String) -> Single<[Issue]> {
        let api = "https://api.github.com/repos/\(repo)/issues"
        let headers = self.headers
        return Single.create { event -> Disposable in
            AF.request(api, headers: headers).responseData { (response) in
                switch response.result {
                case .success(let data):
                    let issues = try! JSONDecoder().decode([Issue].self, from: data)
                    event(.success(issues))
                case .failure(let error):
                    event(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func requestPullRequests(of repo: String) -> Single<[PullRequest]> {
        let api = "https://api.github.com/repos/\(repo)/pulls"
        let headers = self.headers
        return Single.create { event -> Disposable in
            AF.request(api, headers: headers).responseData { (response) in
                switch response.result {
                case .success(let data):
                    let issues = try! JSONDecoder().decode([PullRequest].self, from: data)
                    event(.success(issues))
                case .failure(let error):
                    event(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}

//class ApiV4: ApiProtocol {
//
//    func requestIssues(of repo: String) -> Single<[Issue]> {
//
//    }
//
//    func requestPullRequests(of repo: String) -> Single<[PullRequest]> {
//
//    }
//}
