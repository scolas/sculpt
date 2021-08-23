//
//  ProfileTabCollectionReusableView.swift
//  Instagram
//
//  Created by Scott Colas on 1/13/21.
//

import UIKit
protocol ProfileTabCollectionReusableViewDelegate: AnyObject {
    func didTapGridButtonTab()
    func didTapTaggedButtonTab()
    func didTapCardioButtonTab()
    func didTapWeightButtonTab()
}
class Pro: UICollectionReusableView {
    static let identifier = "ProfileTabCollectionReusableView"
    
    public weak var delegate: ProfileTabCollectionReusableViewDelegate?
    struct Constants {
        static let padding: CGFloat = 8
    }
    private let gridButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
        return button
    }()
    
    private let taggedButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    private let cardioButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "macpro.gen3"), for: .normal)
        return button
    }()
    
    private let weightsButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName: "touchid"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(taggedButton)
        addSubview(gridButton)
        addSubview(cardioButton)
        addSubview(weightsButton)
        
        gridButton.addTarget(self,
                             action: #selector(didTapGridButton),
                             for: .touchUpInside)
        taggedButton.addTarget(self,
                               action: #selector(didTapTaggedButton),
                               for: .touchUpInside)
        weightsButton.addTarget(self,
                                action: #selector(didTapWeightButton),
                                for: .touchUpInside)
        cardioButton.addTarget(self,
                               action: #selector(didTapCardioButton),
                               for: .touchUpInside)
    }
    
    @objc private func didTapGridButton(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        cardioButton.tintColor = .lightGray
        weightsButton.tintColor = .lightGray
        delegate?.didTapGridButtonTab()
    }
    @objc private func didTapTaggedButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        cardioButton.tintColor = .lightGray
        weightsButton.tintColor = .lightGray
        delegate?.didTapTaggedButtonTab()
    }
    @objc private func didTapCardioButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .lightGray
        cardioButton.tintColor = .systemBlue
        weightsButton.tintColor = .lightGray
        delegate?.didTapCardioButtonTab()
    }
    @objc private func didTapWeightButton(){
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .lightGray
        cardioButton.tintColor = .lightGray
        weightsButton.tintColor = .systemBlue
        delegate?.didTapWeightButtonTab()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //part 10 6:19
        let size = height - (Constants.padding*2)
        let gridButtonX = ((width/4)-size)/4
        let nextSize = (width/4)
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constants.padding,
                                  width: size,
                                  height: size)
        taggedButton.frame = CGRect(x: gridButtonX + nextSize,
                                    y: Constants.padding,
                                    width: size,
                                    height: size)
        cardioButton.frame = CGRect(x:  gridButtonX + nextSize * 2,
                                    y: Constants.padding,
                                    width: size,
                                    height: size)
        weightsButton.frame = CGRect(x:  gridButtonX + nextSize * 3 ,
                                    y: Constants.padding,
                                    width: size,
                                    height: size)
    }
}
