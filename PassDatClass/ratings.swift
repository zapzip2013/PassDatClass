//
//  ratings.swift
//  PassDatClass
//
//  Created by Daniel Gibney on 2/23/18.
//  Copyright © 2018 Daniel Gibney. All rights reserved.
//

import UIKit

@IBDesignable class ratings: UIStackView {

        //MARK: properties
        private var ratingButtons = [UIButton]()
        var rating = 0 {
            didSet {
                updateButtonSelectionStates()
            }
        }
        @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0){
            didSet{
                setupButtons()
            }
        }
        
        @IBInspectable var starCount: Int = 5
            {
            didSet{
                setupButtons()
            }
        }
        
        //MARK: Initialization
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupButtons()
        }
        required init(coder: NSCoder) {
            super.init(coder: coder)
            setupButtons()
        }
        //MARK: Button Action
        @objc func ratingButtonTapped(button:UIButton){
            guard let index = ratingButtons.index(of: button) else{
                fatalError("The button, \(button), is not in the array \(ratingButtons)")
            }
            let selectedRating = index + 1
            if selectedRating == rating {
                rating = 0;
            }else{
                rating = selectedRating
            }
        }
        //MARK: Private methodes
        private func setupButtons(){
            //clear old buttons
            for button in ratingButtons{
                removeArrangedSubview(button)
                button.removeFromSuperview()
            }
            ratingButtons.removeAll()
            let bundle = Bundle(for: type(of: self))
            let filledstar = UIImage(named: "filledstar", in:bundle, compatibleWith:self.traitCollection)
            let emptystar = UIImage(named: "emptystar", in:bundle, compatibleWith:self.traitCollection)
            let touchedstar = UIImage(named: "touchedstar", in:bundle, compatibleWith:self.traitCollection)
            for _ in 0..<starCount{
                let button = UIButton()
                button.setImage(emptystar, for: .normal)
                button.setImage(filledstar, for: .selected)
                button.setImage(touchedstar, for: .highlighted)
                button.setImage(touchedstar, for: [.highlighted, .selected])
                // Add constraints
                button.translatesAutoresizingMaskIntoConstraints=false
                button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
                button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
                button.addTarget(self, action: #selector(ratings.ratingButtonTapped(button:)), for: .touchUpInside)
                // create the button
                addArrangedSubview(button)
                // Rating button array
                ratingButtons.append(button)
                updateButtonSelectionStates()
            }
        }
        private func updateButtonSelectionStates(){
            for (index, button) in ratingButtons.enumerated(){
                button.isSelected = index < rating
            }
        }
    
}

