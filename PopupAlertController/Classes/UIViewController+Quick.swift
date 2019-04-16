//
//  UIViewController+Quick.swift
//  PopupAlertController
//
//  Created by 李二狗 on 2018-07-24.
//

import Foundation
import UIKit

extension UIViewController {
    open func showDialog(title text: String,
                         message: String,
                         image: UIImage?,
                         buttons: [String],
                         alignment: NSLayoutConstraint.Axis = .horizontal,
                         animated: Bool = true,
                         transition: PopupTransitionStyle = .zoomIn,
                         gestureDismissal: Bool = true,
                         action: ((_ title: String, _ index: Int) -> Void)?,
                         completion: (() -> Void)? = nil) {
        
        // Create the dialog
        let popup = PopupAlertController(title: NSLocalizedString(text, comment: ""),
                                message: NSLocalizedString(message, comment: ""),
                                image: image,
                                buttonAlignment: alignment,
                                transitionStyle: transition,
                                tapGestureDismissal: gestureDismissal,
                                panGestureDismissal: gestureDismissal,
                                hideStatusBar: true,
                                completion: completion)
        
        var actions = [PopupButton]()
        for btn in buttons {
            if let index = buttons.firstIndex(of: btn) {
                actions.append(PopupNormalButton.init(title: NSLocalizedString(btn, comment: "")) {
                    action?(btn, index)
                })
            }
        }
        
        if actions.isEmpty {
            actions.append(PopupCancelButton.init(title: NSLocalizedString("Cancel", comment: "")) {
                action?("Cancel", 0)
            })
        }
        
        // Add buttons to dialog
        popup.addButtons(actions)
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    open func showDialog(controller: UIViewController,
                         buttons: [String],
                         alignment: NSLayoutConstraint.Axis = .horizontal,
                         animated: Bool = true,
                         transition: PopupTransitionStyle = .zoomIn,
                         gestureDismissal: Bool = true,
                         action: ((_ title: String, _ index: Int) -> Void)?,
                         completion: (() -> Void)? = nil) {
        
        // Create the dialog
        let popup = PopupAlertController(viewController: controller,
                                buttonAlignment: alignment,
                                transitionStyle: transition,
                                tapGestureDismissal: gestureDismissal,
                                panGestureDismissal: gestureDismissal,
                                hideStatusBar: true,
                                completion: completion)
        
        var actions = [PopupButton]()
        for btn in buttons {
            if let index = buttons.firstIndex(of: btn) {
                actions.append(PopupNormalButton.init(title: NSLocalizedString(btn, comment: "")) {
                    action?(btn, index)
                })
            }
        }
        
        if actions.isEmpty {
            actions.append(PopupCancelButton.init(title: NSLocalizedString("Cancel", comment: "")) {
                action?("Cancel", 0)
            })
        }
        
        // Add buttons to dialog
        popup.addButtons(actions)
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
}
