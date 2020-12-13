//
//  CardsDataModel.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/3.
//  Copyright © 2020 depaul. All rights reserved.
//
import UIKit
struct CardsDataModel {
    
    var bgColor: UIColor
    var text : String
    var image : String
    var text2 : String
      
    init(bgColor: UIColor, text: String, image: String, text2: String) {
        self.bgColor = bgColor
        self.text = text
        self.image = image
        self.text2 = text2;
    
    }
}

