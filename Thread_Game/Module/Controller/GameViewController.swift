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
    var tacoTimer15: Timer?
    var countTimeBurnTaco15: Int = 30
    
    var count: Int = 200
    var score: Int = 0
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
            removeBurnTaco(at: sender)
        default:
            print("??? ????????? ????????????.")
        }
    }
    
    @IBAction func plateBtnPressed(_ sender: UIButton) {
        
        if tacoNumInPlate == 8 && sourceIndex == 3 {
            
            switch plateButton.currentImage {
            case UIImage(named: "?????????8"):
                plateButton.setImage(UIImage(named: "??????1"), for: .normal)
            case UIImage(named: "??????1"):
                plateButton.setImage(UIImage(named: "??????2"), for: .normal)
            case UIImage(named: "??????2"):
                plateButton.setImage(UIImage(named: "??????3"), for: .normal)
            case UIImage(named: "??????3"):
                plateButton.setImage(UIImage(named: "??????4"), for: .normal)
            case UIImage(named: "??????4"):
                plateButton.setImage(UIImage(named: "??????5"), for: .normal)
            case UIImage(named: "??????5"):
                plateButton.setImage(UIImage(named: "??????6"), for: .normal)
            case UIImage(named: "??????6"):
                plateButton.setImage(UIImage(named: "??????7"), for: .normal)
            case UIImage(named: "??????7"):
                plateButton.setImage(UIImage(named: "??????8"), for: .normal)
         
            default:
                print("full sauce")
            }
        }
        
        if sourceIndex == 4 && sender.currentImage == UIImage(named: "??????8") {
            customerImage.image = UIImage(named: "?????? ??????")
            tacoNumInPlate = 0
            sender.setImage(UIImage(named: "?????????"), for: .normal)
            score += 1
            count += 5
            scoreLabel.text = String(score)
            UIView.animate(withDuration: 1.5) {
                
                self.customerImage.transform = CGAffineTransform(translationX:  -UIScreen.main.bounds.size.width * 2, y: 0)
                
            } completion: { _ in
                self.customerImage.image = UIImage(named: "??????")
                
                UIView.animate(withDuration: 0) {
                    self.customerImage.transform = CGAffineTransform.identity
                } completion: { _ in
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {

                        self.customerImage.transform = CGAffineTransform(translationX:  -UIScreen.main.bounds.size.width/4, y: 0)
                    }
                }
            }
        }
    }
    
    
    //MARK: - Objc Function
    @objc func timerCounter() {
       
        
        DispatchQueue.main.async {
            // count??? ?????? UI??? ????????????
            self.count -= 1
            self.timeLabel.text = String(self.count)
            if self.count > 20 {

                self.customerImage.image = UIImage(named: "??????")
            }
            
            if self.count == 20 {
                
                self.customerImage.animationImages = self.animatedImages(for: "waiting customer", imageName: "???????????? ??????")
                self.customerImage.animationDuration = 0.01
                self.customerImage.animationRepeatCount = -1
                self.customerImage.image = self.customerImage.animationImages?.first
                self.customerImage.startAnimating()
                
            }
       
            if self.count == 0 {
                self.timer!.invalidate()
                self.customerImage.animationImages = self.animatedImages(for: "angry customer", imageName: "?????? ??????")
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
    
    @objc func gestureFired(_ gesture: CustomTapGesture) {
        
       
        
        if gesture.button.currentImage == UIImage(named: "2??????") && sourceIndex == 2 {
            gesture.button.layer.removeAllAnimations()
            switch tacoNumInPlate {
            case 0:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????1"), for: .normal)
                tacoNumInPlate += 1
               
                self.level[gesture.tacoIndex] = 0
            case 1:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????2"), for: .normal)
                tacoNumInPlate += 1
               
                self.level[gesture.tacoIndex] = 0
            case 2:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????3"), for: .normal)
                tacoNumInPlate += 1
              
                self.level[gesture.tacoIndex] = 0
            case 3:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????4"), for: .normal)
                tacoNumInPlate += 1
              
                self.level[gesture.tacoIndex] = 0
            case 4:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????5"), for: .normal)
                tacoNumInPlate += 1
               
                self.level[gesture.tacoIndex] = 0
            case 5:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????6"), for: .normal)
                tacoNumInPlate += 1
              
                self.level[gesture.tacoIndex] = 0
            case 6:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????7"), for: .normal)
                tacoNumInPlate += 1
             
                self.level[gesture.tacoIndex] = 0
            case 7:
                gesture.button.setImage(UIImage(named: "??????????????????"), for: .normal)
                gesture.button.removeGestureRecognizer(gesture)
                plateButton.setImage(UIImage(named: "?????????8"), for: .normal)
                tacoNumInPlate += 1
              
                self.level[gesture.tacoIndex] = 0

            default:
                print("plate full")
            }
       

        }

    }
    

    //MARK: - Function
    func putDough(in whole: UIButton) {
        whole.setImage(UIImage(named: "??????"), for: .normal)
        level[wholeIndex] += 1
    }
    
    func putOct(in whole: UIButton) {
        whole.setImage(UIImage(named: "??????????????????"), for: .normal)
        level[wholeIndex] += 1
    }
    
    func flipDough(over whole: UIButton) {
      
        if level[wholeIndex] == 2 {
            whole.setImage(UIImage(named: "1??????"), for: .normal)
            rotate(whole)
            
            switch wholeIndex {
            case 0:
               
                let tacoIndex = 0
                
                tacoStep(at: whole, tacoIndex: tacoIndex)

                
            case 1:
                let tacoIndex = 1
                
                tacoStep(at: whole, tacoIndex: tacoIndex)
                
                
            case 2:
                let tacoIndex = 2
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 3:
                let tacoIndex = 3
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 4:
                let tacoIndex = 4
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 5:
                let tacoIndex = 5
                tacoStep(at: whole, tacoIndex: tacoIndex)
                
            case 6:
                let tacoIndex = 6
                tacoStep(at: whole, tacoIndex: tacoIndex)

            case 7:
                let tacoIndex = 7
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 8:
                let tacoIndex = 8
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 9:
                let tacoIndex = 9
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 10:
                let tacoIndex = 10
                tacoStep(at: whole, tacoIndex: tacoIndex)

            case 11:
                let tacoIndex = 11
                tacoStep(at: whole, tacoIndex: tacoIndex)

            case 12:
                let tacoIndex = 12
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 13:
                let tacoIndex = 13
                tacoStep(at: whole, tacoIndex: tacoIndex)

            case 14:
                let tacoIndex = 14
                tacoStep(at: whole, tacoIndex: tacoIndex)
            case 15:
                let tacoIndex = 15
                let gestureRecognizer = CustomTapGesture(target: self, action: #selector(self.gestureFired))
                DispatchQueue.global(qos: .userInitiated).async {
                    self.tacoTimer15 = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
                        self.countTimeBurnTaco15 -= 1
                        print(self.countTimeBurnTaco15)

                        DispatchQueue.main.async {
                            if self.countTimeBurnTaco15 == 15 {
                                whole.setImage(UIImage(named: "2??????"), for: .normal)
                                self.doubleTapGesture(gestureRecognizer: gestureRecognizer, from: whole, index: tacoIndex)
                            }
                            
                            
                            if whole.currentImage == UIImage(named: "??????????????????") {
                                self.tacoTimer15!.invalidate()
                                self.countTimeBurnTaco15 = 30

                            }
                            
                            if self.count == 0 {
                                self.tacoTimer15!.invalidate()
                            }
                            
                            if self.countTimeBurnTaco15 == 0 {
                                whole.removeGestureRecognizer(gestureRecognizer)
                                self.tacoTimer15!.invalidate()
                                self.countTimeBurnTaco15 = 30
                                
                                whole.setImage(UIImage(named: "3??????"), for: .normal)
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
    
    
    func doubleTapGesture(gestureRecognizer: CustomTapGesture,from whole: UIButton, index tacoIndex: Int) {
 
        gestureRecognizer.button = whole
        gestureRecognizer.tacoIndex = tacoIndex
        gestureRecognizer.numberOfTapsRequired = 2
        gestureRecognizer.numberOfTouchesRequired = 1

        whole.addGestureRecognizer(gestureRecognizer)
    }
    
    
    func tacoStep(at whole: UIButton, tacoIndex: Int) {
        let gestureRecognizer = CustomTapGesture(target: self, action: #selector(self.gestureFired))

        UIView.animate(withDuration: 15.0, delay: 0.0, options: [.allowUserInteraction]) {
                whole.alpha = 0.9
            } completion: { _ in
                whole.setImage(UIImage(named: "2??????"), for: .normal)
                self.doubleTapGesture(gestureRecognizer: gestureRecognizer, from: whole, index: tacoIndex)
                
                UIView.animate(withDuration: 15.0, delay: 0.0, options: [.allowUserInteraction]) {
                    whole.alpha = 1
                } completion: { _ in
                    whole.removeGestureRecognizer(gestureRecognizer)
                    if whole.currentImage == UIImage(named: "2??????") {
                        whole.setImage(UIImage(named: "3??????"), for: .normal)
                    }
                }
                 
            }
        
    }
    
    func removeBurnTaco(at whole: UIButton) {
        if whole.currentImage == UIImage(named: "3??????") {
            whole.setImage(UIImage(named: "??????????????????"), for: .normal)
            level[wholeIndex] = 0
        }
    }
    
    func rotate(_ whole: UIButton) {
        if whole.currentImage == UIImage(named: "1??????") {
            let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.toValue = Double.pi * 2
            rotation.duration = 0.15 // 1?????? ????????? ????????? ??????
            rotation.isCumulative = true
            rotation.repeatCount = 1 // ?????? ?????? ????????????
            whole.layer.add(rotation, forKey: "rotationAnimation") // ????????? ?????? ??????????????? ??????
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
