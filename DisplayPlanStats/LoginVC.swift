//
//  ViewController.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 23.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit
import IQKeyboardManager

final class LoginVC : UIViewController {

    @IBOutlet fileprivate weak var nameTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var loginButton: Button!

    fileprivate let server = ServerLogin()

    override func viewDidLoad() {
        super.viewDidLoad()
        initTextFields()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUILoginButton()
    }

    @IBAction func loginClicked(_ sender: Button) {
        guard let name = nameTextField.text,
            let pass = passwordTextField.text,
            name.isNotBlank,
            pass.isNotBlank
            else {
                showText("Fill all fields")
                return
            }
        server.login(username: name.trimmed, password: pass.trimmed).then { [weak self] model -> Void in
            guard let welf = self else { return }
            if model.success {
                UserDefaults.standard.save(model)
                if let main = Storyboards.main {
                    welf.present(main, animated: true, completion: nil)
                } else {
                    showText("Cant get \(Storyboards.Name.main) storyboard")
                }
            } else {
                sender.shake()
                showText("Somesing wrong")
            }
        }.catch { showText($0.localizedDescription) }
    }

    @IBAction func closeKeyboard(_ sender: UITapGestureRecognizer) {
        IQKeyboardManager.shared().resignFirstResponder()
    }
}

// MARK: initializations
private extension LoginVC {

    func initTextFields() {
        nameTextField.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textFieldEditingEnd(_:)), for: .editingDidEndOnExit)
        passwordTextField.addTarget(self, action: #selector(textFieldEditingEnd(_:)), for: .editingDidEndOnExit)
    }

    func initUILoginButton() {
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 10
    }
}

// MARK: textFields functions
private extension LoginVC {

    @objc
    func textFieldTextChanged(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if text.isBlank {
            sender.layer.borderColor = UIColor.red.cgColor
        } else {
            sender.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    @objc
    func textFieldEditingEnd(_ sender: UITextField) {
        switch sender {
            case nameTextField: passwordTextField.becomeFirstResponder()
            default: IQKeyboardManager.shared().resignFirstResponder()
        }
    }
}
