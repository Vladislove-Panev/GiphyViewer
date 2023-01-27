//
//  GiphyService.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//


import UIKit

final class PreloaderView: UIView {

    @IBOutlet private weak var loaderImage: UIImageView!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    static func assembly(title: String? = nil) -> PreloaderView {
        
        let view = UINib(nibName: "PreloaderView", bundle: nil).instantiate(withOwner: nil, options: nil)[0]
            as! PreloaderView
        view.backView.backgroundColor = .black
        view.titleLabel.text = title
        
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        rotateView()
    }
    
    func rotateView() {
        
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = Double.pi
        rotation.duration = 0.5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        rotation.isRemovedOnCompletion = false
        loaderImage.layer.add(rotation, forKey: nil)
    }
    
    func whithoutAlphaBack() {
        backView.alpha = 1
        backView.backgroundColor = .white
    }
}
