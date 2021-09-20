//
//  ViewController.swift
//  TicTacToe
//
//  Created by Emmanuel Okwara on 24/05/2020.
//  Copyright © 2020 Macco. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    func setupUI() {
        startBtn.layer.cornerRadius = 10
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOpacity = 0.4
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = .zero
    }
    
 
  @IBAction func startButtonClicked(_ sender: UIButton) {
    guard !nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty else {
      let alert = UIAlertController(title: "Error", message: "Please fill your name!", preferredStyle: .alert)
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
      alert.addAction(cancelAction)
      self.present(alert, animated: true, completion : nil)
      return
    }
    
    let controller = storyboard?.instantiateViewController(identifier: "gameScene") as? GameViewController
    controller?.playerName = nameField.text
    controller?.modalTransitionStyle = .flipHorizontal
    controller?.modalPresentationStyle = .fullScreen
    self.present(controller!, animated: true, completion: nil)
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameField.resignFirstResponder()
    }
  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let controller  = segue.destination as? GameViewController  {
//      controller.playerName = nameField.text
//    }
//
//  }
//
  
//  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//    if identifier == "goToGameVc"  {
//      if nameField.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//        let alert = UIAlertController(title: "Error", message: "Please fill your name!", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true, completion : nil)
//         return false
//      }
//    }
//    return true
//  }
}

