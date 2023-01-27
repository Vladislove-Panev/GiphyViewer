//
//  TransitionManager.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 27.01.2023.
//

import UIKit

final class TransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 0.8
    var presenting = true
    var originFrame = CGRect.zero
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to),
              let imageView = presenting ? toView : transitionContext.view(forKey: .from)
        else { return }
        
        containerView.addSubview(toView)
        
        let initialFrame = presenting ? originFrame : imageView.frame
        let finalFrame = presenting ? imageView.frame : originFrame
        
        let xScaleFactor = presenting ?
        initialFrame.width / finalFrame.width :
        finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
        initialFrame.height / finalFrame.height :
        finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            imageView.transform = scaleTransform
            imageView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            imageView.clipsToBounds = true
        }
        
        imageView.layer.masksToBounds = true
        
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(imageView)
        
        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.35,
            animations: {
                imageView.transform = self.presenting ? .identity : scaleTransform
                imageView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
            }, completion: { _ in
                transitionContext.completeTransition(true)
            })
    }
}


extension TransitionManager: UINavigationControllerDelegate {
    func navigationController(
        _ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation,
        from fromVC: UIViewController,
        to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
            
            return self
        }
}
