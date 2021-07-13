//
//  ViewController.swift
//  Thread_Game
//
//  Created by MIN SEONG KIM on 2021/07/11.
//

import UIKit

class StartViewController: UIViewController {

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    //MARK: - Function
    @IBAction func playBtnPressed(_ sender: UIButton) {
        let gamevc = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        present(gamevc, animated: true, completion: nil)
    }
}

