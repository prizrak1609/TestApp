//
//  UIImage+Ext.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {

    public func resizedProportionaly(to size: CGSize) -> UIImage {
        let widthRatio = size.width / size.width
        let heightRatio = size.height / size.height
        let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(x: 0.0, y: 0.0, width: newSize.width, height: newSize.height))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        return resizedImage
    }

    public func with(tint color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        guard let cgImage = cgImage else { return self }
        context.clip(to: rect, mask: cgImage)
        color.setFill()
        context.fill(rect)
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        return newImage
    }
}
