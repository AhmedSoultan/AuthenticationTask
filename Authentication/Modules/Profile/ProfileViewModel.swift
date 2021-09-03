//
//  ProfileViewModel.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit
import RxSwift
import RxCocoa
protocol ProfileViewModelOutput {
    var isLoggedoutObservable: Observable<Bool> {get}
    var profileErrorObservable: Observable<String> {get}
    var profileModelObservable: Observable<UserProfileViewModel> {get}
    var activityIndicatorAppearenceObservable: Observable<Bool> {get}
}
protocol ProfileViewModelIntput {
    func viewDidLoad()
    func logout()
}

class ProfileViewModel: ViewModel, ProfileViewModelOutput,  ProfileViewModelIntput {
    
    //MARK:- Properties
    private let isLoggedoutPublishSubject: PublishSubject<Bool> = .init()
    private let profileErrorPublishSubject: PublishSubject<String> = .init()
    private let profileModelPublishSubject: PublishSubject<UserProfileViewModel> = .init()
    private let activityIndicatorPublishSubject: PublishSubject<Bool> = .init()


    var inputs: ProfileViewModelIntput {
        return self
    }
    
    var outputs: ProfileViewModelOutput {
        return self
    }
    
    //MARK:- Outputs
    var isLoggedoutObservable: Observable<Bool>
    var profileErrorObservable: Observable<String>
    var profileModelObservable: Observable<UserProfileViewModel>
    var activityIndicatorAppearenceObservable: Observable<Bool>

    //MARK:- Inputs

    func viewDidLoad() {
        fetchUserProfile()
    }
    func logout() {
        UserDefaults.standard.set("", forKey: "token")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        isLoggedoutPublishSubject.onNext(true)
    }
    
    //MARK:- Initialization
    
    init() {
        isLoggedoutObservable = isLoggedoutPublishSubject.asObserver()
        profileErrorObservable = profileErrorPublishSubject.asObserver()
        profileModelObservable = profileModelPublishSubject.asObserver()
        activityIndicatorAppearenceObservable = activityIndicatorPublishSubject.asObserver()
    }
    
    private func fetchUserProfile() {
        self.activityIndicatorPublishSubject.onNext(true)
        AuthClient.getUserProfile { [weak self] (userProfile, error) in
            guard let self = self else {return}
            self.activityIndicatorPublishSubject.onNext(false)
            guard userProfile != nil else {
                self.profileErrorPublishSubject.onNext(error ?? "")
                return
            }
            let profileViewModel = UserProfileViewModel(profile: userProfile!)
            self.profileModelPublishSubject.onNext(profileViewModel)
        }
    }
}
