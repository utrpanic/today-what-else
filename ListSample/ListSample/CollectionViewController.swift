import UIKit
import TinyConstraints

final class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDragDelegate, UICollectionViewDropDelegate {
  
  var names: [String] = ["Kirby", "Bacchus", "Ferris", "Moai", "Waffle"]
  
  weak var collectionView: UICollectionView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigation()
    self.setupCollectionView()
  }
  
  private func setupNavigation() {
    self.navigationItem.title = "UICollectionView"
  }
  
  private func setupCollectionView() {
    let layout = self.createCollectionViewLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.dataSource = self
    collectionView.dragDelegate = self
    collectionView.dropDelegate = self
    self.view.addSubview(collectionView)
    collectionView.edgesToSuperview()
    self.collectionView = collectionView
    collectionView.registerFromClass(UICollectionViewCell.self)
  }
  
  private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
    let configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.scrollDirection = .vertical
    return UICollectionViewCompositionalLayout(
      sectionProvider: { _, _ in
        let item = NSCollectionLayoutItem(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(64)
          )
        )
        let group = NSCollectionLayoutGroup.horizontal(
          layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(64)
          ),
          subitem: item,
          count: 1
        )
        return NSCollectionLayoutSection(group: group)
      },
      configuration: configuration
    )
  }
  
  // MARK: UICollectionViewDataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.names.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(UICollectionViewCell.self, for: indexPath)
    var content = UIListContentConfiguration.cell()
    content.text = names[indexPath.row]
    cell.contentConfiguration = content
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let moveTarget = self.names.remove(at: sourceIndexPath.row)
    self.names.insert(moveTarget, at: destinationIndexPath.row)
  }
  
  // MARK: UICollectionViewDragDelegate
  
  func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let dragItem = UIDragItem(itemProvider: NSItemProvider())
    dragItem.localObject = self.names[indexPath.row]
    return [dragItem]
  }
  
  // MARK: - UICollectionViewDropDelegate
  
  func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
    guard session.items.count == 1 else { return .init(operation: .cancel) }
    if collectionView.hasActiveDrag {
      return .init(operation: .move, intent: .insertAtDestinationIndexPath)
    } else {
      return .init(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
    let destination: IndexPath
    if let indexPath = coordinator.destinationIndexPath {
      destination = indexPath
    } else {
      let section = 0
      let row = collectionView.numberOfItems(inSection: section)
      destination = IndexPath(row: row, section: section)
    }
    if let item = coordinator.items.first,
       let source = item.sourceIndexPath,
       coordinator.proposal.operation == .move {
      collectionView.performBatchUpdates {
        let target = self.names.remove(at: source.row)
        self.names.insert(target, at: destination.row)
        collectionView.deleteItems(at: [source])
        collectionView.insertItems(at: [destination])
      }
      coordinator.drop(item.dragItem, toItemAt: destination)
    }
  }
}
