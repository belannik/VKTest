//
//  AuthVC.swift
//  VKTest
//
//  Created by Anton on 03.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import VKSdkFramework

final class AuthVC: UIViewController
{
    // MARK: - Property list

    private let authService: AuthService
    private let signInButton = UIButton()

    // MARK: - Initialization

    init(authService: AuthService) {
        self.authService = authService
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupButton()
    }

    // MARK: - Private methods

    private func setupButton() {
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.backgroundColor = UIColor(red: 60/255, green: 92/255, blue: 255/255, alpha: 1)
        signInButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        signInButton.setTitle("Войти", for: .normal)
        
        NSLayoutConstraint.activate([
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31),
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 6.5),
        ])
    }

    @objc private func signIn() {
        authService.wakeUpSession()
    }
}
