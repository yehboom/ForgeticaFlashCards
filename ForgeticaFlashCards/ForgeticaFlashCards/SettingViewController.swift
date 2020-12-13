//
//  SettingViewController.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/4.
//  Copyright © 2020 depaul. All rights reserved.
//

import UIKit
import MessageUI

class SettingViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var ChangeFont: UILabel!
    @IBOutlet weak var Fontswitch: UISwitch!
    @IBOutlet weak var SendTitle: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SendMail(_ sender: UIButton) {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setToRecipients(["gammmkimo@gmail.com"])
                mail.setSubject("Email Subject Here")
                mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
                present(mail, animated: true)
            } else {
                print("Application is not able to send an email")
            }


    }
    

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    @IBAction func SwitchFont(_ sender: UISwitch) {
        let status = sender.isOn ? "On" : "Off";
        if status == "On"{
            textFont = "SansForgetica-Regular"
        }else{
            textFont = "Futura"
        }
    }
 

}
