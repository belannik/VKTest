//
//  PostImageView.swift
//  VKTest
//
//  Created by Anton on 09.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import Kingfisher

final class PostImageView: UIImageView
{
	// MARK: - Property list

	private var duration: Double?

	// MARK: - Initialization

	convenience init (with previewImage: PreviewImage) {
		self.init()
		setup(previewImage)

		guard previewImage.type == .video, let duration = previewImage.duration else { return }
		setupMockPlayer(duration: duration)
	}

	deinit {
		kf.cancelDownloadTask()
	}

	// MARK: - Private methods

	private func setup(_ previewImage: PreviewImage) {
		kf.cancelDownloadTask()

		kf.setImage(with: URL(string: previewImage.path))
	}

	private func setupMockPlayer(duration: Int) {
		let playerIconImageView = UIImageView(image: UIImage(named: "icPlay"))
		let durationView = UIView()
		let durationLabel = UILabel()
		
		durationLabel.font = .systemFont(ofSize: 13)
		durationLabel.textColor = .white

		var durationString: String {
			return "\(duration / 3600):\((duration % 3600) / 60):\((duration % 3600) % 60)"
		}

		durationLabel.text = durationString
		
		durationView.backgroundColor = UIColor.black.withAlphaComponent(0.55)
		durationView.layer.cornerRadius = 5

		[playerIconImageView, durationView].forEach {
			$0.translatesAutoresizingMaskIntoConstraints = false
			addSubview($0)
		}
		durationView.addSubview(durationLabel)
		durationLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			playerIconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
			playerIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			playerIconImageView.widthAnchor.constraint(equalToConstant: 56),
			playerIconImageView.heightAnchor.constraint(equalToConstant: 56),

			durationView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
			durationView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
			durationView.heightAnchor.constraint(equalToConstant: 26),

			durationLabel.leadingAnchor.constraint(equalTo: durationView.leadingAnchor, constant: 8),
			durationLabel.trailingAnchor.constraint(equalTo: durationView.trailingAnchor, constant: -8),
			durationLabel.topAnchor.constraint(equalTo: durationView.topAnchor, constant: 4),
			durationLabel.bottomAnchor.constraint(equalTo: durationView.bottomAnchor, constant: -4),
		])
	}
}
