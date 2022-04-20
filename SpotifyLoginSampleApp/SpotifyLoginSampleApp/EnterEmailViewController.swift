//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 민성홍 on 2022/04/20.
//

import UIKit

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
