//
//  ViewController.swift
//  Sample
//
//  Created by 李二狗 on 2018-07-24.
//  Copyright © 2018年 Bushtit Lab. All rights reserved.
//

import UIKit
import PopupAlertController

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var bgImageView: UIImageView!
    
    // MARK: Actions
    
    var usingDarkTheme = false
    
    @IBAction func applyTheme(_ sender: UIButton) {
        let image: UIImage?
        if usingDarkTheme {
            PopupAppearance.light.apply()
            bgImageView.image = UIImage(named: "cover")
            sender.setTitle("Apply Dark Theme", for: [])
            image = UIImage(named: "light")
        } else {
            PopupAppearance.dark.apply()
            bgImageView.image = UIImage(named: "cover_light")
            sender.setTitle("Apply Light Theme", for: [])
            image = UIImage(named: "dark")
        }
        usingDarkTheme = !usingDarkTheme
        self.showDialog(title: "Theme Changed", message: "You changed the dialog theme.", image: image, buttons: ["OK"], action: nil)
    }
    
    
    @IBAction func showImageDialogTapped(_ sender: UIButton) {
        showImageDialog()
    }
    
    @IBAction func showStandardDialogTapped(_ sender: UIButton) {
        showStandardDialog()
    }
    
    @IBAction func showCustomDialogTapped(_ sender: UIButton) {
        showCustomDialog()
    }
    
    // MARK: Popup Dialog examples
    
    /*!
     Displays the default dialog with an image on top
     */
    func showImageDialog(animated: Bool = true) {
        
        // Prepare the popup assets
        let title = "THIS IS THE DIALOG TITLE"
        let message = "This is the message section of the PopupAlertController default view"
        let image = UIImage(named: "tree")
        
        // Create the dialog
        let popup = PopupAlertController(title: title, message: message, image: image, preferredWidth: 580)
        
        // Create first button
        let buttonOne = PopupCancelButton(title: "CANCEL") { 
            print("You canceled the image dialog")
        }
        
        // Create fourth (shake) button
        let buttonTwo = PopupDestructiveButton(title: "SHAKE", dismissOnTap: false) { [weak popup] in
            popup?.shake()
        }
        
        // Create second button
        let buttonThree = PopupNormalButton(title: "OK") {
            print("You ok'd the image dialog")
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo, buttonThree])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    /*!
     Displays the default dialog without image, just as the system dialog
     */
    func showStandardDialog(animated: Bool = true) {
        
        // Prepare the popup
        let title = "THIS IS A DIALOG WITHOUT IMAGE"
        let message = "If you don't pass an image to the default dialog, it will display just as a regular dialog. Moreover, this features the zoom transition"
        
        // Create the dialog
        let popup = PopupAlertController(title: title,
                                         message: message,
                                         buttonAlignment: .horizontal,
                                         transitionStyle: .zoomIn,
                                         tapGestureDismissal: true,
                                         panGestureDismissal: true,
                                         hideStatusBar: true) {
                                            print("Completed")
        }
        
        // Create first button
        let buttonOne = PopupCancelButton(title: "CANCEL") {
            print("You canceled the default dialog")
        }
        
        // Create second button
        let buttonTwo = PopupNormalButton(title: "OK") {
            print("You ok'd the default dialog")
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        self.present(popup, animated: animated, completion: nil)
    }
    
    /*!
     Displays a custom view controller instead of the default view.
     Buttons can be still added, if needed
     */
    func showCustomDialog(animated: Bool = true) {
        
        // Create a custom view controller
        let controller = CustomViewController.init(nibName: "CustomViewController", bundle: .main)
        
        if usingDarkTheme {
            controller.titleColor = PopupAppearance.dark.titleColor ?? UIColor.white
            controller.briefColor = PopupAppearance.dark.messageColor ?? UIColor.lightGray
        }
        // Create the dialog
        let popup = PopupAlertController(viewController: controller,
                                         buttonAlignment: .horizontal,
                                         transitionStyle: .bounceDown,
                                         tapGestureDismissal: true,
                                         panGestureDismissal: false)
        
        // Create first button
        let buttonOne = PopupCancelButton(title: "CANCEL", height: 60) {
            print("You canceled the custom dialog")
        }
        
        // Create second button
        let buttonTwo = PopupNormalButton(title: "DONE", height: 60) {
            print("You dismissed the custom dialog")
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
    }
}
