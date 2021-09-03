//
//  LoginViewController.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit
import Kingfisher

class AuthViewController: BaseViewController<AuthViewModel> {
    
    //MARK:- Outlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK:- View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRadius()
        viewModel.viewDidLoad()
        activityIndicator.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        transluceneNavigationBar()
    }

    //MARK:- Custom action
    
    @IBAction func loginButtonAction(_ sender: UIButton) {
        viewModel.validateCredentials()
        view.endEditing(true)
    }

    override func bind() {
        bindForCredentialValidation()
        bindForNetworking()
    }
    
    func bindForCredentialValidation() {
        userNameTextField.rx.text.map{$0 ?? ""}.bind(to: viewModel.inputs.userNamePublishSubject).disposed(by: self.disposeBag)
       
        passwordTextField.rx.text.map {$0 ?? ""}.bind(to: viewModel.inputs.passwordPublishSubject).disposed(by: self.disposeBag)
       
        viewModel.outputs.credentialsErrorObservable.subscribe(onNext: {[weak self] errorMessage in
            guard let self = self else {return}
            Alert.present(Title: "Warnning", Message: errorMessage, self)
        }).disposed(by: self.disposeBag)

        viewModel.outputs.logoUrlObservable.subscribe(onNext: {[weak self] logoUrl in
            guard let self = self else {return}
            self.logoImageView.kf.setImage(with: logoUrl)
        }).disposed(by: self.disposeBag)

    }
    func bindForNetworking() {
        
        viewModel.outputs.activityIndicatorAppearenceObservable.subscribe(onNext: {[weak self] isAppear in
            guard let self = self else {return}
            self.activityIndicator.isHidden = isAppear ? false : true
            isAppear ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }).disposed(by: self.disposeBag)
        
        viewModel.outputs.isValidCredentialsObservable.filter{$0 == true}.subscribe(onNext: {[weak self] isValid in
            guard let self = self else {return}
            self.viewModel.inputs.performLogin()
        }).disposed(by: self.disposeBag)
        
        viewModel.outputs.isSuccessCredentialsObservable.filter{$0 == true}.subscribe(onNext: {[weak self] isValid in
            guard let self = self else {return}
            self.coordinator.profileNavigator.navigate(to: .profile, with: .push, and: self.navigationController)
        }).disposed(by: self.disposeBag)
        viewModel.outputs.postCredentialsErrorObservable.subscribe(onNext: {[weak self] errorMessage in
            guard let self = self else {return}
            Alert.present(Title: "Error!", Message: errorMessage, self)
        }).disposed(by: self.disposeBag)
    }
}

//MARK:- textField delegate and scroll

extension AuthViewController: UITextFieldDelegate {
    func getRadius() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didtapview(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    @objc func didtapview(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
