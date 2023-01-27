//
//  ViewController.swift
//  SOLID
//
//  Created by dzmitry on 25.01.23.
//

import UIKit

// MARK: - ViewController

class ViewController: UIViewController {
    let dataFetcherService: DataFetcherServiceProtocol = DataFetcherService()
    let dataStore = DataStore.shared
    let validateService = ValidateService.shared

    @IBOutlet var myTextField: UITextField!
    @IBOutlet var textLabel: UILabel!
    @IBOutlet var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false

        dataFetcherService.fetchCountry { countries in
            print("\n- - - fetchCountry: ")
            print(countries?.first?.Name as Any)
        }
        
        dataFetcherService.fetchFreeGames { freeGames in
            print(freeGames?.feed.results.first?.name as Any)
        }
        
        dataFetcherService.fetchPaidGames { paidGames in
            print(paidGames?.feed.results.first?.name as Any)
        }
        
        dataFetcherService.fetchLocalCountry { localCountries in
            print("\n- - - fetchLocalCountry: ")
            print(localCountries?.last?.Name ?? "", "\n")
        }
    }

    // MARK: - Business logic

    func changeName() {
        guard let name = textLabel.text, name != "" else {
            showAlert()
            return
        }
        dataStore.saveName(name: name)
    }

    // MARK: - User interface

    func showAlert() {
        let alert = UIAlertController(title: "WARNING", message: "Your name can't be empty.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okey", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func changeLabel(_ sender: Any) {
        if let email = myTextField.text,
           validateService.isValidEmail(email)
        {
            textLabel.text = "Coool!!!"
            saveButton.isEnabled = true
        } else {
            textLabel.text = "Bad email"
            saveButton.isEnabled = false
        }
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        changeName()
    }
}
