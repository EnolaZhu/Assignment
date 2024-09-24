//
//  TableViewCell.swift
//  Assignment of Glossika
//
//  Created by enola.zhu on 2024/9/23.
//

import UIKit

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let collectionView: UICollectionView
    private let titleLabel: UILabel
    private let moreButton: UIButton
    private let ReuseIdentifier = "ReuseIdentifier"
    var images: [UIImage] = []
    var moreButtonDidPress: () -> Void = {}

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.collectionView?.showsHorizontalScrollIndicator = false
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        titleLabel.text = "Enola"
        moreButton = UIButton()
        moreButton.setImage(UIImage(named: "right_arrow"), for: .normal)

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: ReuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        moreButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(collectionView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(moreButton)

        // Set constraints

        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            moreButton.heightAnchor.constraint(equalToConstant: 20),
            moreButton.heightAnchor.constraint(equalToConstant: 20),
            moreButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        moreButton.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with images: [UIImage]) {
        self.images = images
        collectionView.reloadData()
    }

    @objc private func moreButtonPressed() {
        print("Enola moreButtonPressed")
        moreButtonDidPress()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier, for: indexPath) as! CollectionViewCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        16.0
    }
}
