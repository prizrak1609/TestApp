//
//  Button.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

// create custom class because https://stackoverflow.com/questions/28461889/extending-uikit-class-with-swift-breaks-interface-builder
final class Button: UIButton {

    func shake() {
        let startPos = layer.position.x
        CATransaction.begin()
        let anim = CABasicAnimation(keyPath: "position.x")
        anim.repeatCount = 4
        anim.autoreverses = true
        anim.duration = 0.05
        anim.fromValue = layer.position.x - 3
        anim.toValue = layer.position.x + 3
        anim.isRemovedOnCompletion = true
        CATransaction.setCompletionBlock { [weak self] in
            guard let welf = self else { return }
            welf.layer.position.x = startPos
        }
        layer.add(anim, forKey: nil)
        CATransaction.commit()
    }
}
