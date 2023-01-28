//
//  GifDetailViewController.swift
//  GiphyViewer
//
//  Created by Vladislav Panev on 27.01.2023.
//

import UIKit
import SDWebImage
import NotificationBannerSwift

protocol GifDetailViewInput: PreloaderViewPresentable {
    func setupLayout(with ratio: CGFloat, imageUrl: String)
    func showErrorAlert(error: Error)
}

final class GifDetailViewController: UIViewController {
    
    var presenter: GifDetailPresenterInput?
    var loadingCounter: Int = 0
    
    private var imageUrl = ""
    private let hdPreviewImageView = SDAnimatedImageView()
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Скопировать URL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = UIColor(named: "secondButtonColor")
        button.addTarget(self, action: #selector(copyButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupButtonLayout()
        setupNavBarBtn()
        presenter?.viewDidLoad()
    }
    
    private func setupButtonLayout() {
        
        view.addSubview(copyButton)
        copyButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(48)
        }
    }
    
    private func setupNavBarBtn() {
        
        let comunicateImage = UIImage(systemName: "square.and.arrow.up")
        let comunicateBtn = UIBarButtonItem(
            image: comunicateImage,
            style: .plain,
            target: self,
            action: #selector(shareButtonPressed)
        )
        
        comunicateBtn.tintColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = comunicateBtn
        
    }
    
    @objc private func shareButtonPressed() {
        
        guard let image = hdPreviewImageView.image else { return }
        
        let imageToShare = [image]
        let activityController = UIActivityViewController(
            activityItems: imageToShare,
            applicationActivities: nil
        )
        self.present(activityController, animated: true, completion: nil)
        
    }
    
    @objc private func copyButtonPressed() {
        UIPasteboard.general.string = presenter?.getGifStringLink() ?? ""
        let banner = StatusBarNotificationBanner(title: "Скопировано!", style: .success)
        banner.show()
    }
}

extension GifDetailViewController: GifDetailViewInput {
    
    func setupLayout(with ratio: CGFloat, imageUrl: String) {
        self.imageUrl = imageUrl
        view.addSubview(hdPreviewImageView)
        hdPreviewImageView.sd_imageIndicator = LoadingIndicator()
        hdPreviewImageView.sd_setImage(with: URL(string: imageUrl))
        hdPreviewImageView.startAnimating()
        hdPreviewImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.lessThanOrEqualTo(copyButton.snp.top).inset(24)
        }
    }
    
    func showErrorAlert(error: Error) {
        let alertVC = UIAlertController(title: "Ошибка", message: error.localizedDescription, preferredStyle: .alert)
        let oneMoreAction = UIAlertAction(title: "Повторить", style: .default, handler: { [weak self] _ in
            self?.presenter?.viewDidLoad()
        })
        alertVC.addAction(oneMoreAction)
        
        present(alertVC, animated: true)
    }
}
