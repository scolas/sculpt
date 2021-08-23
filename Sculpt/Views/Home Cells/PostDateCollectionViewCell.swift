//
//  PostDateCollectionViewCell.swift
//  Insta
//
//  Created by Scott Colas on 4/11/21.
//

import UIKit

class PostDateCollectionViewCell: UICollectionViewCell {
    static let identifer = "PostDateCollectionViewCell"
    private let label: UILabel = {
       let label = UILabel()
        label.backgroundColor = .secondarySystemBackground
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(label)
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
    func configure(with viewModel: PostDatetimeCollectionViewCellViewModel){
        let date = viewModel.date
        label.text = .date(from: date)
    }
}
