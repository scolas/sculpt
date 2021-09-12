//
//  PostCollectionViewCell.swift
//  Insta
//
//  Created by Scott Colas on 4/11/21.
//

import UIKit
import SDWebImage
protocol PostCollectionViewCellDelegate: AnyObject{
    func postCollectionViewCellDidLike(_ cell: PostCollectionViewCell, index: Int)
    
}

class PostCollectionViewCell: UICollectionViewCell {
    static let identifer = "PostCollectionViewCell"
    weak var delegate: PostCollectionViewCellDelegate?
    private var index = 0
    let postImage: UIImageView = {
        let image = UIImageView()
        // fiscaleAspectFill  to fill the scare
        //scaleAspectFit if non square photo
        image.contentMode = .scaleAspectFill
        return image
    }()
    private let heartImageView: UIImageView = {
        let image = UIImage(systemName: "suit.heart.fill",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50))
        
        let imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.isHidden = true
        imageView.alpha = 0
        return imageView
        
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(postImage)
        contentView.addSubview(heartImageView)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapToLike))
        tap.numberOfTapsRequired = 2
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(tap)
        
    }
    
    @objc func didDoubleTapToLike(){
        heartImageView.isHidden = false
        UIView.animate(withDuration: 0.4) {
            self.heartImageView.alpha = 1
            
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.4) {
                    self.heartImageView.alpha = 0
                } completion: { (done) in
                    if done {
                        self.heartImageView.isHidden = true
                    }
                }
            }
        }
        //pass in self? its normal to pass in a reference of caller of delegate function
        delegate?.postCollectionViewCellDidLike(self, index: index)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        postImage.frame = contentView.bounds
        let size: CGFloat = contentView.width/5
        heartImageView.frame = CGRect(x: (contentView.width-size)/2, y: (contentView.height-size)/2, width: size, height: size)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        postImage.image = nil
    }
    func configure(with viewModel: PostCollectionViewCellViewModel, index: Int) {
        self.index = index
        postImage.sd_setImage(with: viewModel.postUrl, completed: nil)
    }

}
