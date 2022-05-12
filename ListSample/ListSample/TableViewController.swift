import UIKit
import TinyConstraints

final class TableViewController: UIViewController, UITableViewDataSource, UITableViewDragDelegate {
  
  var names: [String] = ["Kirby", "Bacchus", "Ferris", "Moai", "Waffle"]
  
  weak var tableView: UITableView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigation()
    self.setupTableView()
  }
  
  private func setupNavigation() {
    self.navigationItem.title = "UITableView"
  }
  
  private func setupTableView() {
    let tableView = UITableView()
    tableView.dataSource = self
    tableView.dragDelegate = self
    self.view.addSubview(tableView)
    tableView.edgesToSuperview()
    self.tableView = tableView
    tableView.registerFromClass(UITableViewCell.self)
  }
  
  // MARK: UITableViewDataSource
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.names.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(UITableViewCell.self, for: indexPath)
    cell.selectionStyle = .none
    var content = cell.defaultContentConfiguration()
    content.text = names[indexPath.row]
    cell.contentConfiguration = content
    return cell
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let moveTarget = self.names.remove(at: sourceIndexPath.row)
    self.names.insert(moveTarget, at: destinationIndexPath.row)
  }
  
  // MARK: - UITableViewDragDelegate
  
  func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let dragItem = UIDragItem(itemProvider: NSItemProvider())
    dragItem.localObject = self.names[indexPath.row]
    return [dragItem]
  }
}
