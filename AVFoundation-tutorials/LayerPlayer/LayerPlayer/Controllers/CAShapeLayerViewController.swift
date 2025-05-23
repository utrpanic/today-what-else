/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class CAShapeLayerViewController: UIViewController {
  @IBOutlet weak var viewForShapeLayer: UIView!
  @IBOutlet weak var hueSlider: UISlider!
  @IBOutlet weak var lineWidthSlider: UISlider!
  @IBOutlet weak var lineDashSwitch: UISwitch!
  @IBOutlet weak var lineCapSegmentedControl: UISegmentedControl!
  @IBOutlet weak var lineJoinSegmentedControl: UISegmentedControl!

  enum LineCap: Int {
    case butt, round, square, cap
  }
  enum LineJoin: Int {
    case miter, round, bevel
  }

  let shapeLayer = CAShapeLayer()
  var color = swiftOrangeColor
  let openPath = UIBezierPath()
  let closedPath = UIBezierPath()

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpPath()
    setUpShapeLayer()
  }
}

// MARK: - Layer setup
extension CAShapeLayerViewController {
  
  func setUpPath() {
    self.openPath.move(to: CGPoint(x: 30.0, y: 196.0))
    
    self.openPath.addCurve(
      to: CGPoint(x: 112.0, y: 12.5),
      controlPoint1: CGPoint(x: 110.56, y: 13.79),
      controlPoint2: CGPoint(x: 112.07, y: 13.01)
    )
    
    self.openPath.addCurve(
      to: CGPoint(x: 194.0, y: 196.0),
      controlPoint1: CGPoint(x: 111.9, y: 11.81),
      controlPoint2: CGPoint(x: 194.0, y: 196.0)
    )
    
    self.openPath.addLine(to: CGPoint(x: 30.0, y: 85.68))
    self.openPath.addLine(to: CGPoint(x: 194.0, y: 48.91))
    self.openPath.addLine(to: CGPoint(x: 30.0, y: 196.0))
  }

  func setUpShapeLayer() {
    // 1
    self.shapeLayer.path = self.openPath.cgPath
    // 2
    self.shapeLayer.lineCap = .butt
    self.shapeLayer.lineJoin = .miter
    self.shapeLayer.miterLimit = 4.0
    // 3
    self.shapeLayer.lineWidth = CGFloat(self.lineWidthSlider.value)
    self.shapeLayer.strokeColor = swiftOrangeColor.cgColor
    self.shapeLayer.fillColor = UIColor.white.cgColor
    // 4
    self.shapeLayer.lineDashPattern = nil
    self.shapeLayer.lineDashPhase = 0.0
    
    self.viewForShapeLayer.layer.addSublayer(self.shapeLayer)
  }
}

// MARK: - IBActions
extension CAShapeLayerViewController {
  @IBAction func hueSliderChanged(_ sender: UISlider) {
    let hue = CGFloat(sender.value / 359.0)
    let color = UIColor(hue: hue, saturation: 0.81, brightness: 0.97, alpha: 1.0)
    shapeLayer.strokeColor = color.cgColor
    self.color = color
  }

  @IBAction func lineWidthSliderChanged(_ sender: UISlider) {
    shapeLayer.lineWidth = CGFloat(sender.value)
  }

  @IBAction func lineDashSwitchChanged(_ sender: UISwitch) {
    if sender.isOn {
      shapeLayer.lineDashPattern = [50, 50]
      shapeLayer.lineDashPhase = 25.0
    } else {
      shapeLayer.lineDashPattern = nil
      shapeLayer.lineDashPhase = 0
    }
  }

  @IBAction func lineCapSegmentedControlChanged(_ sender: UISegmentedControl) {
    shapeLayer.path = openPath.cgPath

    let lineCap: CAShapeLayerLineCap
    switch sender.selectedSegmentIndex {
    case LineCap.round.rawValue:
      lineCap = .round
    case LineCap.square.rawValue:
      lineCap = .square
    default:
      lineCap = .butt
    }

    shapeLayer.lineCap = lineCap
  }

  @IBAction func lineJoinSegmentedControlChanged(_ sender: UISegmentedControl) {
    let lineJoin: CAShapeLayerLineJoin

    switch sender.selectedSegmentIndex {
    case LineJoin.round.rawValue:
      lineJoin = .round
    case LineJoin.bevel.rawValue:
      lineJoin = .bevel
    default:
      lineJoin = .miter
    }

    shapeLayer.lineJoin = lineJoin
  }
}
