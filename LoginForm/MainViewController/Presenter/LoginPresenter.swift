//
//  LoginPresenter.swift
//  LoginForm
//
//  Created by Mikita Piatrushka on 6.11.22.
//

import Foundation

enum LoginState {
    case idle
    case readyToAuth
    case error
    case success
}

protocol LoginViewDelegate: AnyObject {
    
}

final class LoginPresenter {
    weak var delegate: LoginViewDelegate?

    private var state: LoginState = .idle
}

extension LoginPresenter {
    func authorizationAction() {
        switch state {
        case .idle:
            // MARK: - Check fields
            state = .readyToAuth
        case .readyToAuth:
            // MARK: - Perform validation request
            state = (0...1).randomElement()! == 1 ? .success : .error
        case .error:
            // MARK: - Restore fields
            state = .idle
        case .success:
            break
        }
    }
}
