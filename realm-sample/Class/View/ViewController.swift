//
//  ViewController.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet private weak var activationIdLabel: UILabel!
    @IBOutlet private weak var activationCodeLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var activationIdTextField: UITextField!
    @IBOutlet private weak var activationCodeTextField: UITextField!
    @IBOutlet private weak var activationButton: UIButton!

    private let presenter = ActivationPresenter(repository: ActivationRepository(dao: Activation()))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        if let activationId = activationIdTextField.text,
           let activationCodeString = activationCodeTextField.text,
           let activationCode = Int(activationCodeString) {
            resultLabel.text = presenter.activationButtonTapped(activationId: activationId, activationCode: activationCode)
        }
    }
}

