//
//  CustomViewController.swift
//  Sample
//
//  Created by 李二狗 on 2018-07-24.
//  Copyright © 2018年 Bushtit Lab. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    var titleColor = UIColor.black
    var briefColor = UIColor.lightGray
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var briefLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.clear
        titleLabel.textColor = titleColor
        briefLabel.textColor = briefColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
