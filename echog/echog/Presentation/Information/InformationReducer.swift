//
//  InformationReducer.swift
//  echog
//
//  Created by minsong kim on 1/12/25.
//

import Combine
import UIKit

struct InformationReducer: ReducerProtocol {
    enum Intent {
        case checkEmailForm(String)
        case sendEmail(String)
        case checkCode(email: String, code: String)
        case checkPasswordForm(String)
        case checkPassword(password: String, confirmPassword: String)
        case checkCanGoNext(isCodeCheckSuccess: TryState, isCheckPasswordSuccess: TryState)
        case showTermPage
        case goToNextPage
    }
    
    enum Mutation {
        case emailFormPass
        case emailFormUnPass
        case sendEmailSuccess(String)
        case sendEmailFailure
        case codeCheckSuccess
        case codeCheckFailure
        case passwordCheckSuccess
        case passworkdCheckFailure
        case passwordFormPass(String)
        case passwordFormUnPass
        case goToNextStep
        case showTermsPage(UIViewController)
    }
    
    struct State {
        var email: String = ""
        var code: String = ""
        var password: String? = ""
        var termsViewController: UIViewController? = nil
        var isEmailFormPass: TryState = .notYet
        var isCodeSendSuccess: TryState = .notYet
        var isCodeCheckSuccess: TryState = .notYet
        var isPasswordCheckSuccess: TryState = .notYet
        var canShowTerms: TryState = .notYet
    }
    
    let initialState = State()
    
    weak var delegate: InformationCoordinator?
    private let userNetwork: UserNetwork
    
    init(networkManager: NetworkManager) {
        self.userNetwork = UserNetwork(networkManager: networkManager)
    }
    
    func mutate(action: Intent) -> AnyPublisher<Mutation, Never>? {
        switch action {
        case .checkEmailForm(let newEmail):
            if checkEmailForm(newEmail) {
                return Just(Mutation.emailFormPass)
                    .eraseToAnyPublisher()
            } else {
                return Just(Mutation.emailFormUnPass)
                    .eraseToAnyPublisher()
            }
        case .sendEmail(let newEmail):
            return Future<Mutation, Never> { promise in
                Task {
                    do {
                        _ = try await userNetwork.emailCodeRequest(email: newEmail)
                        promise(.success(.sendEmailSuccess(newEmail)))
                    } catch {
                        promise(.success(.sendEmailFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .checkCode(let email, let code):
            return Future<Mutation, Never> { promise in
                Task {
                    do {
                        _ = try await userNetwork.checkCode(email: email, code: code)
                        promise(.success(.codeCheckSuccess))
                    } catch {
                        promise(.success(.codeCheckFailure))
                    }
                }
            }
            .eraseToAnyPublisher()
        case .checkPasswordForm(let password):
            if checkPasswordForm(password) {
                return Just(Mutation.passwordFormPass(password))
                    .eraseToAnyPublisher()
            } else {
                return Just(Mutation.passwordFormUnPass)
                    .eraseToAnyPublisher()
            }
        case .checkPassword(password: let password, confirmPassword: let confirmPassword):
            if password == confirmPassword && !confirmPassword.isEmpty {
                return Just(Mutation.passwordCheckSuccess)
                    .eraseToAnyPublisher()
            } else {
                return Just(Mutation.passworkdCheckFailure)
                    .eraseToAnyPublisher()
            }
        case .checkCanGoNext(isCodeCheckSuccess: let isCodeCheckSuccess, isCheckPasswordSuccess: let isCheckPasswordSuccess):
            if isCodeCheckSuccess == .success, isCheckPasswordSuccess == .success {
                return Just(Mutation.goToNextStep)
                    .eraseToAnyPublisher()
            } else {
                return nil
            }
        case .showTermPage:
            let termsViewController = TermsViewController(reducer: self)
            return Just(Mutation.showTermsPage(termsViewController))
                .eraseToAnyPublisher()
        case .goToNextPage:
            //네트워크 연결
            delegate?.popInformationViewController()
            return nil
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .emailFormPass:
            newState.isEmailFormPass = .success
        case .emailFormUnPass:
            newState.isEmailFormPass = .failure
        case .sendEmailSuccess(let newEmail):
            newState.email = newEmail
            newState.isCodeSendSuccess = .success
        case .sendEmailFailure:
            newState.isCodeSendSuccess = .failure
        case .codeCheckSuccess:
            newState.isCodeCheckSuccess = .success
        case .codeCheckFailure:
            newState.isCodeCheckSuccess = .failure
        case .passwordCheckSuccess:
            newState.isPasswordCheckSuccess = .success
        case .passworkdCheckFailure:
            newState.isPasswordCheckSuccess = .failure
        case .passwordFormPass(let password):
            newState.password = password
        case .passwordFormUnPass:
            newState.password = nil
        case .goToNextStep:
            newState.canShowTerms = .success
        case .showTermsPage(let termsViewController):
            newState.termsViewController = termsViewController
        }
        
        return newState
    }
    
    private func checkEmailForm(_ text: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", pattern)
        return predicate.evaluate(with: text)
    }
    
    private func checkPasswordForm(_ text: String) -> Bool {
        let pattern = "^[a-zA-Z0-9]{0,8}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", pattern)
        return predicate.evaluate(with: text)
    }
}

enum TryState {
    case success
    case failure
    case notYet
}
