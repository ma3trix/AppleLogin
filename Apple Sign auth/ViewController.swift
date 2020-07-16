//
//  ViewController.swift
//  Apple Sign auth
//
//  Created by Malik Adebiyi on 2020-07-16.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupView()
    }
    
    func setupView(){
        
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        appleButton.overrideUserInterfaceStyle = .light
        
        appleButton.addTarget(self, action: #selector(SignInAppleTapped), for: .touchUpInside)
        
        view.addSubview(appleButton)
        
        NSLayoutConstraint.activate([appleButton.centerYAnchor.constraint(equalTo:
                                                                            view.centerYAnchor),
                                     appleButton.leadingAnchor.constraint(equalTo:
                                                                            view.leadingAnchor, constant: 0),
                                     appleButton.trailingAnchor.constraint(equalTo:
                                                                            view.trailingAnchor,constant: 0),
                                     appleButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                     appleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)])
    
    }
    
    
    @objc func SignInAppleTapped() {
        print("Sign in Tapped")
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
}

extension ViewController: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error", error)
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            print(credentials)
            print("Login Succcessful")
            
//            let user = User(credentials: credentials)
//            self.signUpSocial(emailAddress: user.email, firstName: user.firsName, lastName: user.lastName, socialID: user.id, socialName: "Apple")
            break
        default:
            break
        }
        
    }
    
}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return view.window!
    }
    
    
}
