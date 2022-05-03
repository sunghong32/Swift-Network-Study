//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 민성홍 on 2022/04/20.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: GIDSignInButton!
    @IBOutlet weak var appleLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        [emailLoginButton, googleLoginButton, appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Navigation Bar 숨김
        navigationController?.navigationBar.isHidden = true

        // Google sign in

    }

    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else {
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)

            Auth.auth().signIn(with: credential) { _, _ in
                self.showMainViewController()
            }
        }
    }

    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
    }

    private func showMainViewController() {
        guard let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "Main") else { return }

        mainViewController.modalPresentationStyle = .fullScreen

        navigationController?.show(mainViewController, sender: nil)
    }
}


