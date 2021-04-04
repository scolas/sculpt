//
//  SignInHeaderView.swift
//  Sculpt
//
//  Created by Scott Colas on 3/29/21.
//

import UIKit

class SignInHeaderView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private var gradientLayer: CALayer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        createGradient()
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func createGradient(){
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemPink.cgColor]
        
        
        layer.addSublayer(gradientlayer)
        self.gradientLayer = gradientlayer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = layer.bounds
        imageView.frame = CGRect(x: width/4, y: 20, width: width/2, height: height-40)
    }

}
