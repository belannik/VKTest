//
//  VideoLayerMock.swift
//  VKTest
//
//  Created by Anton on 04.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

final class VideoLayerMock: UIView
{
    // MARK: - Property list

    private let playImageView = UIImageView()
    private let durationView = UIView()
    private let durationLabel = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setDuration(_ duration: String) {
        durationLabel.text = duration
    }

    private func setupConstraints() {
        [playImageView, durationView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        durationView.addSubview(durationLabel)

        NSLayoutConstraint.activate([
            playImageView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -1),
            playImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playImageView.heightAnchor.constraint(equalToConstant: 56),
            playImageView.widthAnchor.constraint(equalToConstant: 56),

            durationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            durationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            durationView.heightAnchor.constraint(equalToConstant: 26),

            durationLabel.leadingAnchor.constraint(equalTo: durationView.leadingAnchor, constant: 8),
            durationLabel.trailingAnchor.constraint(equalTo: durationView.trailingAnchor, constant: -8),
            durationLabel.topAnchor.constraint(equalTo: durationView.topAnchor, constant: 4),
            durationLabel.bottomAnchor.constraint(equalTo: durationView.bottomAnchor, constant: -4),
        ])
    }

    private func setup() {
        setupConstraints()

        playImageView.image = #imageLiteral(resourceName: "icPlay")
        playImageView.clipsToBounds = true
        playImageView.layer.cornerRadius = 28

        durationView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.55)
        durationView.layer.cornerRadius = 5
        
        durationLabel.textColor = .white
        durationLabel.font = .systemFont(ofSize: 13)
        durationLabel.textAlignment = .right
        durationLabel.addCharacterSpacing(kernValue: -0.08)
    }
}
