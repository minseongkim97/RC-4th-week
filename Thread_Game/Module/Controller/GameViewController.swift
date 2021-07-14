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
    @IBOutlet weak var plateButton: UIButton!
    
    
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
    var score: Int = 0
    var countTimeBurnTaco0: Int = 30
    var countTimeBurnTaco1: Int = 30
    var countTimeBurnTaco2: Int = 30
    var countTimeBurnTaco3: Int = 30
    var countTimeBurnTaco4: Int = 30
    var countTimeBurnTaco5: Int = 30
    var countTimeBurnTaco6: Int = 30
    var countTimeBurnTaco7: Int = 30
    var countTimeBurnTaco8: Int = 30
    var countTimeBurnTaco9: Int = 30
    var countTimeBurnTaco10: Int = 30
    var countTimeBurnTaco11: Int = 30
    var countTimeBurnTaco12: Int = 30
    var countTimeBurnTaco13: Int = 30
    var countTimeBurnTaco14: Int = 30
    var countTimeBurnTaco15: Int = 30
    var sourceIndex: Int = -1
    var wholeIndex: Int = 0
    var tacoNumInPlate: Int = 0
    var level = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {

            self.customerImage.transform = CGAffineTransform(translationX:  -UIScreen.main.bounds.size.width/4, y: 0)
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
            doubleTapGesture(from: sender)
            removeBurnTaco(at: sender)
        default:
            print("이 단계가 아닙니다.")
        }
    }
    
    @IBAction func plateBtnPressed(_ sender: UIButton) {
        
        if tacoNumInPlate == 8 && sourceIndex == 3 {
            
            switch plateButton.currentImage {
            case UIImage(named: "제공판8"):
                plateButton.setImage(UIImage(named: "소스1"), for: .normal)
            case UIImage(named: "소스1"):
                plateButton.setImage(UIImage(named: "소스2"), for: .normal)
            case UIImage(named: "소스2"):
                plateButton.setImage(UIImage(named: "소스3"), for: .normal)
            case UIImage(named: "소스3"):
                plateButton.setImage(UIImage(named: "소스4"), for: .normal)
            case UIImage(named: "소스4"):
                plateButton.setImage(UIImage(named: "소스5"), for: .normal)
            case UIImage(named: "소스5"):
                plateButton.setImage(UIImage(named: "소스6"), for: .normal)
            case UIImage(named: "소스6"):
                plateButton.setImage(UIImage(named: "소스7"), for: .normal)
            case UIImage(named: "소스7"):
                plateButton.setImage(UIImage(named: "소스8"), for: .normal)
         
            default:
                print("full sauce")
            }
        }
        
        if sourceIndex == 4 && sender.currentImage == UIImage(named: "소스8") {
            tacoNumInPlate = 0
            sender.setImage(UIImage(named: "제공판"), for: .normal)
            score += 1
            scoreLabel.text = String(score)
            UIView.animate(withDuration: 1) {
                self.customerImage.transform = CGAffineTransform(translationX:  -UIScreen.main.bounds.size.width, y: 0)
            } completion: { _ in
                UIView.animate(withDuration: 0) {
                    self.customerImage.transform = CGAffineTransform.identity
                }
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {

                    self.customerImage.transform = CGAffineTransform(translationX:  -UIScreen.main.bounds.size.width/4, y: 0)
                }
            }

        }
    }
    
    
    //MARK: - Objc Function
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
    
    @objc func gestureFired(_ gesture: UITapGestureRecognizer, whole: UIButton) {
        print(tacoNumInPlate)
        
        switch tacoNumInPlate {
        case 0:
            plateButton.setImage(UIImage(named: "제공판1"), for: .normal)
            tacoNumInPlate += 1
            
        case 1:
            plateButton.setImage(UIImage(named: "제공판2"), for: .normal)
            tacoNumInPlate += 1
        case 2:
            plateButton.setImage(UIImage(named: "제공판3"), for: .normal)
            tacoNumInPlate += 1
        case 3:
            plateButton.setImage(UIImage(named: "제공판4"), for: .normal)
            tacoNumInPlate += 1
        case 4:
            plateButton.setImage(UIImage(named: "제공판5"), for: .normal)
            tacoNumInPlate += 1
        case 5:
            plateButton.setImage(UIImage(named: "제공판6"), for: .normal)
            tacoNumInPlate += 1
        case 6:
            plateButton.setImage(UIImage(named: "제공판7"), for: .normal)
            tacoNumInPlate += 1
        case 7:
            plateButton.setImage(UIImage(named: "제공판8"), for: .normal)
            tacoNumInPlate += 1

        default:
            print("plate full")
        }
    }
    

    //MARK: - Function
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
            rotate(whole)
            
            switch wholeIndex {
            case 0:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer0 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco0 -= 1
                        print(self.countTimeBurnTaco0)
                      
                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco0 < 15 && self.countTimeBurnTaco0 > 0 {
                                whole.setImage(UIImage(named: "2단계"), for: .normal)
                            }
                            else if self.countTimeBurnTaco0 == 0 {
                                self.tacoTimer0!.invalidate()
                                self.countTimeBurnTaco0 = 30
                                whole.setImage(UIImage(named: "3단계"), for: .normal)
                            }
                        }
                    })
                    
                    RunLoop.current.run()
                }
            case 1:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer1 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco1 -= 1
                        print(self.countTimeBurnTaco1)
                      
                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco1 < 15 && self.countTimeBurnTaco1 > 0 {
                                whole.setImage(UIImage(named: "2단계"), for: .normal)
                            }
                            else if self.countTimeBurnTaco1 == 0 {
                                self.tacoTimer1!.invalidate()
                                self.countTimeBurnTaco1 = 30
                                whole.setImage(UIImage(named: "3단계"), for: .normal)
                            }
                        }
                    })
                    
                    RunLoop.current.run()
                }
            case 2:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer2 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco2 -= 1
                        print(self.countTimeBurnTaco2)
                      
                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco2 < 15 && self.countTimeBurnTaco2 > 0 {
                                whole.setImage(UIImage(named: "2단계"), for: .normal)
                            }
                            else if self.countTimeBurnTaco2 == 0 {
                                self.tacoTimer2!.invalidate()
                                self.countTimeBurnTaco2 = 30
                                whole.setImage(UIImage(named: "3단계"), for: .normal)
                            }
                        }
                    })
                    
                    RunLoop.current.run()
                }
            case 3:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer3 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco3 -= 1
                        print(self.countTimeBurnTaco3)
                      
                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco3 < 15 && self.countTimeBurnTaco3 > 0 {
                                whole.setImage(UIImage(named: "2단계"), for: .normal)
                            }
                            else if self.countTimeBurnTaco3 == 0 {
                                self.tacoTimer3!.invalidate()
                                self.countTimeBurnTaco3 = 30
                                whole.setImage(UIImage(named: "3단계"), for: .normal)
                            }
                        }
                    })
                    
                    RunLoop.current.run()
                }
            case 4:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer4 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco4 -= 1
                        print(self.countTimeBurnTaco4)
                      
                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco4 < 15 && self.countTimeBurnTaco4 > 0 {
                                whole.setImage(UIImage(named: "2단계"), for: .normal)
                            }
                            else if self.countTimeBurnTaco4 == 0 {
                                self.tacoTimer4!.invalidate()
                                self.countTimeBurnTaco4 = 30
                                whole.setImage(UIImage(named: "3단계"), for: .normal)
                            }
                        }
                    })
                    
                    RunLoop.current.run()
                }
                
            case 5:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer5 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco5 -= 1
                        print(self.countTimeBurnTaco5)
                      
                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco5 < 15 && self.countTimeBurnTaco5 > 0 {
                                whole.setImage(UIImage(named: "2단계"), for: .normal)
                            }
                            else if self.countTimeBurnTaco5 == 0 {
                                self.tacoTimer5!.invalidate()
                                self.countTimeBurnTaco5 = 30
                                whole.setImage(UIImage(named: "3단계"), for: .normal)
                            }
                        }
                    })
                    
                    RunLoop.current.run()
                }
                
            case 6:
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer6 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco6 -= 1
                        print(self.countTimeBurnTaco6)
                      
                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco6 < 15 && self.countTimeBurnTaco6 > 0 {
                                whole.setImage(UIImage(named: "2단계"), for: .normal)
                            }
                            else if self.countTimeBurnTaco6 == 0 {
                                self.tacoTimer6!.invalidate()
                                self.countTimeBurnTaco6 = 30
                                whole.setImage(UIImage(named: "3단계"), for: .normal)
                            }
                        }
                    })
                    
                    RunLoop.current.run()
                }
                
            default:
                print("12")
            }

            level[wholeIndex] += 1
        }
        
        else if level[wholeIndex] == 3 {
            rotate(whole)
        }
    }
    
