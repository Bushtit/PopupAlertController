//
//  UIImageView+Calculations.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

internal extension UIImageView {

    /*!
     Calculates the height of the the UIImageView has to
     have so the image is displayed correctly
     - returns: Height to set on the imageView
     */
    internal func pv_heightForImageView() -> CGFloat {
        guard let image = image, image.size.height > 0 else {
            return 0.0
        }
        let width = bounds.size.width
        let ratio = image.size.height / image.size.width
        return width * ratio
    }
}
