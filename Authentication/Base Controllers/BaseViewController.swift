//
//  BaseViewController.swift
//  Authentication
//
//  Created by ahmed sultan on 02/09/2021.
//


import UIKit
import RxSwift
import RxCocoa
class BaseViewController<T: ViewModel>: UIViewController {
    
    var coordinator = AppCoordinator.shared
    var viewModel: T
    lazy var disposeBag: DisposeBag = {
       return DisposeBag()
    }()
    init(viewModel:T) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarFont()
    }

    func bind() {
      fatalError("Please override bind func")
    }
    
    func setNavigationBarFont() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22)]
    }
    func transluceneNavigationBar() {
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
}
