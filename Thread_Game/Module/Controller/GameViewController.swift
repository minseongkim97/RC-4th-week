//
//  GameViewController.swift
//  Thread_Game
//
//  Created by MIN SEONG KIM on 2021/07/13.
//

import UIKit

class GameViewController: UIViewController {

    //MARK: - Property
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var sourceButtons: [UIButton]!
    
    var timer: Timer = Timer()
    var count: Int = 10
    var sourceIndex: Int = 0
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
    }
    
    //MARK: - Action
    @IBAction func sourceButtonPressed(_ sender: UIButton) {
        for sourceBtn in sourceButtons {
            sourceBtn.backgroundColor = .white
        }
        sender.backgroundColor = .yellow

    }
    
    @IBAction func wholeBtnPressed(_ sender: UIButton) {
        
    }
    //MARK: - Function
    @objc func timerCounter() {
        count -= 1
       
        timeLabel.text = String(count)
        
        if count == 0 {
            timer.invalidate()
            print("game over")
        }
    }
}
