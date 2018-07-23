//
//  UIViewController+Visibility.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

// http://stackoverflow.com/questions/2777438/how-to-tell-if-uiviewcontrollers-view-is-visible
internal extension UIViewController {

    internal var isTopAndVisible: Bool {
        return isVisible && isTopViewController
    }

    internal var isVisible: Bool {
        if isViewLoaded {
            return view.window != nil
        }
        return false
    }

    internal var isTopViewController: Bool {
        if self.navigationController != nil {
            return self.navigationController?.visibleViewController === self
        } else if self.tabBarController != nil {
            return self.tabBarController?.selectedViewController == self && self.presentedViewController == nil
        } else {
            return self.presentedViewController == nil && self.isVisible
        }
    }
}
