//
//  PopupDefaultButtons.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

// MARK: Default button

/// Represents the default button for the popup dialog
public final class PopupNormalButton: PopupButton {}

// MARK: Cancel button

/// Represents a cancel button for the popup dialog
public final class PopupCancelButton: PopupButton {

    override public func setupView() {
        defaultTitleColor = UIColor.lightGray
        super.setupView()
    }
}

// MARK: destructive button

/// Represents a destructive button for the popup dialog
public final class PopupDestructiveButton: PopupButton {

    override public func setupView() {
        defaultTitleColor = UIColor.red
        super.setupView()
    }
}
