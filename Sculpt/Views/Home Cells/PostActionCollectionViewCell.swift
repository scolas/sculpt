//
//  PostActionCollectionViewCell.swift
//  Insta
//
//  Created by Scott Colas on 4/11/21.
//

import UIKit
protocol PostActionCollectionViewCellDelegate: AnyObject {
    func postActionsCollectionViewCellDidTapLike(_ cell: PostActionCollectionViewCell, isLiked: Bool)
    func postActionsCollectionViewCellDidTapShare(_ cell: PostActionCollectionViewCell)
    func postActionsCollectionViewCellDidTapComment(_ cell: PostActionCollectionViewCell)
    
}

class PostActionCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "PostActionsCollectionViewCell"
    
    weak var delegate: PostActionCollectionViewCellDelegate?
    
    private var isLiked = false
    
    private let likeButton: UIButton = {
       let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "suit.heart",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
        button.setImage(image, for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "paperplane",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
        button.setImage(image, for: .normal)
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "message",
                            withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.addSubview(shareButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        
        //Actions
        likeButton.addTarget(self, action:#selector(didTapLike), for: .touchUpInside)
        commentButton.addTarget(self, action:#selector(didTapComment), for: .touchUpInside)
        shareButton.addTarget(self, action:#selector(didTapShare), for: .touchUpInside)
        
    }
    @objc func didTapLike(){
        if self.isLiked{
            let image = UIImage(systemName: "suit.heart",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .label
        } else {
            let image = UIImage(systemName: "suit.heart.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .systemRed
        }
        delegate?.postActionsCollectionViewCellDidTapLike(self, isLiked: !isLiked)
        self.isLiked = !isLiked
    }
    @objc func didTapComment(){
        delegate?.postActionsCollectionViewCellDidTapComment(self)
    }
    @objc func didTapShare(){
        delegate?.postActionsCollectionViewCellDidTapShare(self)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.height/1.15
        likeButton.frame = CGRect(x: 10, y: (contentView.height-size), width: size, height: size)
        commentButton.frame = CGRect(x: likeButton.right+12,
                                     y: (contentView.height-size), width: size, height: size)
        shareButton.frame = CGRect(x: commentButton.right+12,
                                   y: (contentView.height-size), width: size, height: size)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    func configure(with viewModel: PostActionsCollectionViewCellViewModel){
        isLiked = viewModel.isLiked
        if isLiked{
            let image = UIImage(systemName: "suit.heart.fill",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 44))
            likeButton.setImage(image, for: .normal)
            likeButton.tintColor = .systemRed
        }
    }

}
