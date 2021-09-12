//
//  SignUpViewController.swift
//  Sculpt
//
//  Created by Scott Colas on 3/28/21.
//

import UIKit
import SafariServices
class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private let profilePictureImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.tintColor = .lightGray
        imageview.image = UIImage(systemName: "person.circle")
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 45
        return imageview
    }()

    private let usernameField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Username"
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
        
    }()

    
    private let emailField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "Email address"
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.autocorrectionType = .no
        return field
        
    }()
    
    private let passwordField: IGTextField = {
        let field = IGTextField()
        field.placeholder = "create Passowrd"
        field.isSecureTextEntry = true
        field.keyboardType = .default
        field.returnKeyType = .continue
        field.autocorrectionType = .no
        return field
        
    }()
    
    private let signUpButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
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
    
    
    public var completion: (() ->Void)?
    // LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Create Account"
        view.backgroundColor = .systemBackground
        addSubviews()
        
        usernameField.delegate = self
        passwordField.delegate = self
        emailField.delegate = self
        addButtonActions()
        addImageGesture()
        
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let imageSize: CGFloat = 90
        profilePictureImageView.frame = CGRect(
            x: (view.width - imageSize)/2,
            y: view.safeAreaInsets.top + 15,
            width: imageSize,
            height: imageSize
        )
        usernameField.frame = CGRect(x: 25, y: profilePictureImageView.bottom+20, width: view.width-50, height: 50)
        emailField.frame = CGRect(x: 25, y: usernameField.bottom+10, width: view.width-50, height: 50)
        passwordField.frame = CGRect(x: 25, y: emailField.bottom+10, width: view.width-50, height: 50)
        signUpButton.frame = CGRect(x: 50, y: passwordField.bottom+20, width: view.width-100, height: 50)
        termsButton.frame = CGRect(x: 35, y: signUpButton.bottom+50, width: view.width-100, height: 40)
        privacyButton.frame = CGRect(x: 50, y: termsButton.bottom+10, width: view.width-100, height: 40)
    }
    

    
    
    
    private func addButtonActions(){
        signUpButton.addTarget(self,action: #selector(didTapSignUp), for: .touchUpInside)
        termsButton.addTarget(self,action: #selector(didTapTerms), for: .touchUpInside)
        privacyButton.addTarget(self,action: #selector(didTapPrivacy), for: .touchUpInside)
    }
    
    private func addSubviews(){
        view.addSubview(profilePictureImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(usernameField)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
    }
    
    private func addImageGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profilePictureImageView.isUserInteractionEnabled = true
        profilePictureImageView.addGestureRecognizer(tap)
    }
    

    // MARK: - Actions
    @objc func didTapImage(){
        let sheet = UIAlertController(title: "Profile Picture",
                                      message: "Set a picture to hep your friends find you",
                                      preferredStyle:  .actionSheet)
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { [weak self] _ in
            
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.delegate = self
                self?.present( picker, animated: true)
            }
            
            
        }))
        // are going to be calling self and we dont want memory leak
        sheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            DispatchQueue.main.async {
                let picker = UIImagePickerController()
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                picker.delegate = self
                self?.present( picker, animated: true)
            }
            
        }))
        present(sheet, animated: true)
    }
    
    @objc func didTapSignUp(){
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        //should add more relavint alerts . spacifict to text filed that doesnt meet requierments
        // add regex to validate email
        //sign in & up vid 2 17:24
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty,
              !username.trimmingCharacters(in: .whitespaces).isEmpty,
              password.count >= 6,
              username.count >= 2,
              username.trimmingCharacters(in: .alphanumerics).isEmpty else {
            presentError()
            //sign in & up vid 2 18:24
           
            return
        }
        
        let data = profilePictureImageView.image?.pngData()
    
        // Sign in with authManager
        AuthManager.shared.singUp(
          email: email,
          username: username,
          Password: password,
          profilePicture: data
        ) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    HapticManager.shared.vibrate(for: .success)
                    UserDefaults.standard.setValue(user.email, forKey: "email")
                    UserDefaults.standard.setValue(user.username, forKey: "username")
                    self?.navigationController?.popToRootViewController(animated: true)
                    self?.completion?()
                    break
                case .failure(let error):
                    HapticManager.shared.vibrate(for: .error)
                    print("\n\nSign Up Error: \(error)")
                }
            }
        }
    }
    
    private func presentError(){
        let alert = UIAlertController(title: "Woops", message: "Please maek sure to fill all fileds and have a passowrd longer than 6 characters ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
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

    

    
    // MARK: field Delegate
    //called whenere user hits return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }else{
            //dismiss keyboard
            textField.resignFirstResponder()
            didTapSignUp()
        }
        return true
    }
    
    
    // Image picker
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        //editied image is the square version. we then force user to pick circular
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        profilePictureImageView.image = image
    }
}
