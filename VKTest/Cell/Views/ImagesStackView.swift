//
//  ImagesStackView.swift
//  VKTest
//
//  Created by Anton on 05.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit

final class ImagesStackView: UIStackView
{

	// MARK: - Internal methods

	func setImageViews(_ images: [PreviewImage]) {
		arrangedSubviews.forEach { $0.removeFromSuperview() }

		guard let firstImage = images.first else { return }

		axis = .vertical
		distribution = .fillEqually
		spacing = 4
		
		if firstImage.height > firstImage.width { createStackViewsIfFirstPhotoIsVertical(images: images) }
		else { createStackViewsIfFirstPhotoIsHorizontal(images: images) }
	}

	private func createStackViewsIfFirstPhotoIsVertical(images: [PreviewImage]) {
		guard let firstImage = images.first else { return }

		switch images.count {
		case 1:
			addArrangedSubview(PostImageView(with: firstImage))
		case 2:
			addArrangedSubview(PostImageView(with: firstImage))
			addArrangedSubview(PostImageView(with: images[1]))
		case 3:
			addArrangedSubview(PostImageView(with: firstImage))
			let verticalStackView = UIStackView(arrangedSubviews: [PostImageView(with: images[1]), PostImageView(with: images[2])])
			verticalStackView.axis = .vertical
			verticalStackView.distribution = .fillProportionally
			verticalStackView.spacing = 4
			addArrangedSubview(verticalStackView)
			axis = .horizontal
		case 4:
			let verticalStackView = UIStackView(arrangedSubviews: images[1...3].map { PostImageView(with: $0) })
			verticalStackView.axis = .vertical
			verticalStackView.distribution = .fillProportionally
			verticalStackView.spacing = 4
			addArrangedSubview(PostImageView(with: firstImage))
			addArrangedSubview(verticalStackView)
			axis = .horizontal
		case 5:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...2].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[3...4].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack].forEach {
				$0.axis = .horizontal
				$0.spacing = 4
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		case 6:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...2].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[3...5].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack].forEach {
				$0.axis = .horizontal
				$0.spacing = 4
				$0.distribution = .fillEqually
				addArrangedSubview($0)
			}
		case 7:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...4].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[5...6].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack].forEach {
				$0.axis = .horizontal
				$0.spacing = 4
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		case 8:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...4].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[5...7].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack].forEach {
				$0.axis = .horizontal
				$0.spacing = 4
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		case 9:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...4].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[5...8].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack].forEach {
				$0.axis = .horizontal
				$0.spacing = 4
				$0.distribution = .fillEqually
				addArrangedSubview($0)
			}
		default:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...4].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[5...9].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack].forEach {
				$0.axis = .horizontal
				$0.spacing = 4
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		}
	}

	private func createStackViewsIfFirstPhotoIsHorizontal(images: [PreviewImage]) {
		guard let firstImage = images.first else { return }

		switch images.count {
		case 1:
			addArrangedSubview(PostImageView(with: firstImage))
		case 2:
			addArrangedSubview(PostImageView(with: firstImage))
			addArrangedSubview(PostImageView(with: images[1]))
		case 3:
			addArrangedSubview(PostImageView(with: firstImage))
			let horizontalStackView = UIStackView(arrangedSubviews: [PostImageView(with: images[1]), PostImageView(with: images[2])])
			horizontalStackView.axis = .horizontal
			horizontalStackView.distribution = .fillProportionally
			horizontalStackView.spacing = 4
			addArrangedSubview(horizontalStackView)
		case 4:
			let firstStackView = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondStackView = UIStackView(arrangedSubviews: images[2...3].map { PostImageView(with: $0) })
			[firstStackView, secondStackView].forEach {
				addArrangedSubview($0)
				$0.spacing = 4
				$0.axis = .horizontal
				$0.distribution = .fillProportionally
			}
		case 5:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...2].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[3...4].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack].forEach {
				$0.spacing = 4
				$0.axis = .horizontal
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		case 6:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...2].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[3...5].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack].forEach {
				$0.spacing = 4
				$0.axis = .horizontal
				$0.distribution = .fillEqually
				addArrangedSubview($0)
			}
		case 7:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...4].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[5...6].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack].forEach {
				$0.spacing = 4
				$0.axis = .horizontal
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		case 8: // - TODO: Всё что ниже - допилить
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...4].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[5...7].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack].forEach {
				$0.spacing = 4
				$0.axis = .horizontal
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		case 9:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...3].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[4...5].map { PostImageView(with: $0) })
			let fourthHorizontalStack = UIStackView(arrangedSubviews: images[6...8].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack, fourthHorizontalStack].forEach {
				$0.spacing = 4
				$0.axis = .horizontal
				$0.distribution = .fillEqually
				addArrangedSubview($0)
			}
		default:
			let firstHorizontalStack = UIStackView(arrangedSubviews: images[0...1].map { PostImageView(with: $0) })
			let secondHorizontalStack = UIStackView(arrangedSubviews: images[2...4].map { PostImageView(with: $0) })
			let thirdHorizontalStack = UIStackView(arrangedSubviews: images[5...6].map { PostImageView(with: $0) })
			let fourthHorizontalStack = UIStackView(arrangedSubviews: images[7...9].map { PostImageView(with: $0) })
			[firstHorizontalStack, secondHorizontalStack, thirdHorizontalStack, fourthHorizontalStack].forEach {
				$0.spacing = 4
				$0.axis = .horizontal
				$0.distribution = .fillProportionally
				addArrangedSubview($0)
			}
		}
	}
}
