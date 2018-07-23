//
//  PopupAlertController.swift
//
//  Copyright (c) 2016 Bushtit Lab. (https://github.com/Bushtit/)
//

import Foundation
import UIKit

/// Creates a Popup dialog similar to UIAlertController
final public class PopupAlertController: UIViewController {

    // MARK: Private / Internal

    /// First init flag
    fileprivate var initialized = false
    
    /// StatusBar display related
    fileprivate let hideStatusBar: Bool
    fileprivate var statusBarShouldBeHidden: Bool = false
    
    /// Width for iPad displays
    fileprivate let preferredWidth: CGFloat

    /// The completion handler
    fileprivate var completion: (() -> Void)?

    /// The custom transition presentation manager
    fileprivate var presentationManager: PresentationManager!

    /// Interactor class for pan gesture dismissal
    fileprivate lazy var interactor = InteractiveTransition()

    /// Returns the controllers view
    internal var popupContainerView: PopupContainerView {
        return view as! PopupContainerView // swiftlint:disable:this force_cast
    }

    /// The set of buttons
    fileprivate var buttons = [PopupButton]()

    /// Whether keyboard has shifted view
    internal var keyboardShown = false

    /// Keyboard height
    internal var keyboardHeight: CGFloat?

    // MARK: Public

    /// The content view of the popup dialog
    public var viewController: UIViewController

    /// Whether or not to shift view for keyboard display
    public var keyboardShiftsView = true

    // MARK: - Initializers

    /*!
     Creates a standard popup dialog with title, message and image field

     - parameter title:            The dialog title
     - parameter message:          The dialog message
     - parameter image:            The dialog image
     - parameter buttonAlignment:  The dialog button alignment
     - parameter transitionStyle:  The dialog transition style
     - parameter preferredWidth:   The preferred width for iPad screens
     - parameter tapGestureDismissal: Indicates if dialog can be dismissed via tap gesture
     - parameter panGestureDismissal: Indicates if dialog can be dismissed via pan gesture
     - parameter hideStatusBar:    Whether to hide the status bar on PopupAlertController presentation
     - parameter completion:       Completion block invoked when dialog was dismissed

     - returns: Popup dialog default style
     */
    @objc public convenience init(
                title: String?,
                message: String?,
                image: UIImage? = nil,
                buttonAlignment: UILayoutConstraintAxis = .vertical,
                transitionStyle: PopupTransitionStyle = .bounceUp,
                preferredWidth: CGFloat = 340,
                tapGestureDismissal: Bool = true,
                panGestureDismissal: Bool = true,
                hideStatusBar: Bool = false,
                completion: (() -> Void)? = nil) {

        // Create and configure the standard popup dialog view
        let viewController = PopupDefaultViewController()
        viewController.titleText   = title
        viewController.messageText = message
        viewController.image       = image

        // Call designated initializer
        self.init(viewController: viewController,
                  buttonAlignment: buttonAlignment,
                  transitionStyle: transitionStyle,
                  preferredWidth: preferredWidth,
                  tapGestureDismissal: tapGestureDismissal,
                  panGestureDismissal: panGestureDismissal,
                  hideStatusBar: hideStatusBar,
                  completion: completion)
    }

