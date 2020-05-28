//
//  Movie.swift
//  Tutorial5
//
//  Created by Sunny on 24/3/20.
//  Copyright © 2020 Lindsay Wells. All rights reserved.
//

public struct Raffle
{
    var ID:Int32 = -1
    var title:String
    var price:Int32
    var max_ticket:Int32
    var description:String
    var prize:String
    var status:Int32 // 0 = not activate, 1 = activate,3 = Drew
    var ticketSold:Int32
    var winnerNo:Int32 //up to 3 winner
    
}
