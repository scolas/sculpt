//
//  SignInViewController.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//
import SafariServices
import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    //Subvies
    private let headerview = SignInHeaderView()

    private let emailField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Email address"
        //field.text = "scott@scott.com"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
        
    }()
    
    private let passwordField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Passowrd"
        //field.text = "saloc1993"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
        
    }()
    
    private let signInButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        return button
    }()
    
    private let createAccount: UIButton = {
       let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Create Account", for: .normal)
        return button
    }()
    
    
    private let termsButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Terms of Service", for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("Privacy Policy", for: .normal)
        return button
    }()
    
    // LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "sign in "
        view.backgroundColor = .systemBackground
        headerview.backgroundColor = .red
        addSubviews()
        
        emailField.delegate = self
        passwordField.delegate = self
        addButtonActions()
        didTapSignIn()
     
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerview.frame = CGRect(
            x: 0,
            y: view.safeAreaInsets.top,
            width: view.width,
            height: (view.height - view.safeAreaInsets.top)/3
        )
        emailField.frame = CGRect(x: 25, y: headerview.bottom+20, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 50)
        signInButton.frame = CGRect(x: 50, y: passwordField.bottom+20, width: view.width-100, height: 50)
        createAccount.frame = CGRect(x: 35, y: signInButton.bottom+20, width: view.width-100, height: 50)
        termsButton.frame = CGRect(x: 35, y: createAccount.bottom+50, width: view.width-100, height: 40)
        privacyButton.frame = CGRect(x: 50, y: termsButton.bottom+10, width: view.width-100, height: 40)
    }
    

    
    
    
    private func addButtonActions(){
        signInButton.addTarget(self,action: #selector(didTapSignIn), for: .touchUpInside)
        createAccount.addTarget(self,action: #selector(didTapCreateAccount), for: .touchUpInside)
        termsButton.addTarget(self,action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self,action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    private func addSubviews(){
        view.addSubview(headerview)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signInButton)
        view.addSubview(createAccount)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    

    // MARK: - Actions
    @objc func didTapSignIn(){
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6 else {
            return
        }
        
        // Sign in with authManager
        AuthManager.shared.signIn(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    HapticManager.shared.vibrate(for: .success)
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(
                        vc,
                        animated: true,
                        completion: nil
                    )

                case .failure(let error):
                    HapticManager.shared.vibrate(for: .error)
                    print(error)
                }
            }
        }
    }
    
    @objc func didTapTerms(){
        guard let url = URL(string: "scottcolas.com") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
    }
    @objc func didTapPrivacy(){
        guard let url = URL(string: "scottcolas.com") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    @objc func didTapCreateAccount(){
        let vc = SignUpViewController()
        vc.completion = { [weak self] in
            DispatchQueue.main.async {
                let tabVC = TabBarViewController()
                tabVC.modalPresentationStyle = .fullScreen
                self?.present(tabVC, animated: true)
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    

    
    // MARK: field Delegate
    //called whenere user hits return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }else{
            //dismiss keyboard
            textField.resignFirstResponder()
            didTapSignIn()
        }
        return true
    }
}
