//
//  GradientAnimationView.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit

final class GradientAnimationView: UIView {
    
    let color1: CGColor = UIColor(red: 209/255, green: 107/255, blue: 165/255, alpha: 1).cgColor
    let color2: CGColor = UIColor(red: 134/255, green: 168/255, blue: 231/255, alpha: 1).cgColor
    let color3: CGColor = UIColor(red: 95/255, green: 251/255, blue: 241/255, alpha: 1).cgColor
    
    let gradient: CAGradientLayer = CAGradientLayer()
    var gradientColorSet: [[CGColor]] = []
    var colorIndex: Int = 0
    
    func setupGradient(){
        gradientColorSet = [
            [color1, color2],
            [color2, color3],
            [color3, color1]
        ]
        
        gradient.frame = bounds
        gradient.colors = gradientColorSet[colorIndex]
        
        layer.addSublayer(gradient)
    }
    
    func animateGradient() {
        gradient.colors = gradientColorSet[colorIndex]
        
        let gradientAnimation = CABasicAnimation(keyPath: "colors")
        gradientAnimation.delegate = self
        gradientAnimation.duration = 2.0
        
        updateColorIndex()
        gradientAnimation.toValue = gradientColorSet[colorIndex]
        
        gradientAnimation.fillMode = .forwards
        gradientAnimation.isRemovedOnCompletion = false
        
        gradient.add(gradientAnimation, forKey: "colors")
    }
    
    private func updateColorIndex(){
        if colorIndex < gradientColorSet.count - 1 {
            colorIndex += 1
        } else {
            colorIndex = 0
        }
    }
    
    private func setupLayout() {
        
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension GradientAnimationView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            animateGradient()
        }
    }
}
