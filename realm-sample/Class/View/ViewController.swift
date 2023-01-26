//
//  ViewController.swift
//  realm-sample
//
//  Created by 岡本 翔真 on 2023/01/26.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var activationIdLabel: UILabel!
    @IBOutlet weak var activationCodeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var activationIdTextField: UITextField!
    @IBOutlet weak var activationCodeTextField: UITextField!
    @IBOutlet weak var activationButton: UIButton!

    private let presenter = ActivationPresenter(repository: ActivationRepository())

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

