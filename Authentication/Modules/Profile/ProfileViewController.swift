//
//  ProfileViewController.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit
import Kingfisher

class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    //MARK:- Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addresLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    //MARK:- properties

    let logOutButton = UIButton(type: UIButton.ButtonType.custom)

    //MARK:- View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        viewModel.inputs.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNavigationBarButtonItem()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    //MARK:- Custom action
    
    override func bind() {
        viewModel.outputs.isLoggedoutObservable.filter{$0 == true}.subscribe(onNext: {[weak self] isValid in
            guard let self = self else {return}
            self.coordinator.authNavigator.navigate(to: .login, with: .root, and: self.navigationController)
        }).disposed(by: self.disposeBag)
        
        viewModel.outputs.activityIndicatorAppearenceObservable.subscribe(onNext: {[weak self] isAppear in
            guard let self = self else {return}
            self.activityIndicator.isHidden = isAppear ? false : true
            isAppear ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }).disposed(by: self.disposeBag)

        viewModel.outputs.profileModelObservable.subscribe(onNext: {[weak self] profileModel in
            guard let self = self else {return}
            self.setProfileData(with: profileModel)
        }).disposed(by: self.disposeBag)
        
        viewModel.outputs.profileErrorObservable.subscribe(onNext: {[weak self] errorMessage in
            guard let self = self else {return}
            Alert.present(Title: "Error!", Message: errorMessage, self)
        }).disposed(by: self.disposeBag)

    }
    
    fileprivate func setProfileData(with profileModel: UserProfileViewModel) {
        self.nameLabel.text = profileModel.fullName
        self.phoneLabel.text = profileModel.phoneNumber
        self.addresLabel.text = profileModel.address
        self.profileImageView.kf.setImage(with: profileModel.userImageUrl)
    }
    
    func createCustomBarButtonItem(barButton: UIButton) -> UIBarButtonItem {
        barButton.setTitle("Logout", for: .normal)
        barButton.setTitleColor(.black, for: .normal)
        barButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        barButton.contentVerticalAlignment = .center
        barButton.contentHorizontalAlignment = .center
        barButton.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        barButton.clipsToBounds = true
        return UIBarButtonItem(customView: barButton)
    }
    
    func addNavigationBarButtonItem() {
        logOutButton.addTarget(self, action: #selector(logoutButtonAction), for: UIControl.Event.touchUpInside)
        let logOutButtonItem = createCustomBarButtonItem(barButton: logOutButton)
        navigationItem.rightBarButtonItems = [logOutButtonItem]
    }
    
    @objc func logoutButtonAction() {
        viewModel.logout()
    }
}
