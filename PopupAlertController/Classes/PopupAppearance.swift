//
//  PopupAppearance.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

public struct PopupAppearance {
    
    public var titleFont: UIFont = UIFont(name: "HelveticaNeue-Light", size: 16) ?? UIFont.boldSystemFont(ofSize: 16)
    public var titleColor: UIColor?
    public var messageFont: UIFont = UIFont(name: "HelveticaNeue", size: 14) ?? UIFont.systemFont(ofSize: 14)
    public var messageColor: UIColor?
    
    public var backgroundColor: UIColor? = UIColor.white
    public var cornerRadius: Float = 2.00
    public var isShadowEnabled: Bool = true
    public var shadowColor: UIColor?
    
    public var isBlurEnabled: Bool = true
    public var blurRadius: CGFloat = 30.00
    public var isLiveBlurEnabled: Bool = true
    public var overlayoOpacity: CGFloat = 0.70
    public var overlayColor: UIColor?
    
    public var buttonFont: UIFont = UIFont(name: "HelveticaNeue-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14)
    public var buttonColor: UIColor? = UIColor.white
    public var buttonSeparatorColor: UIColor? = UIColor(white: 0.90, alpha: 1.00)
    
    public var normalButtonTitleColor: UIColor = UIColor(red: 0.25, green: 0.53, blue: 0.91, alpha: 1.00)
    public var cancelButtonTitleColor: UIColor = UIColor.lightGray
    public var destructiveButtonTitleColor: UIColor = UIColor.red
    
    public private(set) static var light: PopupAppearance = {
        let appearance = PopupAppearance.init()
        return appearance
    }()
    
    public private(set) static var dark: PopupAppearance = {
        var appearance = PopupAppearance.init()
        appearance.titleColor = UIColor.white
        appearance.messageColor = UIColor.init(white: 0.80, alpha: 1.00)
        appearance.backgroundColor = UIColor.init(red: 0.23, green: 0.23, blue: 0.27, alpha: 1.00)
        appearance.shadowColor = UIColor.black
        appearance.overlayColor = UIColor.black
        appearance.buttonColor = UIColor.init(red: 0.23, green: 0.23, blue: 0.27, alpha: 1.00)
        appearance.buttonSeparatorColor = UIColor(red: 0.20, green: 0.20, blue: 0.25, alpha: 1.00)
        appearance.normalButtonTitleColor = UIColor.white
        appearance.cancelButtonTitleColor = UIColor.init(white: 0.60, alpha: 1.00)
        return appearance
    }()
    
    public func apply() {
        let pva = PopupDefaultView.appearance()
        pva.titleFont    = titleFont
        pva.titleColor   = titleColor
        pva.messageFont  = messageFont
        pva.messageColor = messageColor
        
        let pcva = PopupContainerView.appearance()
        pcva.backgroundColor = backgroundColor
        pcva.cornerRadius    = cornerRadius
        pcva.shadowEnabled   = isShadowEnabled
        pcva.shadowColor     = shadowColor
        
        let ova = PopupOverlayView.appearance()
        ova.blurEnabled     = isBlurEnabled
        ova.blurRadius      = blurRadius
        ova.liveBlurEnabled = isLiveBlurEnabled
        ova.opacity         = overlayoOpacity
        ova.color           = overlayColor
        
        let dba = PopupNormalButton.appearance()
        dba.titleFont      = buttonFont
        dba.titleColor     = normalButtonTitleColor
        dba.buttonColor    = buttonColor
        dba.separatorColor = buttonSeparatorColor
        
        let cba = PopupCancelButton.appearance()
        cba.titleFont      = buttonFont
        cba.titleColor     = cancelButtonTitleColor
        cba.buttonColor    = buttonColor
        cba.separatorColor = buttonSeparatorColor
        
        let dtba = PopupDestructiveButton.appearance()
        dtba.titleFont      = buttonFont
        dtba.titleColor     = destructiveButtonTitleColor
        dtba.buttonColor    = buttonColor
        dtba.separatorColor = buttonSeparatorColor
    }
}
