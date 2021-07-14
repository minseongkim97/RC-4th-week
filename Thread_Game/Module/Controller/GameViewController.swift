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
    @IBOutlet weak var customerImage: UIImageView!
    @IBOutlet var sourceButtons: [UIButton]!
    @IBOutlet var wholeButtons: [UIButton]!
    
    var timer: Timer?
    var tacoTimer0: Timer?
    var tacoTimer1: Timer?
    var tacoTimer2: Timer?
    var tacoTimer3: Timer?
    var tacoTimer4: Timer?
    var tacoTimer5: Timer?
    var tacoTimer6: Timer?
    var tacoTimer7: Timer?
    var tacoTimer8: Timer?
    var tacoTimer9: Timer?
    var tacoTimer10: Timer?
    var tacoTimer11: Timer?
    var tacoTimer12: Timer?
    var tacoTimer13: Timer?
    var tacoTimer14: Timer?
    var tacoTimer15: Timer?

    var count: Int = 200
    var countTimeBurnTaco: Int = 30
    var countTimeBurnTaco1: Int = 30
    var countTimeBurnTaco2: Int = 30
    var sourceIndex: Int = -1
    var wholeIndex: Int = 0
    var level = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()


       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {

            self.customerImage.transform = CGAffineTransform(translationX:  -UIScreen.main.bounds.size.height/2-60, y: 0)
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
            
            RunLoop.current.run()
        }
        
        
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
            moveTacoToPlate(from: sender)
            
            
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
        DispatchQueue.main.async {
            self.timeLabel.text = String(self.count)
            
            if self.count == 20 {
                
                self.customerImage.animationImages = self.animatedImages(for: "waiting customer", imageName: "기다리는 손님")
                self.customerImage.animationDuration = 0.01
                self.customerImage.animationRepeatCount = -1
                self.customerImage.image = self.customerImage.animationImages?.first
                self.customerImage.startAnimating()
                
            }
            
            
       
            if self.count == 0 {
                self.timer!.invalidate()
                
                self.customerImage.animationImages = self.animatedImages(for: "angry customer", imageName: "화난 손님")
                self.customerImage.animationDuration = 0.01
                self.customerImage.animationRepeatCount = -1
                self.customerImage.image = self.customerImage.animationImages?.first
                self.customerImage.startAnimating()
                
                let gameovervc = self.storyboard?.instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
                self.present(gameovervc, animated: true, completion: nil)
                print("game over")
            }
        }
       

    }
    
    @objc func gestureFired(_ gesture: UITapGestureRecognizer) {
        print("fired")
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
            whole.setImage(UIImage(named: "2단계"), for: .normal)
            rotate(whole)
            level[wholeIndex] += 1
        }
        
        else if level[wholeIndex] == 3 {
            rotate(whole)
        }
    }
    
    func moveTacoToPlate(from whole: UIButton) {
        if whole.currentImage == UIImage(named: "2단계") {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFired))
            gestureRecognizer.numberOfTapsRequired = 2
            gestureRecognizer.numberOfTouchesRequired = 1
            
            whole.addGestureRecognizer(gestureRecognizer)
            whole.isUserInteractionEnabled = true
        }

    }
    
    func rotate(_ whole: UIButton) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.15 // 1바퀴 도는데 걸리는 시간
        rotation.isCumulative = true
        rotation.repeatCount = 1 // 몇번 반복 할것인가
        whole.layer.add(rotation, forKey: "rotationAnimation") // 원하는 뷰에 애니메이션 삽입
    }
    
    
    
    func animatedImages(for name: String, imageName: String) -> [UIImage] {
        
        var i = 1
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)/\(imageName)\(i)") {
            images.append(image)
            i += 1
        }
        return images
    }
}
