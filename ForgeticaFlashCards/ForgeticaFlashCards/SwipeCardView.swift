//
//  SwipeCardView.swift
//  ForgeticaFlashCards
//
//  Created by Mac on 2020/3/3.
//  Copyright © 2020 depaul. All rights reserved.
//


import UIKit
var textFont = "SansForgetica-Regular"

extension UILabel {
    func addCharactersSpacing(spacing:CGFloat, text:String) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSMakeRange(0, text.count))
        self.attributedText = attributedString
    }
}

class SwipeCardView : UIView {
   
    //MARK: - Properties
    var swipeView : UIView!
    var shadowView : UIView!
    var imageView: UIImageView!
  
    var label2 = UILabel()
    var label = UILabel()
    var moreButton = UIButton()
    
    var delegate : SwipeCardsDelegate?

    var divisor : CGFloat = 0
    let baseView = UIView()

    
    var dataSource : CardsDataModel? {
        didSet {
            swipeView.backgroundColor = dataSource?.bgColor
            label.text = dataSource?.text
            label2.text = dataSource?.text2
        }
    }
    var getTitle: String{
        get{return label2.text!}
    }
    

    
    //MARK: - Init
     override init(frame: CGRect) {
        super.init(frame: .zero)
        configureShadowView()
        configureSwipeView()
        configureLabelView()
        configureLabelView2()
        configureImageView()
        configureButton()
        addPanGestureOnCards()
        configureTapGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configuration
    
    func configureShadowView() {
        shadowView = UIView()
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 4.0
        addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        shadowView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    func configureSwipeView() {
        swipeView = UIView()
        swipeView.layer.cornerRadius = 15
        swipeView.clipsToBounds = true
        shadowView.addSubview(swipeView)
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.leftAnchor.constraint(equalTo: shadowView.leftAnchor).isActive = true
        swipeView.rightAnchor.constraint(equalTo: shadowView.rightAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor).isActive = true
        swipeView.topAnchor.constraint(equalTo: shadowView.topAnchor).isActive = true
    }
    
    func configureLabelView() {
        swipeView.addSubview(label)
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: swipeView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: swipeView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: swipeView.bottomAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 85).isActive = true

    }
    
    func configureLabelView2() {
        swipeView.addSubview(label)
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: swipeView.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: swipeView.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: swipeView.bottomAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 85).isActive = true

    }
    
    
    func configureImageView() {
        swipeView.addSubview(label2)
        label2.textColor = .black
        label2.textAlignment = .center
        label2.font =  UIFont(name:textFont,size:25)
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.lineBreakMode = .byCharWrapping
        label2.centerXAnchor.constraint(equalTo: swipeView.centerXAnchor).isActive = true
        label2.centerYAnchor.constraint(equalTo: swipeView.centerYAnchor, constant: -30).isActive = true
        label2.widthAnchor.constraint(equalToConstant: 600).isActive = true
        label2.heightAnchor.constraint(equalToConstant: 600).isActive = true
               
    }
    
    func configureButton() {
        label.addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "plus-tab")?.withRenderingMode(.alwaysTemplate)
        moreButton.setImage(image, for: .normal)
        moreButton.tintColor = UIColor.red
        moreButton.rightAnchor.constraint(equalTo: label.rightAnchor, constant: -15).isActive = true
        moreButton.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        moreButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    }

    func configureTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
    }
    
    
    func addPanGestureOnCards() {
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }
    
    
    
    //MARK: - Handlers
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        let card = sender.view as! SwipeCardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)
        
        _ = ((UIScreen.main.bounds.width / 2) - card.center.x)
        divisor = ((UIScreen.main.bounds.width / 2) / 0.61)
       
        switch sender.state {
        case .ended:
            if (card.center.x) > 400 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    if readString.count > 1{
                        readString.removeFirst();
                    }else{
                         readString = []
                    }
                    self.layoutIfNeeded()
                }
                return
            }else if card.center.x < -65 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    if readString.count > 1{
                    readString.removeFirst();
                    }else{
                        readString = []
                    }
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (self.frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)
            
        default:
            break
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer){
    }
    
  
}
