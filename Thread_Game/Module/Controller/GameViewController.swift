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
    @IBOutlet var wholeButtons: [UIButton]!
    
    var timer: Timer = Timer()
    var count: Int = 10
    var sourceIndex: Int = 0
    var wholeIndex: Int = 0
    var level = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
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
        sourceIndex = sourceButtons.firstIndex(of: sender)!

    }
    
    @IBAction func wholeBtnPressed(_ sender: UIButton) {
        wholeIndex = wholeButtons.firstIndex(of: sender)!
        print(wholeIndex)
        switch sourceIndex {
        case 0:
            if level[wholeIndex] == 0 {
                putDough(in: sender)
            }
        case 1:
            if level[wholeIndex] == 1 {
                putOct(in: sender)
            }
        case 2:
            flipDough(over: sender)
        case 3:
            sender.setImage( UIImage(named: "반죽"), for: .normal)
        case 4:
            sender.setImage( UIImage(named: "반죽"), for: .normal)
        default:
            print("이 단계가 아닙니다.")
        }
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
    
    func putDough(in whole: UIButton) {
        whole.setImage(UIImage(named: "반죽"), for: .normal)
        level[wholeIndex] += 1
    }
    
    func putOct(in whole: UIButton) {
        whole.setImage(UIImage(named: "문어올린반죽"), for: .normal)
        level[wholeIndex] += 1
    }
    
    func flipDough(over whole: UIButton) {
        if level[wholeIndex] == 2 {
            whole.setImage(UIImage(named: "1단계"), for: .normal)
            level[wholeIndex] += 1
        } else if level[wholeIndex] == 3 {
            let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = Double.pi * 2
            rotation.duration = 0.15 // 1바퀴 도는데 걸리는 시간
            rotation.isCumulative = true
            rotation.repeatCount = 1 // 몇번 반복 할것인가
            whole.layer.add(rotation, forKey: "rotationAnimation") // 원하는 뷰에 애니메이션 삽입
        }
    }
}
