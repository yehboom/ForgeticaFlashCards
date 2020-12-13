//
//  CardTableViewController.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/2.
//  Copyright © 2020 depaul. All rights reserved.
//

import UIKit


var row : Int = -1  ;
var edit = false;
class CardTableViewController: UITableViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.clearsSelectionOnViewWillAppear = false
        self.tableView.rowHeight = 80
        self.tableView.estimatedRowHeight = 80
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButton))
               
        self.navigationItem.rightBarButtonItem = rightButton
        
    }

 
    @objc func addButton(){
          print("you add!")
        self.performSegue(withIdentifier: "Edit", sender: nil)
          
      }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Cards.count
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Card=Cards[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Card.type.rawValue, for: indexPath)

         //Configure the cell...
        cell.textLabel?.text = Card.getCardTitle;
        cell.detailTextLabel?.text = Card.getCardDescription

        return cell
    }

    
//delete version02
    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        // Write action code for the trash
        let TrashAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
             Cards.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            print("Update action ...")
            success(true)
        })
        TrashAction.backgroundColor = .red
        TrashAction.image = UIImage(named: "Trash2.png")

       
        // Write action code for the Flag
        let EditAction = UIContextualAction(style: .normal, title:  "", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            
            EditCard=Cards[indexPath.row];
            row = indexPath.row;
            edit = true;
           
            isEdit = true;
            
            self.performSegue(withIdentifier: "Edit", sender: nil)
            success(true)
        })
        EditAction.backgroundColor = .orange
        EditAction.image = UIImage(named: "Edit.png")
        
         return UISwipeActionsConfiguration(actions: [TrashAction,EditAction])
    }
    
    
    

    
    
    //reload
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async { self.tableView.reloadData() }
    }

    //set row's height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0;//Choose your custom row height
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
 
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let detailViewController = segue.destination as? SecondViewController {
           if let indexPath = self.tableView.indexPathForSelectedRow {
               detailViewController.Card_edit = Cards[indexPath.row]
          
          
           }
       }
    }


}
