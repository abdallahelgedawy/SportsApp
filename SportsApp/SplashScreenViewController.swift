//
//  SplashScreenViewController.swift
//  SportsApp
//
//  Created by Abdallah Elgedawy on 05/06/2023.
//

import UIKit
import Lottie

class SplashScreenViewController: UIViewController {
    let animationView = LottieAnimationView()
   

    override func viewDidLoad() {
        super.viewDidLoad()

      setupAnimation()
    }
     

    func setupAnimation(){
        animationView.animation = LottieAnimation.named("allsports")
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
            // Center the animation view horizontally
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ])
            
            // Center the animation view vertically
            NSLayoutConstraint.activate([
                animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            var home = self.storyboard?.instantiateViewController(withIdentifier: "home") 
            home?.modalTransitionStyle = .crossDissolve
            home?.modalPresentationStyle = .fullScreen
            self.present(home! , animated: true)
        })
        
    }

}
