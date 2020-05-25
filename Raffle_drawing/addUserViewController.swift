//
//  popupViewController.swift
//  Raffle_drawing
//
//  Created by Sunny on 25/5/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class popupViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //controll
   
    @IBOutlet weak var nameField: UITextField!
    
   
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var mobileField: UITextField!
    @IBAction func ConfirmBtn(_ sender: UIButton) {
    
        let playerName:String = (nameField.text!)
        if (playerName == "")
        {
        let alert = UIAlertController(title: "Missing Information", message: "The Player Name is missing", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in NSLog("The \"cancel\" alert occured.")}))

        }
        let playerEmail:String = (emailField.text!)
        let playerMobile:Int = Int(mobileField.text!) ?? 0
        
        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
       
        
        database.insertPlayer(player:Player(fname:String(playerName),contact_no:Int32(Int(playerMobile)),email:String(playerEmail)))
        
        print("add one player")
    }
    
    
//    func addNewPlayer(){
//        let database : SQLiteDatabase = SQLiteDatabase(databaseName: "MyDatabase")
//        let playerName:String = (nameField.text!)
//        let playerEmail:String = (emailField.text!)
//        let playerMobile:Int = Int(mobileField.text!) ?? 0
//
//        database.insertPlayer(player:Player(fname:String(playerName),contact_no:Int32(Int(playerMobile)),email:String(playerEmail)))
        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
