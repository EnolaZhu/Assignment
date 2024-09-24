//
//  CollectionViewCell.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/23.
//

import UIKit
import AVFoundation

enum MediaType {
    case image(UIImage)
    case video(URL)
}

class CollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    private let cornerRadius = 16.0

    override init(frame: CGRect) {
        imageView = UIImageView()
        super.init(frame: frame)

        // Setup imageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = cornerRadius
        contentView.addSubview(imageView)

        // Set imageView constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setItems(item: MainPageAssetItem) {
        if let type = item.type {
            switch AssetMediaType(rawValue: type) {
            case .jpg:
                UIImage.loadImage(from: item.asset) { [weak self] image in
                    if let image = image {
                        self?.configureCell(with: .image(image))
                    }
                }
            case .mp4:
                if let url = URL(string: item.asset) {
                    configureCell(with: .video(url))
                }
            default:
                break
            }
        }
    }

    private func configureCell(with media: MediaType) {
        switch media {
        case .image(let image):
            imageView.isHidden = false
            playerLayer?.isHidden = true
            imageView.image = image
        case .video(let url):
            imageView.isHidden = true
            setupPlayer(url: url)
        }
    }

    private func setupPlayer(url: URL) {
        playerLayer?.removeFromSuperlayer()
        player = AVPlayer(url: url)

        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = contentView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerLayer)
        self.playerLayer = playerLayer
        applyCornerRadiusToPlayerLayer()

        player?.play()
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        // Stop the player and remove it
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        player = nil

        // Reset the image view
        imageView.image = nil
        imageView.isHidden = false
    }

    private func applyCornerRadiusToPlayerLayer() {
        guard let playerLayer = playerLayer else { return }

        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: CGFloat(cornerRadius)).cgPath
        playerLayer.mask = maskLayer
    }
}
