//
//  ViewController.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/3.
//  Copyright © 2020 depaul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var newCards = [Card]();
    var viewModelData = [CardsDataModel]();
    
    private func load(){
        viewModelData = [CardsDataModel]();
        newCards = [Card]();
        
        for cardnum in Cards{
            newCards.append(cardnum)        }
            newCards.shuffle();
        
        for i in newCards{
            viewModelData.append(CardsDataModel(bgColor: UIColor(red:0.96, green:0.81, blue:0.46, alpha:1.0), text: i.getCardDescription, image: "hamburger",text2: i.getCardTitle))
        }
    }
    

//    //MARK: - Properties
    var stackContainer : StackContainerView!

    //MARK: - Init
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
        stackContainer = StackContainerView()
        view.addSubview(stackContainer)
        configureStackContainer()
        stackContainer.translatesAutoresizingMaskIntoConstraints = false
        configureNavigationBarButtonItem()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        stackContainer.dataSource = self
    }
    
    //reload
       override func viewDidAppear(_ animated: Bool) {
        load();
        stackContainer.reloadData();
          
       }

 
    
    //MARK: - Configurations
    func configureStackContainer() {
        stackContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60).isActive = true
        stackContainer.widthAnchor.constraint(equalToConstant: 350).isActive = true
        stackContainer.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }
    
    func configureNavigationBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(play))
    }
    
    //MARK: - Handlers
    @objc func resetTapped() {
        load();
        stackContainer.reloadData()
    }
    
    @objc func play() {
        if readString != []{
        var voiceType: VoiceType = .undefined
            voiceType = .waveNetFemale
        SpeechService.shared.speak(text: readString[0], voiceType: voiceType) {

            }
            
        }
     }

    
}

extension ViewController : SwipeCardsDataSource {

    func numberOfCardsToShow() -> Int {
        return viewModelData.count
    }
    
    func card(at index: Int) -> SwipeCardView {
        let card = SwipeCardView()
        card.dataSource = viewModelData[index]
        return card
    }
    
    func emptyView() -> UIView? {
        return nil
    }
    

}
