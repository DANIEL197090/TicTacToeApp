//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Decagon on 18/09/2021.
//  Copyright © 2021 Macco. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

  @IBOutlet weak var playerNameLabel: UILabel!
  @IBOutlet weak var playerScoreLabel: UILabel!
  @IBOutlet weak var computerScoreLabel: UILabel!
  @IBOutlet weak var box1: UIImageView!
  @IBOutlet weak var box2: UIImageView!
  @IBOutlet weak var box3: UIImageView!
  @IBOutlet weak var box4: UIImageView!
  @IBOutlet weak var box5: UIImageView!
  @IBOutlet weak var box6: UIImageView!
  @IBOutlet weak var box7: UIImageView!
  @IBOutlet weak var box8: UIImageView!
  @IBOutlet weak var box9: UIImageView!
  
  var playerName: String!
  var lastValue = "o"
  var playerChioces: [Box] = []
  var computerChioces: [Box] = []
  
  override func viewDidLoad() {
        super.viewDidLoad()
    playerNameLabel.text = playerName + " :"
    createTap(on: box1, type:.one)
    createTap(on: box2, type:.two)
    createTap(on: box3, type:.three)
    createTap(on: box4, type:.four)
    createTap(on: box5, type:.five)
    createTap(on: box6, type:.six)
    createTap(on: box7, type:.seven)
    createTap(on: box8, type:.eight)
    createTap(on: box9, type:.nine)
   
        // Do any additional setup after loading the view.
    }
  
  func createTap(on imageView: UIImageView, type box: Box){
    let tap = UITapGestureRecognizer(target: self , action: #selector(self.boxClicked))
    tap.name = box.rawValue
    imageView.isUserInteractionEnabled =  true
    imageView.addGestureRecognizer(tap)
  }
    
  @objc func boxClicked(_ sender: UITapGestureRecognizer){
    let selectedBox = getBox(from: sender.name ?? "")
    makeChoice(selectedBox)
    playerChioces.append(Box(rawValue: sender.name!)!)
    checkIfWon()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.computerPlay()
    }
  }
  
  func computerPlay(){
    var availableSpaces = [UIImageView]()
    var availableBoxes = [Box]()
    
    for name in Box.allCases {
      let box = getBox(from: name.rawValue)
      if box.image == nil {
        availableSpaces.append(box)
        availableBoxes.append(name)
      }
    }
    
    guard availableBoxes.count > 0 else {return }
    
    let randIndex = Int.random(in: 0 ..< availableSpaces.count)
    makeChoice(availableSpaces[randIndex])
    computerChioces.append(availableBoxes[randIndex])
    checkIfWon()
    
  }
  
  func checkIfWon() {
    var correct = [[Box]]()
    
    let firstRow: [Box]  = [.one, .two, .three]
    let secondRow: [Box]  = [.four, .five, .six]
    let thirdRow: [Box]  = [.seven, .eight, .nine]
    
    let firstCol: [Box]  = [.one, .four, .seven]
    let secondCol: [Box]  = [.two, .five, .eight]
    let thirdCol: [Box]  = [.three, .six, .nine]
    
    let backwardSlash: [Box]  = [.one, .five, .nine]
    let forwardSlash: [Box]  = [.three, .five, .seven]
    
    correct.append(firstRow)
    correct.append(secondRow)
    correct.append(thirdRow)
    correct.append(firstCol)
    correct.append(secondCol)
    correct.append(thirdCol)
    correct.append(backwardSlash)
    correct.append(forwardSlash)
    
    for valid in correct {
      let userMatch = playerChioces.filter { valid.contains($0)}.count
      let computerMatch = computerChioces.filter {valid.contains($0)}.count
      
      if userMatch == valid.count {
        let alert = UIAlertController(title: "😄", message: "Nice Job you won!!!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion : nil)
        playerScoreLabel.text = String((Int(playerScoreLabel.text ?? "0") ?? 0) +  1 )
        resetGame()
        break
        
      }else if computerMatch == valid.count {
        let alert = UIAlertController(title: "🤪", message: "You lost, you can try again!!!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion : nil)
        computerScoreLabel.text = String((Int(computerScoreLabel.text ?? "0") ?? 0) +  1 )
        resetGame()
        break
      }else if computerChioces.count + playerChioces.count == 9 {
        let alert = UIAlertController(title: "😔", message: "Come on, you can win, try again!!!", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Continue", style: .cancel)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion : nil)
        resetGame()
        break
      }
    }
  }
  
  func resetGame() {
    for name in Box.allCases {
      let box  = getBox(from: name.rawValue)
      box.image = nil
    }
    lastValue = "o"
    playerChioces = []
    computerChioces = []
  }
  
  func makeChoice(_ selectedBox: UIImageView){
    guard selectedBox.image == nil else { return }
    if lastValue == "x" {
      selectedBox.image =  #imageLiteral(resourceName: "oh")
      lastValue = "x"
    }else {
      selectedBox.image = #imageLiteral(resourceName: "ex")
      lastValue = "x"
    }
  }
  
  func getBox(from name: String) -> UIImageView {
    let box  =  Box(rawValue: name)  ?? .one
    
    switch box {
    case .one:
      return box1
    case .two:
      return box2
    case .three:
      return box3
    case .four:
      return box4
    case .five:
      return box5
    case .six:
      return box6
    case .seven:
      return box7
    case .eight:
      return box8
    case .nine:
      return box9
    }
  }

  @IBAction func cancelButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  

}


enum Box: String , CaseIterable{
  case one, two, three ,four, five, six, seven, eight, nine
}
