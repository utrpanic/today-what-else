import UIKit
import TinyConstraints

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  private enum Section: Int, CaseIterable {
    case table
    case collection
  }
  
  weak var tableView: UITableView?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigation()
    self.setupTableView()
  }
  
  private func setupNavigation() {
    self.navigationItem.title = "ListSample"
  }
  
  private func setupTableView() {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.delegate = self
    self.view.addSubview(tableView)
    tableView.edgesToSuperview()
    self.tableView = tableView
    tableView.registerFromClass(UITableViewCell.self)
  }
  
  // MARK: UITableViewDataSource, UITableViewDelegate
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return Section.allCases.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let section = Section.allCases[indexPath.section]
    let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
    cell.selectionStyle = .none
    var content = cell.defaultContentConfiguration()
    content.text = "\(section)"
    cell.contentConfiguration = content
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let section = Section.allCases[indexPath.section]
    switch section {
    case .table:
      let viewController = TableViewController()
      self.navigationController?.pushViewController(viewController, animated: true)
    case .collection:
      let viewController = CollectionViewController()
      self.navigationController?.pushViewController(viewController, animated: true)
    }
  }
}
