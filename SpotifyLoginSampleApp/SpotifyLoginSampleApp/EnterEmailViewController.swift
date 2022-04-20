//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 민성홍 on 2022/04/20.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Navigation Bar 보이기
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        nextButton.layer.cornerRadius = 30

        nextButton.isEnabled = false

        emailTextField.delegate = self
        passwordTextField.delegate = self

        emailTextField.becomeFirstResponder()
    }

    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // FireBase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        // 신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }

            if let error = error {
                let code = (error as NSError).code

                switch code {
                    case 17007: // 이미 가입한 계정일 때
                        // 로그인 하기
                        self.loginUser(withEmail: email, password: password)
                    default:
                        self.errorMessageLabel.text = error.localizedDescription

                }
            } else {
                self.showMainViewController()
            }
        }
    }

    private func showMainViewController() {
        guard let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "Main") else { return }

        mainViewController.modalPresentationStyle = .fullScreen

        navigationController?.show(mainViewController, sender: nil)
    }

    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }

            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
}

extension EnterEmailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""

        if isPasswordEmpty == true {
            passwordTextField.becomeFirstResponder()
        }

        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
