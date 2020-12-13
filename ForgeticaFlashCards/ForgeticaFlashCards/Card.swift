//
//  Card.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/2.
//  Copyright © 2020 depaul. All rights reserved.
//

import Foundation
var Cards = [Card]();


class Card{
    
    enum `Type`: String {
        case Zero = "Zero"
        case One = "One"
        case Two = "Two"
        case Three = "Three"
        case Four = "Four"
        case Five = "Five"
    }
    
    var CardTitle: String
    var CardDescription : String
    var Star : Int
    var type: Type
    
    init(CardTitle: String,CardDescription : String, Star : Int, type: Type) {
        self.CardTitle=CardTitle;
        self.CardDescription=CardDescription;
        self.Star=Star;
        self.type = type
    }
    
    var getCardDescription :String{
        get{return CardDescription}
    }
    var getCardTitle :String{
          get{return CardTitle}
      }
    
    var getStar :Int{
        get{return Star}
    }
    
    var getType : Type{
        get{return type}
    }
    
    var sort=Cards.sorted { $0.CardTitle < $1.CardTitle };
    
    
}
