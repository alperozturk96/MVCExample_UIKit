//
//  SplashViewController.swift
//  MVCExample
//
//  Created by Alper Ozturk on 4.09.2023.
//

import UIKit

final class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        completeSplash()
    }
    
    private func completeSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if let navigationController = self.navigationController {
                navigationController.pushViewController(CommentViewController(), animated: true)
            }
        }
    }
}

