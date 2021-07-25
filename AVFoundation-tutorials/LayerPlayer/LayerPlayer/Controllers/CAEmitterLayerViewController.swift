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

class CAEmitterLayerViewController: UIViewController {
  @IBOutlet weak var viewForEmitterLayer: UIView!

  @objc var emitterLayer = CAEmitterLayer()
  @objc var emitterCell = CAEmitterCell()

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    setUpEmitterCell()
    setUpEmitterLayer()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "DisplayEmitterControls" {
      (segue.destination as? CAEmitterLayerControlsViewController)?.emitterLayerViewController = self
    }
  }
}

// MARK: - Layer setup
extension CAEmitterLayerViewController {
  
  func setUpEmitterLayer() {
    // 1
    self.resetEmitterCells()
    self.emitterLayer.frame = self.viewForEmitterLayer.bounds
    self.viewForEmitterLayer.layer.addSublayer(self.emitterLayer)
    // 2
    self.emitterLayer.seed = UInt32(Date().timeIntervalSince1970)
    // 3
    self.emitterLayer.emitterPosition = CGPoint(
      x: self.viewForEmitterLayer.bounds.midX * 1.5,
      y: self.viewForEmitterLayer.bounds.midY
    )
    // 4
    self.emitterLayer.renderMode = .additive
  }

  func setUpEmitterCell() {
    // 1
    self.emitterCell.contents = UIImage(named: "smallStar")?.cgImage
    // 2
    self.emitterCell.velocity = 50.0
    self.emitterCell.velocityRange = 500.0
    // 3
    self.emitterCell.color = UIColor.black.cgColor
    // 4
    self.emitterCell.redRange = 1.0
    self.emitterCell.greenRange = 1.0
    self.emitterCell.blueRange = 1.0
    self.emitterCell.alphaRange = 0.0
    self.emitterCell.redSpeed = 0.0
    self.emitterCell.greenSpeed = 0.0
    self.emitterCell.blueSpeed = 0.0
    self.emitterCell.alphaSpeed = -0.5
    self.emitterCell.scaleSpeed = 0.1
    // 5
    let zeroDegreesInRadians = degreesToRadians(0.0)
    self.emitterCell.spin = degreesToRadians(130.0)
    self.emitterCell.spinRange = zeroDegreesInRadians
    self.emitterCell.emissionLatitude = zeroDegreesInRadians
    self.emitterCell.emissionLongitude = zeroDegreesInRadians
    self.emitterCell.emissionRange = degreesToRadians(360.0)
    // 6
    self.emitterCell.lifetime = 1.0
    self.emitterCell.birthRate = 250.0
    // 7
    self.emitterCell.xAcceleration = -800
    self.emitterCell.yAcceleration = 1000
  }

  func resetEmitterCells() {
    emitterLayer.emitterCells = nil
    emitterLayer.emitterCells = [emitterCell]
  }
}

// MARK: - Triggered actions
extension CAEmitterLayerViewController {
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let location = touches.first?.location(in: viewForEmitterLayer) {
      emitterLayer.emitterPosition = location
    }
  }

  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let location = touches.first?.location(in: viewForEmitterLayer) {
      emitterLayer.emitterPosition = location
    }
  }
}