    /*!
     Creates a popup dialog containing a custom view

     - parameter viewController:   A custom view controller to be displayed
     - parameter buttonAlignment:  The dialog button alignment
     - parameter transitionStyle:  The dialog transition style
     - parameter preferredWidth:   The preferred width for iPad screens
     - parameter tapGestureDismissal: Indicates if dialog can be dismissed via tap gesture
     - parameter panGestureDismissal: Indicates if dialog can be dismissed via pan gesture
     - parameter hideStatusBar:    Whether to hide the status bar on PopupAlertController presentation
     - parameter completion:       Completion block invoked when dialog was dismissed

     - returns: Popup dialog with a custom view controller
     */
    @objc public init(
        viewController: UIViewController,
        buttonAlignment: UILayoutConstraintAxis = .vertical,
        transitionStyle: PopupTransitionStyle = .bounceUp,
        preferredWidth: CGFloat = 340,
        tapGestureDismissal: Bool = true,
        panGestureDismissal: Bool = true,
        hideStatusBar: Bool = false,
        completion: (() -> Void)? = nil) {

        self.viewController = viewController
        self.preferredWidth = preferredWidth
        self.hideStatusBar = hideStatusBar
        self.completion = completion
        super.init(nibName: nil, bundle: nil)

        // Init the presentation manager
        presentationManager = PresentationManager(transitionStyle: transitionStyle, interactor: interactor)

        // Assign the interactor view controller
        interactor.viewController = self

        // Define presentation styles
        transitioningDelegate = presentationManager
        modalPresentationStyle = .custom
        
        // StatusBar setup
        modalPresentationCapturesStatusBarAppearance = true

        // Add our custom view to the container
        addChildViewController(viewController)
        popupContainerView.stackView.insertArrangedSubview(viewController.view, at: 0)
        popupContainerView.buttonStackView.axis = buttonAlignment
        viewController.didMove(toParentViewController: self)

        // Allow for dialog dismissal on background tap
        if tapGestureDismissal {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tapRecognizer.cancelsTouchesInView = false
            popupContainerView.addGestureRecognizer(tapRecognizer)
        }
        // Allow for dialog dismissal on dialog pan gesture
        if panGestureDismissal {
            let panRecognizer = UIPanGestureRecognizer(target: interactor, action: #selector(InteractiveTransition.handlePan))
            panRecognizer.cancelsTouchesInView = false
            popupContainerView.stackView.addGestureRecognizer(panRecognizer)
        }
    }

    // Init with coder not implemented
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View life cycle

    /// Replaces controller view with popup view
    public override func loadView() {
        view = PopupContainerView(frame: UIScreen.main.bounds, preferredWidth: preferredWidth)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()

        guard !initialized else { return }
        appendButtons()
        initialized = true
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        statusBarShouldBeHidden = hideStatusBar
        UIView.animate(withDuration: 0.15) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }

    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }

    deinit {
        completion?()
        completion = nil
    }

    // MARK: - Dismissal related

    @objc fileprivate func handleTap(_ sender: UITapGestureRecognizer) {

        // Make sure it's not a tap on the dialog but the background
        let point = sender.location(in: popupContainerView.stackView)
        guard !popupContainerView.stackView.point(inside: point, with: nil) else { return }
        dismiss()
    }

    /*!
     Dismisses the popup dialog
     */
    @objc public func dismiss(_ completion: (() -> Void)? = nil) {
        self.dismiss(animated: true) {
            completion?()
        }
    }

    // MARK: - Button related

    /*!
     Appends the buttons added to the popup dialog
     to the placeholder stack view
     */
    fileprivate func appendButtons() {
        
        // Add action to buttons
        let stackView = popupContainerView.stackView
        let buttonStackView = popupContainerView.buttonStackView
        if buttons.isEmpty {
            stackView.removeArrangedSubview(popupContainerView.buttonStackView)
        }
        
        for (index, button) in buttons.enumerated() {
            button.needsLeftSeparator = buttonStackView.axis == .horizontal && index > 0
            buttonStackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }

    /*!
     Adds a single PopupButton to the Popup dialog
     - parameter button: A PopupButton instance
     */
    @objc public func addButton(_ button: PopupButton) {
        buttons.append(button)
    }

    /*!
     Adds an array of PopupButtons to the Popup dialog
     - parameter buttons: A list of PopupButton instances
     */
    @objc public func addButtons(_ buttons: [PopupButton]) {
        self.buttons += buttons
    }

    /// Calls the action closure of the button instance tapped
    @objc fileprivate func buttonTapped(_ button: PopupButton) {
        if button.dismissOnTap {
            dismiss({ button.buttonAction?() })
        } else {
            button.buttonAction?()
        }
    }

    /*!
     Simulates a button tap for the given index
     Makes testing a breeze
     - parameter index: The index of the button to tap
     */
    public func tapButtonWithIndex(_ index: Int) {
        let button = buttons[index]
        button.buttonAction?()
    }
    
    // MARK: - StatusBar display related
    
    public override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
    
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
}

// MARK: - View proxy values

extension PopupAlertController {

    /// The button alignment of the alert dialog
    @objc public var buttonAlignment: UILayoutConstraintAxis {
        get {
            return popupContainerView.buttonStackView.axis
        }
        set {
            popupContainerView.buttonStackView .axis = newValue
            popupContainerView.pv_layoutIfNeededAnimated()
        }
    }

    /// The transition style
    @objc public var transitionStyle: PopupTransitionStyle {
        get { return presentationManager.transitionStyle }
        set { presentationManager.transitionStyle = newValue }
    }
}

// MARK: - Shake

extension PopupAlertController {
    
    /// Performs a shake animation on the dialog
    @objc public func shake() {
        popupContainerView.pv_shake()
    }
}
