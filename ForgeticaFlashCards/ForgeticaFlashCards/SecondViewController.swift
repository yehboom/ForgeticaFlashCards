//
//  SecondViewController.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/2.
//  Copyright © 2020 depaul. All rights reserved.
//

import UIKit

var tempWordSave = String()
var tempDesSave = String()
var EditCard = Card(CardTitle: "", CardDescription: "", Star: 0, type: .Zero);
var isEdit = false;

class SecondViewController: UIViewController,  UITextViewDelegate {

    var Card_edit: Card?
  
    
    @IBOutlet weak var WordTitle: UILabel!
    @IBOutlet weak var WordDescription: UILabel!
    @IBOutlet weak var WordInput: UITextField!
    @IBOutlet weak var DescriptionInput: UITextView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DescriptionInput.delegate=self;
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapButton))
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButton))
        
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
    
        
    }
    
    
    //reload
    override func viewDidAppear(_ animated: Bool) {
             
             if isEdit == true{
                 WordInput.text = EditCard.getCardTitle;
                 DescriptionInput.text = EditCard.getCardDescription;
                 currentStar = EditCard.getStar;
                 reloadStar = currentStar;
                 isEdit = false;
                 tap=true;
             }
    }

    
    @objc func saveButton(){
           print("you save!")
        var message="";
        if WordInput.text == "" || DescriptionInput.text == ""{
            print("Empty")
            if WordInput.text == ""{
               message += "Your Word is empty! \n Please type Word \n"
            }
            
            if DescriptionInput.text == ""{
                message += "Description is empty! \n Please type Description \n"
            }
            
                            
            let title = "Invalid Input"
            let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
                           
            // Create the action.
            let cancelAction = UIAlertAction(title: "OK",style: .cancel,handler: nil)
            alertController.addAction(cancelAction)
           
            present(alertController,animated: true,completion: nil)
            
            return
        }

        
        let title = "Ready to Save?"
                   let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK",style: .default,handler: self.saveAlert(alert:))
            alertController.addAction(OKAction)
     
                                  
                   // Create the action.
                   let cancelAction = UIAlertAction(title: "No",style: .cancel,handler: nil)
        alertController.addAction(cancelAction)
        
        
        present(alertController,animated: true,completion: nil)

       }
    
    func saveAlert(alert: UIAlertAction!)
    {
        if WordInput.text != ""{
                          tempWordSave = WordInput.text!
                      }
                      
                      if DescriptionInput.text != ""{
                          tempDesSave = DescriptionInput.text!;
                      }
                      print("CurrentStar")
                      print(currentStar)
        
        if row != -1 && edit == true && Cards.count != 0{
                        Cards.remove(at: row);
                        edit = false;
                    }
        if tap == false{ currentStar = 0};
        
                      //When save create new card and put
                      if currentStar == 0{
                            Cards.append(Card(CardTitle: tempWordSave,CardDescription:tempDesSave,Star: currentStar,type: .Zero))
                                print("p:0")
                                print(currentStar)
                       
                      }
                      if currentStar == 1{
                          Cards.append(Card(CardTitle: tempWordSave,CardDescription:tempDesSave,Star: currentStar,type: .One))
                       
                          print("p:1")
                          print(currentStar)
                      }
                      if currentStar == 2{
                          Cards.append(Card(CardTitle: tempWordSave,CardDescription:tempDesSave,Star: currentStar,type: .Two))
                           
                          print("p:2")
                          print(currentStar)
                      }
                      if currentStar == 3{
                          Cards.append(Card(CardTitle: tempWordSave,CardDescription:tempDesSave,Star: currentStar,type: .Three))
                           
                          print("p:3")
                          print(currentStar)
                      }
                      if currentStar == 4{
                          Cards.append(Card(CardTitle: tempWordSave,CardDescription:tempDesSave,Star: currentStar,type: .Four))
                          
                          print("p:4")
                          print(currentStar)
                      }
                      if currentStar == 5{
                          Cards.append(Card(CardTitle: tempWordSave,CardDescription:tempDesSave,Star: currentStar,type: .Five))
                          
                          print("p:5")
                          print(currentStar)
                      }
               
                  self.presentingViewController?.dismiss(animated: false, completion:nil)
        
    }
    
    @objc func tapButton(){
        print("you tap!")
        edit = false;
        self.presentingViewController?.dismiss(animated: false, completion:nil)
    }
    
    @IBAction func TypeEnd(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    //for uiTextView
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.backgroundColor = UIColor.white
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.systemGroupedBackground
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

    @IBAction func backgroundTouched(_ sender: UIControl) {
        WordInput.resignFirstResponder()
        DescriptionInput.resignFirstResponder()
        
    }
    
    
   
    

    
}

