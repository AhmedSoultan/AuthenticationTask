//
//  AuthViewModel.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

protocol AuthViewModelOutput {
    var credentialsErrorObservable: Observable<String> {get}
    var isValidCredentialsObservable: Observable<Bool> {get}
    var logoUrlObservable: Observable<URL> {get}
    var isSuccessCredentialsObservable: Observable<Bool> {get}
    var postCredentialsErrorObservable: Observable<String> {get}
    var activityIndicatorAppearenceObservable: Observable<Bool> {get}
}
protocol AuthViewModelIntput {
    func validateCredentials()
    func viewDidLoad()
    func performLogin()
    var userNamePublishSubject: BehaviorRelay<String> {get}
    var passwordPublishSubject: BehaviorRelay<String> {get}
}

class AuthViewModel: ViewModel, AuthViewModelIntput, AuthViewModelOutput  {
    
    //MARK:- Properties

    var inputs: AuthViewModelIntput {
        return self
    }
    
    var outputs: AuthViewModelOutput {
        return self
    }
    
    private let credentialsErrorPublishSubject: PublishSubject<String> = .init()
    private let isValidCredentialsPublishSubject: PublishSubject<Bool> = .init()
    private let logoUrlPublishSubject: PublishSubject<URL> = .init()
    private let isSuccessCredentialsPublishSubject: PublishSubject<Bool> = .init()
    private let postCredentialsPublishSubject: PublishSubject<String> = .init()
    private let activityIndicatorPublishSubject: PublishSubject<Bool> = .init()

    //MARK:- Outputs
    
    var credentialsErrorObservable: Observable<String>
    var isValidCredentialsObservable: Observable<Bool>
    var logoUrlObservable: Observable<URL>
    var isSuccessCredentialsObservable: Observable<Bool>
    var postCredentialsErrorObservable: Observable<String>
    var activityIndicatorAppearenceObservable: Observable<Bool>
    
    //MARK:- Inputs

    var userNamePublishSubject: BehaviorRelay<String> = .init(value: "")
    var passwordPublishSubject: BehaviorRelay<String> = .init(value: "")
    
    func viewDidLoad() {
        let urlString = "https://placeimg.com/80/80/tech"
        if let logoUrl = URL(string: urlString) {
            logoUrlPublishSubject.onNext(logoUrl)
        }
    }
    func validateCredentials() {
        if userNamePublishSubject.value.count < 6 && passwordPublishSubject.value.count < 7 {
            credentialsErrorPublishSubject.onNext(ValidationError.incorrectCredentials.rawValue)
            isValidCredentialsPublishSubject.onNext(false)
        } else if userNamePublishSubject.value.count < 6 {
            credentialsErrorPublishSubject.onNext(ValidationError.incorrectUsername.rawValue)
            isValidCredentialsPublishSubject.onNext(false)
        } else if passwordPublishSubject.value.count < 7 {
            credentialsErrorPublishSubject.onNext(ValidationError.incorrectPassword.rawValue)
            isValidCredentialsPublishSubject.onNext(false)
        } else {
            isValidCredentialsPublishSubject.onNext(true)
        }
    }
    
    func performLogin() {
        self.activityIndicatorPublishSubject.onNext(true)
        AuthClient.postCredentials(username: userNamePublishSubject.value, password: passwordPublishSubject.value) { [weak self] success, error in
            guard let self = self else {return}
            self.activityIndicatorPublishSubject.onNext(false)
            guard success else {
                self.postCredentialsPublishSubject.onNext(error ?? "")
                return
            }
            self.isSuccessCredentialsPublishSubject.onNext(true)
        }
    }
    
    //MARK:- Initialization
    
    init() {
        credentialsErrorObservable = credentialsErrorPublishSubject.asObserver()
        isValidCredentialsObservable = isValidCredentialsPublishSubject.asObserver()
        logoUrlObservable = logoUrlPublishSubject.asObserver()
        isSuccessCredentialsObservable = isSuccessCredentialsPublishSubject.asObserver()
        postCredentialsErrorObservable = postCredentialsPublishSubject.asObserver()
        activityIndicatorAppearenceObservable = activityIndicatorPublishSubject.asObserver()
    }
}
