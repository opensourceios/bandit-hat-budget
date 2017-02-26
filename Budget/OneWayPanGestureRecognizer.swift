//
//  OneWayPanGestureRecognizer.swift
//  Volley-iOS
//
//  Created by Daniel Gauthier on 2015-06-15.
//  Copyright (c) 2015 Volley. All rights reserved.
//

import UIKit

enum OneWayPanGestureDirection {
  case up
  case down
}

class OneWayPanGestureRecognizer: UIPanGestureRecognizer {
  var drag: Bool = false
  var moveX: Int = 0
  var moveY: Int = 0
  var direction: OneWayPanGestureDirection = .down
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
    super.touchesMoved(touches, with: event)
    
    if state == UIGestureRecognizerState.failed {
      return
    }
    
    let touch: UITouch = touches.first! as UITouch
    let nowPoint: CGPoint = touch.location(in: view)
    let prevPoint: CGPoint = touch.previousLocation(in: view)
    moveX += Int(prevPoint.x - nowPoint.x)
    moveY += Int(prevPoint.y - nowPoint.y)
    
    if !drag {
      if (direction == .down && moveY > 0) || (direction == .up && moveY < 0) {
        state = .failed
      } else {
        drag = true
      }
    }
  }
  
  override func reset() {
    super.reset()
    drag = false
    moveX = 0
    moveY = 0
  }
}
