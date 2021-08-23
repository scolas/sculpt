//
//  PostActionsCollectionViewCell.swift
//  Insta
//
//  Created by Scott Colas on 4/11/21.
//

import UIKit

class PostActionsCollectionViewCell: UICollectionViewCell {
    static let identifer = "PostActionsCollectionViewCell"
    
    private let label: UILabel = {
       let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    func configure(with viewModel: PostActionsCollectionViewCellViewModel){
        
    }

}
