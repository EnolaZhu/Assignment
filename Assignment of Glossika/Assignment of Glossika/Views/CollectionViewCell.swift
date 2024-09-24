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

    override init(frame: CGRect) {
        imageView = UIImageView()
        super.init(frame: frame)

        // Setup imageView
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 16
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

    // Function to configure the cell based on media type
    func configureCell(with media: MediaType) {
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

    // Setup AVPlayerLayer for video
    private func setupPlayer(url: URL) {
        // Remove the previous player layer if it exists
        playerLayer?.removeFromSuperlayer()

        // Create new AVPlayer
        player = AVPlayer(url: url)

        // Create and configure AVPlayerLayer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = contentView.bounds
        playerLayer.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerLayer)
        self.playerLayer = playerLayer

        // Start playing the video
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
}
