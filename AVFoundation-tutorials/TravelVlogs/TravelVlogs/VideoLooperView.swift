/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import AVFoundation

class VideoLooperView: UIView {
  
  let clips: [VideoClip]
  let videoPlayerView = VideoPlayerView()
  
  private let player = AVQueuePlayer()
  private var token: NSKeyValueObservation?
  
  init(clips: [VideoClip]) {
    self.clips = clips
    
    super.init(frame: .zero)
    
    self.initializePlayer()
    self.addGestureRecognizers()
  }
  
  // MARK - Unnecessary but necessary Code
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initializePlayer() {
    self.videoPlayerView.player = self.player
    self.addAllVideosToPlayer()
    self.player.volume = 0.0
    self.player.play()
    
    self.token = self.player.observe(\.currentItem) { [weak self] player, _ in
      if player.items().count == 1 {
        self?.addAllVideosToPlayer()
      }
    }
  }
  
  private func addAllVideosToPlayer() {
    for video in self.clips {
      // 1
      let asset = AVURLAsset(url: video.url)
      let item = AVPlayerItem(asset: asset)
      // 2
      self.player.insert(item, after: self.player.items().last)
    }
  }
  
  func pause() {
    self.player.pause()
  }
  
  func play() {
    self.player.play()
  }
  
  @objc func wasTapped() {
    self.player.volume = self.player.volume == 1.0 ? 0.0 : 1.0
  }
  
  @objc func wasDoubleTapped() {
    self.player.rate = self.player.rate == 1.0 ? 2.0 : 1.0
  }
  
  func addGestureRecognizers() {
    // 1
    let tap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasTapped))
    let doubleTap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasDoubleTapped))
    doubleTap.numberOfTapsRequired = 2
    // 2
    tap.require(toFail: doubleTap)
    // 3
    self.addGestureRecognizer(tap)
    self.addGestureRecognizer(doubleTap)
  }
}
