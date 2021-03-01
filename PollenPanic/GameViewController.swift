//
//  GameViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 28/02/2021.
//

import UIKit

class GameViewController : UIViewController {
    
    @IBOutlet weak var swipeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        let leftSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(handleLeftSwipeGesture(sender:))
        )
        
        let rightSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(handleRightSwipeGesture(sender:))
        )
        
        let downSwipeGestureHandler = UISwipeGestureRecognizer(
            target: self, action: #selector(handleDownSwipeGesture(sender:))
        )
        
        leftSwipeGestureHandler.direction = .left
        rightSwipeGestureHandler.direction = .right
        downSwipeGestureHandler.direction = .down
        
        self.view.addGestureRecognizer(leftSwipeGestureHandler)
        self.view.addGestureRecognizer(rightSwipeGestureHandler)
        self.view.addGestureRecognizer(downSwipeGestureHandler)
    }
    
    @objc func handleLeftSwipeGesture (sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Current swipe direction: LEFT"
    }
    
    @objc func handleRightSwipeGesture (sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Current swipe direction: RIGHT"
    }
    
    @objc func handleDownSwipeGesture (sender: UISwipeGestureRecognizer) {
        swipeLabel.text = "Current swipe direction: DOWN"
    }
}
