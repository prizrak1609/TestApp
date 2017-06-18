//
//  SettingsVC.swift
//  DisplayPlanStats
//
//  Created by Dima Gubatenko on 25.05.17.
//  Copyright © 2017 A2Lab. All rights reserved.
//

import UIKit

final class SettingsVC: UIViewController {

    @IBOutlet weak var serverUrlTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        initServerUrlTextField()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initUISaveButton()
    }

    @IBAction func saveButtonClicked(_ sender: UIButton) {
        guard var text = serverUrlTextField.text, !text.isBlank else { return }
        if !text.contains("http://"), !text.contains("https://") {
            text = "http://\(text)"
        }
        ServerBase.setBaseAddress(text)
    }
}

// MARK: initialisations
private extension SettingsVC {

    func initServerUrlTextField() {
        serverUrlTextField.text = ServerBase.baseAddress
    }

    func initUISaveButton() {
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderColor = UIColor.lightGray.cgColor
        saveButton.layer.borderWidth = 1
    }
}
