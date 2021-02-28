//
//  MainMenuViewController.swift
//  PollenPanic
//
//  Created by Liam Sutton on 28/02/2021.
//

import UIKit

class MainMenuViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UIWindow.appearance()
    }
    
    // Perma change navigation bar colour to yellow and text to white
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .systemYellow
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
    }
}
