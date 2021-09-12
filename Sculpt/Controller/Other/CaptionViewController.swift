//
//  CaptionViewController.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//
import TTGTagCollectionView
import UIKit

class CaptionViewController: UIViewController, UITextViewDelegate, TTGTextTagCollectionViewDelegate{
   // var selections
    private let image: UIImage
    
    let tagCollection = TTGTextTagCollectionView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let textView: UITextView = {
       let textView = UITextView()
        textView.text = "Add caption..."
        textView.backgroundColor = .secondarySystemBackground
        textView.textContainerInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        textView.font = .systemFont(ofSize: 22)
        return textView
    }()
    //MARK: Init
    init(image: UIImage){
        self.image = image
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.image = image
        view.addSubview(textView)
        textView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Post",
            style: .done,
            target: self,
            action: #selector(didTapPost)
        )
        
        tagCollection.alignment = .center
        tagCollection.delegate = self
        view.addSubview(tagCollection)
        
        let config = TTGTextTagConfig()
        config.backgroundColor = .systemBlue
        config.textColor = .white
        config.borderColor = .systemOrange
        config.borderWidth = 1
        
        tagCollection.addTags(["Arms","Chest","Abs"], with: config)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size: CGFloat = view.width/4
        imageView.frame = CGRect(
            x: (view.width-size)/2,
            y: view.safeAreaInsets.top + 10,
            width: size,
            height: size
        )
        textView.frame = CGRect(
            x: 20,
            y: imageView.bottom + 20,
            width: view.width-40,
            height: 100
        )
        tagCollection.frame = CGRect(
            x: 0,
            y: textView.bottom+100,
            width: view.frame.width,
            height: 300
        )
    }
    
    @objc func didTapPost(){
        textView.resignFirstResponder()
        var caption = textView.text ?? ""
        if caption == "Add caption..." {
            caption = ""
        }
        let tagging = "Arms"
        // upload photo , update database
        //Generate post ID
        guard let newPostID = createNewPostID(),
              let stringDate = String.date(from: Date()) else {
            return
        }
        //upload post
        StorageManager.shared.uploadPost(
            data: image.pngData(),
            id: newPostID
        ) { newPostDownloadURL in
            guard let url = newPostDownloadURL else {
                print("faild to upload caption view controller")
                return
            }
            
            //New post
            let newPost = Post(
                id: newPostID,
                caption: caption,
                postedDate: stringDate,
                postUrlString: url.absoluteString,
                bodyPart: self.selections,
                likers: []
            )
            //update database
            DatabaseManager.shared.createPost(newPost: newPost) { [weak self] finished in
                guard finished else {
                    return
                }
                
                DispatchQueue.main.async {
                    //goes back to root tab
                    self?.tabBarController?.tabBar.isHidden = false
                    self?.tabBarController?.selectedIndex = 0
                    self?.navigationController?.popToRootViewController(animated: false)
                    
                }
                
            }
        }
        
    }
    private func createNewPostID() -> String? {
        let timeStamp = Date().timeIntervalSince1970
        let randomNumber = Int.random(in: 0...1000)
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            return nil
        }
        return "\(username)_\(randomNumber)_\(timeStamp)"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Add caption.." {
            textView.text = nil
        }
    }

    
    //https://www.youtube.com/watch?v=dKe59TavIEc
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        //selections.append(tagText)

        selections = tagText
        
        print("\(selections)")
    }

}

