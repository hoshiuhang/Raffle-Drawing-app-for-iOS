//
//  DetailViewController.swift
//  Tutorial5
//
//  Created by Sunny on 27/4/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    
    //label
 
    @IBOutlet var rTitleLabel: UILabel!
    
    
    @IBOutlet var rPriceLabel: UILabel!
    
    @IBOutlet var rIDLabel: UILabel!
    //
    
    var raffle: Raffle? //store the selected movie
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let displayRaffle = raffle
        {
            rTitleLabel.text = displayRaffle.title
            rPriceLabel.text = String(displayRaffle.price)
            rIDLabel.text = String(displayRaffle.ID)
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
