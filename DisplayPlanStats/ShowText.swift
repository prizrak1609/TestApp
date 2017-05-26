//
//  ShowText.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 24.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import CRToast

func showText(_ string: String, time: TimeInterval = 2, onTap: @escaping () -> Void = {}) {
    let interaction = CRToastInteractionResponder(interactionType: .all, automaticallyDismiss: true) { _ in
        onTap()
    }
    let options: [String : Any] = [kCRToastTextKey : string,
                                   kCRToastTextAlignmentKey : NSNumber(value: NSTextAlignment.center.rawValue),
                                   kCRToastBackgroundColorKey : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                                   kCRToastTextColorKey : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                                   kCRToastAnimationInTypeKey : NSNumber(value: CRToastAnimationType.gravity.rawValue),
                                   kCRToastAnimationOutTypeKey : NSNumber(value: CRToastAnimationType.gravity.rawValue),
                                   kCRToastAnimationInDirectionKey : NSNumber(value: CRToastAnimationDirection.left.rawValue),
                                   kCRToastAnimationOutDirectionKey : NSNumber(value: CRToastAnimationDirection.right.rawValue),
                                   kCRToastNotificationTypeKey : NSNumber(value: CRToastType.navigationBar.rawValue),
                                   // swiftlint:disable:next force_unwrapping
                                   kCRToastInteractionRespondersKey : [interaction!],
                                   kCRToastNotificationPresentationTypeKey : NSNumber(value: CRToastPresentationType.cover.rawValue),
                                   kCRToastTimeIntervalKey: NSNumber(value: time)]
    CRToastManager.showNotification(options: options, completionBlock: nil)
}
