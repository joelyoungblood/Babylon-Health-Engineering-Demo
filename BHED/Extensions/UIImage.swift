//
//  UIImage.swift
//  BHED
//
//  Created by Joel Youngblood on 5/25/19.
//  Copyright © 2019 Joel Youngblood. All rights reserved.
//

import UIKit

extension UIImage {
    func tintColor(_ color: UIColor) -> UIImage {
        let image = self
        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, image.scale)
        let ctx = UIGraphicsGetCurrentContext()!
        image.draw(in: rect)
        ctx.setFillColor(color.cgColor)
        ctx.setBlendMode(.sourceAtop)
        ctx.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
}
