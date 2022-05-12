import UIKit

public protocol HasTypeName {
  static var typeName: String { get }
}

extension HasTypeName {
  public static var typeName: String { String(describing: self) }
}

extension UIView: HasTypeName {}

extension UIViewController: HasTypeName {}

public protocol NibLoadable {
  
}

extension NibLoadable where Self: UIViewController {
  
  public static func create(storyboardName: String) -> Self {
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    return storyboard.instantiateViewController(identifier: self.typeName, creator: nil)
  }
}

extension UICollectionView {
  
  public func registerFromClass<T: UICollectionViewCell>(_ cellClass: T.Type) {
    self.register(cellClass, forCellWithReuseIdentifier: T.typeName)
  }
  
  public func registerFromNib<T: UICollectionViewCell>(_ cellClass: T.Type) where T: NibLoadable {
    self.register(UINib(nibName: T.typeName, bundle: nil), forCellWithReuseIdentifier: T.typeName)
  }
  
  public func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.typeName, for: indexPath) as? T else {
      preconditionFailure()
    }
    return cell
  }
}

extension UITableView {
  
  public func registerFromClass<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
    self.register(viewClass, forHeaderFooterViewReuseIdentifier: T.typeName)
  }
  
  public func registerFromNib<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) where T: NibLoadable {
    self.register(UINib(nibName: T.typeName, bundle: nil), forHeaderFooterViewReuseIdentifier: T.typeName)
  }
  
  public func dequeueReusableView<T: UITableViewHeaderFooterView>(_ cellClass: T.Type) -> T {
    guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: T.typeName) as? T else {
      preconditionFailure()
    }
    return view
  }
  
  public func registerFromClass<T: UITableViewCell>(_ cellClass: T.Type) {
    self.register(cellClass, forCellReuseIdentifier: T.typeName)
  }
  
  public func registerFromNib<T: UITableViewCell>(_ cellClass: T.Type) where T: NibLoadable {
    self.register(UINib(nibName: T.typeName, bundle: nil), forCellReuseIdentifier: T.typeName)
  }
  
  public func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
    guard let cell = self.dequeueReusableCell(withIdentifier: T.typeName, for: indexPath) as? T else {
      preconditionFailure()
    }
    return cell
  }
}
