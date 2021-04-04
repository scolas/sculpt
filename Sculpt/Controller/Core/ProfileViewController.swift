//
//  ProfileViewController.swift
//  Insta
//
//  Created by Scott Colas on 3/28/21.
//

import UIKit

class ProfileViewController: UIViewController {

    private let user: User
    private var isCurrentUser: Bool{
        return user.username.lowercased() == UserDefaults.standard.string(forKey:
                                                                            "username")?.lowercased() ?? ""
    }
    
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()

        title = user.username.uppercased()
        view.backgroundColor = .systemPink
        configure()
    }
    
    
   /* // called once the view  appears once more
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showSignOutUIIfNeeded()
    }
    private func showSignOutUIIfNeeded(){
        guard !AuthManager.shared.isSignedIn else {
            return
        }
        
        //show sign out Ui
        let vc = SignInViewController()
        let navVc = UINavigationController(rootViewController: vc)
        //full screen so nobdy can swipe away
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true)
    }*/
    
    private func configure(){
        if isCurrentUser {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "gear"),
                style: .done,
                target: self,
                action: #selector(didTapSettings)
            )
        }
    }
    
    @objc private func didTapSettings(){
        let vc = SettingsViewController()
        present(UINavigationController(rootViewController: vc),animated: true)
    }
    

    

}
