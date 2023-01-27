//
//  GiphyService.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 26.01.2023.
//


import Foundation
import UIKit

protocol PreloaderViewPresentable: AnyObject {
    
    var loadingCounter: Int { get set }
    
    func showPreloaderView()
    func showPreloaderViewWithoutAlpha()
    func showPreloaderViewWithoutAlpha(with title: String)
    func hidePreloaderView()
    func hidePreloaderView(force: Bool)
}

extension PreloaderViewPresentable where Self: UIViewController {
    
    func showPreloaderView() {
        
        loadingCounter += 1
        
        guard loadingCounter == 1 else { return }
        
        let preloaderView = PreloaderView.assembly()
        addPreloaderView(preloaderView)
    }
    
    func showPreloaderViewWithoutAlpha() {
        
        loadingCounter += 1
        
        guard loadingCounter == 1 else { return }
        
        let preloaderView = PreloaderView.assembly()
        preloaderView.whithoutAlphaBack()
        addPreloaderView(preloaderView)
    }
    
    func showPreloaderViewWithoutAlpha(with title: String) {
        loadingCounter += 1
        
        guard loadingCounter == 1 else { return }
        
        let preloaderView = PreloaderView.assembly(title: title)
        preloaderView.whithoutAlphaBack()
        addPreloaderView(preloaderView)
    }
    
    private func addPreloaderView(_ preloaderView: PreloaderView) {
        view.addSubview(preloaderView)
        preloaderView.snp.makeConstraints { make in
            make.centerWithinMargins.equalToSuperview()
        }
    }
    
    func hidePreloaderView() {
        hidePreloaderView(force: false)
    }
    
    func hidePreloaderView(force: Bool) {
        
        loadingCounter = max(loadingCounter - 1, 0)
        
        guard loadingCounter == 0 || force else { return }
        
        view.subviews.forEach { (subView) in
            if subView.isKind(of: PreloaderView.self) {
                subView.removeFromSuperview()
            }
        }
    }
}
