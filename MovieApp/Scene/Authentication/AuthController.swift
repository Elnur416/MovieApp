//
//  AuthController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 20.02.25.
//

import UIKit

class AuthController: UIViewController {
    
    private let viewModel = AuthViewModel()
    
//    MARK: UI elements
    
    private lazy var stack: UIStackView = {
        let s = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton])
        s.axis = .vertical
        s.spacing = 12
        s.distribution = .fillEqually
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    private lazy var emailField: UITextField = {
        let t = UITextField()
        t.placeholder = "Email"
        t.borderStyle = .roundedRect
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var passwordField: UITextField = {
        let t = UITextField()
        t.placeholder = "Password"
        t.borderStyle = .roundedRect
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    private lazy var loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle( "Login", for: .normal)
        b.backgroundColor = .label
        b.setTitleColor(.white, for: .normal)
        b.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

//    MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
        configureViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(stack)
        }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    @objc private func loginAction() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty
        else {
            self.showAlert(title: "Error", message: "Email and password fields must not be empty")
            return
        }
        viewModel.handleLogin(email: email, password: password)
    }
    
    private func configureViewModel() {
        viewModel.errorHandler = { [weak self] error in
            self?.showAlert(title: "Error", message: error)
        }
        viewModel.success = {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let sceneDelegate = windowScene.delegate as? SceneDelegate else { return }
            let coordinator = AppCoordinator(navigationController: self.navigationController ?? UINavigationController(), window: sceneDelegate.window)
            coordinator.start()
        }
    }
}
