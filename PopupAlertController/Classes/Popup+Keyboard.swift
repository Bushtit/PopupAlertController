//
//  PopupAlertController+Keyboard.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

/// This extension is designed to handle dialog positioning
/// if a keyboard is displayed while the popup is on top
internal extension PopupAlertController {

    // MARK: - Keyboard & orientation observers

    /*! Add obserservers for UIKeyboard notifications */
    internal func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(orientationChanged),
                                                         name: UIDevice.orientationDidChangeNotification,
                                                         object: nil)

        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(keyboardWillShow),
                                                         name: UIResponder.keyboardWillShowNotification,
                                                         object: nil)

        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(keyboardWillHide),
                                                         name: UIResponder.keyboardWillHideNotification,
                                                         object: nil)

        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(keyboardWillChangeFrame),
                                                         name: UIResponder.keyboardWillChangeFrameNotification,
                                                         object: nil)
    }

    /*! Remove observers */
    internal func removeObservers() {
        NotificationCenter.default.removeObserver(self,
                                                            name: UIDevice.orientationDidChangeNotification,
                                                            object: nil)

        NotificationCenter.default.removeObserver(self,
                                                            name: UIResponder.keyboardWillShowNotification,
                                                            object: nil)

        NotificationCenter.default.removeObserver(self,
                                                            name: UIResponder.keyboardWillHideNotification,
                                                            object: nil)

        NotificationCenter.default.removeObserver(self,
                                                            name: UIResponder.keyboardWillChangeFrameNotification,
                                                            object: nil)
    }

    // MARK: - Actions

    /*!
     Keyboard will show notification listener
     - parameter notification: NSNotification
     */
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        guard isTopAndVisible else { return }
        keyboardShown = true
        centerPopup()
    }

    /*!
     Keyboard will hide notification listener
     - parameter notification: NSNotification
     */
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        guard isTopAndVisible else { return }
        keyboardShown = false
        centerPopup()
    }

    /*!
     Keyboard will change frame notification listener
     - parameter notification: NSNotification
     */
    @objc fileprivate func keyboardWillChangeFrame(_ notification: Notification) {
        guard let keyboardRect = (notification as NSNotification).userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        keyboardHeight = keyboardRect.cgRectValue.height
    }

    /*!
     Listen to orientation changes
     - parameter notification: NSNotification
     */
    @objc fileprivate func orientationChanged(_ notification: Notification) {
        if keyboardShown { centerPopup() }
    }

    fileprivate func centerPopup() {

        // Make sure keyboard should reposition on keayboard notifications
        guard keyboardShiftsView else { return }

        // Make sure a valid keyboard height is available
        guard let keyboardHeight = keyboardHeight else { return }

        // Calculate new center of shadow background
        let popupCenter =  keyboardShown ? keyboardHeight / -2 : 0

        // Reposition and animate
        popupContainerView.centerYConstraint?.constant = popupCenter
        popupContainerView.pv_layoutIfNeededAnimated()
    }
}
