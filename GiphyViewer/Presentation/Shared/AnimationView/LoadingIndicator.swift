//
//  LoadingIndicator.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//

import UIKit
import SDWebImage

final class LoadingIndicator: UIView, SDWebImageIndicator {
    
    var indicatorView: UIView = GradientAnimationView()
    
    func startAnimatingIndicator() {
        (indicatorView as? GradientAnimationView)?.setupGradient()
        (indicatorView as? GradientAnimationView)?.animateGradient()
    }
    
    func stopAnimatingIndicator() {
        (indicatorView as? GradientAnimationView)?.gradient.removeAllAnimations()
        (indicatorView as? GradientAnimationView)?.gradient.removeFromSuperlayer()
    }
}
