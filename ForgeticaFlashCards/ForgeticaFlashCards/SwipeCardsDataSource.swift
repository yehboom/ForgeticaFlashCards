//
//  SwipeCardsDataSource.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/3.
//  Copyright © 2020 depaul. All rights reserved.
//

import UIKit
protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> SwipeCardView
    func emptyView() -> UIView?
    
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: SwipeCardView)
}

