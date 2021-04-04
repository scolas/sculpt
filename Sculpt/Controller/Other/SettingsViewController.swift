//
//  SettingsViewController.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Settins"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(didTapClose))
        createTableFooter()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func didTapClose(){
        dismiss(animated: true, completion: nil)
    }
    @objc func didTapSignOut(){
        let actionSheet = UIAlertController(
            title: "Sign Out",
            message: "Are you sure",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Sign out", style: .destructive, handler: { [weak self]
            _ in
            AuthManager.shared.signOut {  success in
                if success {
                    DispatchQueue.main.async {
                        //self?.didTapClose()
                        //show sign out Ui
                        let vc = SignInViewController()
                        let navVc = UINavigationController(rootViewController: vc)
                        //full screen so nobdy can swipe away
                        navVc.modalPresentationStyle = .fullScreen
                        self?.present(navVc, animated: true)
                    }
                   
                }
            }
        }))
       present(actionSheet,animated: true)
    }
    
    // Table
    private func createTableFooter(){
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: 50))
        footer.clipsToBounds = true
        
        let button = UIButton(frame: footer.bounds)
        footer.addSubview(button)
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        tableView.tableFooterView = footer
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    


}
