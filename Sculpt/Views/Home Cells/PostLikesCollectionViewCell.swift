//
//  PostLikesCollectionViewCell.swift
//  Insta
//
//  Created by Scott Colas on 4/11/21.
//

import UIKit
protocol PostLikesCollectionViewCellDelegate: AnyObject {
    func postLikesCollectionViewCellLikeCount(_ cell: PostLikesCollectionViewCell)
}
class PostLikesCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "PostLikesCollectionViewCell"
    weak var delegate : PostLikesCollectionViewCellDelegate?
    private let label: UILabel = {
       let label = UILabel()
        label.isUserInteractionEnabled = true
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapLabel))
        label.addGestureRecognizer(tap)
    }
    @objc func didTapLabel(){
        delegate?.postLikesCollectionViewCellLikeCount(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: 0, width: contentView.width - 12, height: contentView.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    func configure(with viewModel: PostLikeCollectionViewCellViewModel){
        let users = viewModel.likers
        label.text = "\(users.count) likes"
    }

}
