//
//  Utils.swift
//  ARUIKit
//
//  Created by Doug Gandle on 7/1/18.
//  Copyright © 2018 Doug Gandle. All rights reserved.
//

import Foundation
import ARKit

let scaleFactor: CGFloat = 10000

//extension SCNView {
//
//    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: self) else { return }
//        let result = self.hitTest(point, options: nil)
//        if let node = result.first?.node as? ARUIView {
//            node.touchesBegan(touches, with: event)
//        }
//    }
//
//    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: self) else { return }
//        let result = self.hitTest(point, options: nil)
//        if let node = result.first?.node as? ARUIView {
//            node.touchesMoved(touches, with: event)
//        }
//    }
//
//    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: self) else { return }
//        let result = self.hitTest(point, options: nil)
//        if let node = result.first?.node as? ARUIView {
//            node.touchesEnded(touches, with: event)
//        }
//    }
//
//    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let point = touches.first?.location(in: self) else { return }
//        let result = self.hitTest(point, options: nil)
//        if let node = result.first?.node as? ARUIView {
//            node.touchesEnded(touches, with: event)
//        }
//    }
//
//}
