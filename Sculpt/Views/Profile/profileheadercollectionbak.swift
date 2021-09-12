//
//  profileheadercollectionbak.swift
//  Sculpt
//
//  Created by Scott Colas on 8/15/21.
///*
import UIKit
/*
protocol ProfileHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderCollectionReusableViewDidTapProfilePicture(_ header: ProfileHeaderCollectionReusableView)
    
}



    class profileheadercollectionbak: UICollectionReusableView, UICollectionViewDelegate {
     

            
        static let identifier = "ProfileHeaderCollectionReusableView"

        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
            imageView.clipsToBounds = true
            imageView.layer.masksToBounds = true
            imageView.backgroundColor = .secondarySystemBackground
            return imageView
        }()

        weak var delegate: ProfileHeaderCollectionReusableViewDelegate?

        public let countContainerView = ProfileHeaderCountView()
        
       // public let countContainerView2 = ProfileTabCollectionReusableView()

       /* let tabCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 3
            layout.minimumLineSpacing = 0
            layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .brown
            collectionView.register(ProfileTabCollectionReusableView.self, forCellWithReuseIdentifier: ProfileTabCollectionReusableView.identifier)
            return collectionView
        }()*/
        
        private let bioLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "iOS Academy\nThis is my profile bio!"
            label.font = .systemFont(ofSize: 18)
            return label
        }()
        
        func createSegment(){
            let items = ["Arms", "chest"]
            let segmentedControl = UISegmentedControl(items: items)
            segmentedControl.addTarget(self, action: #selector(didTapSegment(_:)), for: .valueChanged)
            addSubview(segmentedControl)
            

            let imageSize: CGFloat = width/3.5
            segmentedControl.backgroundColor = .blue
            segmentedControl.frame = CGRect(
                x: 5,
                y: bioLabel.bottom+10,
                width: width,
                height: imageSize
            )
        }

        // MARK: - Init

        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .green
            addSubview(countContainerView)
            addSubview(imageView)
            addSubview(bioLabel)
            //addSubview(tabCollectionView)
            //tabCollectionView.delegate = self
           // tabCollectionView.dataSource = self
           // addSubview(countContainerView2)
            createSegment()
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
            imageView.addGestureRecognizer(tap)
        }

        required init?(coder: NSCoder) {
            fatalError()
        }

        @objc func didTapImage() {
            delegate?.profileHeaderCollectionReusableViewDidTapProfilePicture(self)
        }
        
        @objc func didTapSegment(_ segmentedControl: UISegmentedControl){
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                print("case 0")
            default:
                print("default")
            }
        }


        override func layoutSubviews() {
            super.layoutSubviews()
            let imageSize: CGFloat = width/3.5
            imageView.frame = CGRect(x: 5, y: 5, width: imageSize, height: imageSize)
            imageView.layer.cornerRadius = imageSize/2
            countContainerView.frame = CGRect(
                x: imageView.right+5,
                y: 3,
                width: width-imageView.right-10,
                height: imageSize
            )
            let bioSize = bioLabel.sizeThatFits(
                bounds.size
            )
            bioLabel.frame = CGRect(
                x: 5,
                y: imageView.bottom+10,
                width: width-10,
                height: bioSize.height+50
            )
            
         /*   countContainerView2.frame = CGRect(
                x: 5,
                y: bioLabel.bottom+10,
                width: width,
                height: imageSize
            )*/
        }

        override func prepareForReuse() {
            super.prepareForReuse()
            imageView.image = nil
            bioLabel.text = nil
        }

        public func configure(with viewModel: ProfileHeaderViewModel) {
            imageView.sd_setImage(with: viewModel.profilePictureUrl, completed: nil)
            var text = ""
            if let name = viewModel.name {
                text = name + "\n"
            }
            text += viewModel.bio ?? "Welcome to my profile!"
            bioLabel.text = text
            // Container
            let containerViewModel = ProfileHeaderCountViewViewModel(
                followerCount: viewModel.followerCount,
                followingCount: viewModel.followingICount,
                postsCount: viewModel.postCount,
                actioonType: viewModel.buttonType
            )
            countContainerView.configure(with: containerViewModel)

            //countContainerView2.configure(with: viewModel)
        }
        
        


    }


}
*/