//    @objc func counting(whole: UIButton) {
//        countTimeBurnTaco -= 1
//        print(countTimeBurnTaco)
//        if self.countTimeBurnTaco == 0 {
//            self.tacoTimer1!.invalidate()
//        }
//        DispatchQueue.main.async {
//            if self.countTimeBurnTaco > 15 && self.countTimeBurnTaco < 20 {
//                whole.setImage(UIImage(named: "2단계"), for: .normal)
//            }
//
//            else if self.countTimeBurnTaco >= 20 {
//                whole.setImage(UIImage(named: "3단계"), for: .normal)
//            }
//        }
//    }
    
    func doubleTapGesture(from whole: UIButton) {
        
        if whole.currentImage == UIImage(named: "2단계") {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFired))
            gestureRecognizer.numberOfTapsRequired = 2
            gestureRecognizer.numberOfTouchesRequired = 1
            
            whole.addGestureRecognizer(gestureRecognizer)
            whole.isUserInteractionEnabled = true
        }

    }
    
    func removeBurnTaco(at whole: UIButton) {
        if whole.currentImage == UIImage(named: "3단계") {
            whole.setImage(UIImage(named: "타코야키판홀"), for: .normal)
            level[wholeIndex] = 0
        }
    }
    
    func rotate(_ whole: UIButton) {
        if whole.currentImage == UIImage(named: "1단계") {
            let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = Double.pi * 2
            rotation.duration = 0.15 // 1바퀴 도는데 걸리는 시간
            rotation.isCumulative = true
            rotation.repeatCount = 1 // 몇번 반복 할것인가
            whole.layer.add(rotation, forKey: "rotationAnimation") // 원하는 뷰에 애니메이션 삽입
        }
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
