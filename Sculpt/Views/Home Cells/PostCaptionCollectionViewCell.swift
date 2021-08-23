//
//  PostCaptionCollectionViewCell.swift
//  Insta
//
//  Created by Scott Colas on 4/11/21.
//

import UIKit
protocol PostCaptionCollectionViewCellDelegate: AnyObject {
    func postCaptionCollectionViewCellDidCaption(_ cell: PostCaptionCollectionViewCell)
}
class PostCaptionCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "PostCaptionCollectionViewCell"
    
    weak var delegate: PostCaptionCollectionViewCellDelegate?
    
    private let label: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCaption))
        label.addGestureRecognizer(tap)
    }
    @objc func didTapCaption(){
        delegate?.postCaptionCollectionViewCellDidCaption(self)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = label.sizeThatFits(CGSize(width: contentView.bounds.size.width,
                                             height: contentView.bounds.size.height))
        label.frame = CGRect(x: 12, y: 3, width: size.width-12, height: size.height)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    func configure(with viewModel: PostCaptionCollectionViewCellViewModel){
        label.text = "\(viewModel.username): \(viewModel.caption ?? "")"
    }
}
