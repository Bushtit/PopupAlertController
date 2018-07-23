//
//  PopupDefaultViewController.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import UIKit

final public class PopupDefaultViewController: UIViewController {

    public var standardView: PopupDefaultView {
       return view as! PopupDefaultView // swiftlint:disable:this force_cast
    }

    override public func loadView() {
        super.loadView()
        view = PopupDefaultView(frame: .zero)
    }
}

public extension PopupDefaultViewController {

    // MARK: - Setter / Getter

    // MARK: Content

    /// The dialog image
    public var image: UIImage? {
        get { return standardView.imageView.image }
        set {
            standardView.imageView.image = newValue
            standardView.imageHeightConstraint?.constant = standardView.imageView.pv_heightForImageView()
        }
    }

    /// The title text of the dialog
    public var titleText: String? {
        get { return standardView.titleLabel.text }
        set {
            standardView.titleLabel.text = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }

    /// The message text of the dialog
    public var messageText: String? {
        get { return standardView.messageLabel.text }
        set {
            standardView.messageLabel.text = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }

    // MARK: Appearance

    /// The font and size of the title label
    @objc public dynamic var titleFont: UIFont {
        get { return standardView.titleFont }
        set {
            standardView.titleFont = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }

    /// The color of the title label
    @objc public dynamic var titleColor: UIColor? {
        get { return standardView.titleLabel.textColor }
        set {
            standardView.titleColor = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }

    /// The text alignment of the title label
    @objc public dynamic var titleTextAlignment: NSTextAlignment {
        get { return standardView.titleTextAlignment }
        set {
            standardView.titleTextAlignment = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }

    /// The font and size of the body label
    @objc public dynamic var messageFont: UIFont {
        get { return standardView.messageFont}
        set {
            standardView.messageFont = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }

    /// The color of the message label
    @objc public dynamic var messageColor: UIColor? {
        get { return standardView.messageColor }
        set {
            standardView.messageColor = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }

    /// The text alignment of the message label
    @objc public dynamic var messageTextAlignment: NSTextAlignment {
        get { return standardView.messageTextAlignment }
        set {
            standardView.messageTextAlignment = newValue
            standardView.pv_layoutIfNeededAnimated()
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        standardView.imageHeightConstraint?.constant = standardView.imageView.pv_heightForImageView()
    }
}
