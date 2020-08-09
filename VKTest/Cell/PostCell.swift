//
//  PostCell.swift
//  VKTest
//
//  Created by Anton on 08.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import Kingfisher

final class PostCell: UITableViewCell
{
	// MARK: - Property list

	static let reuseID = "PostCell"

	private weak var avatarImageView: UIImageView?
	private weak var postAuthorLabel: UILabel?
	private weak var dateLabel: UILabel?
	private weak var postTextLabel: UILabel?
	private weak var photosView: ImagesStackView?
	private weak var bottomView: UIView?
	private weak var likesLabel: UILabel?
	private weak var commentsLabel: UILabel?
	private weak var repostsLabel: UILabel?
	private weak var viewsImageView: UIImageView?
	private weak var viewsLabel: UILabel?

	// MARK: - Lifecycle

	override func prepareForReuse() {
		avatarImageView?.kf.cancelDownloadTask()
		avatarImageView?.image = nil
	}

	// MARK: - Internal methods

	func setup() {
		if avatarImageView == nil {
			let imageView = UIImageView(frame: CGRect(x: 18, y: 15, width: 40, height: 40))
			imageView.clipsToBounds = true
			imageView.layer.cornerRadius = 20
			contentView.addSubview(imageView)
			avatarImageView = imageView
		}
		if postAuthorLabel == nil {
			let label = UILabel(frame: CGRect(x: 70, y: 15, width: contentView.bounds.size.width - 80, height: 19))
			label.font = .systemFont(ofSize: 14, weight: .semibold)
			label.addCharacterSpacing(kernValue: -0.15)
			contentView.addSubview(label)
			postAuthorLabel = label
		}
		if dateLabel == nil {
			let label = UILabel(frame: CGRect(x: 70, y: 36, width: contentView.bounds.size.width - 80, height: 18))
			label.font = .systemFont(ofSize: 13)
			label.textColor = UIColor(red: 127/255, green: 135/255, blue: 149/255, alpha: 1)
			label.addCharacterSpacing(kernValue: -0.08)
			contentView.addSubview(label)
			dateLabel = label
		}
		if postTextLabel == nil {
			let label = UILabel(frame: CGRect(x: 18, y: 70, width: contentView.bounds.size.width - 36, height: 0))
			label.numberOfLines = 0
			label.font = .systemFont(ofSize: 14)
			contentView.addSubview(label)
			postTextLabel = label
		}
		if photosView == nil {
			let imagesStackView = ImagesStackView(frame: .zero)
			contentView.addSubview(imagesStackView)
			photosView = imagesStackView
		}
		if bottomView == nil {
			let view = UIView(frame: CGRect(x: 0, y: contentView.bounds.height - 46,
											width: contentView.bounds.width, height: 46))
			contentView.addSubview(view)
			bottomView = view

			let likesIV = UIImageView(frame: CGRect(x: 18, y: 10, width: 26, height: 26))
			likesIV.image = UIImage(named: "icLike")
			bottomView?.addSubview(likesIV)
			
			let commentsIV = UIImageView(frame: CGRect(x: 87, y: 10, width: 26, height: 26))
			commentsIV.image = UIImage(named: "icComment")
			bottomView?.addSubview(commentsIV)

			let respostsIV = UIImageView(frame: CGRect(x: 156, y: 10, width: 26, height: 26))
			respostsIV.image = UIImage(named: "icShare")
			bottomView?.addSubview(respostsIV)

			let viewsIV = UIImageView(frame: CGRect(x: 0, y: 10, width: 26, height: 26))
			viewsIV.image = UIImage(named: "icEye")
			viewsIV.isHidden = true
			bottomView?.addSubview(viewsIV)
			viewsImageView = viewsIV
		}
		let bottomLabelsFont = UIFont.systemFont(ofSize: 13) 
		let bottomLabelsColor = UIColor(red: 127/255, green: 135/255, blue: 149/255, alpha: 1)
		if likesLabel == nil {
			let label = UILabel(frame: CGRect(x: 46, y: 14, width: 41, height: 18))
			label.font = bottomLabelsFont
			label.textColor = bottomLabelsColor
			bottomView?.addSubview(label)
			likesLabel = label
		}
		if commentsLabel == nil {
			let label = UILabel(frame: CGRect(x: 115, y: 14, width: 41, height: 18))
			label.font = bottomLabelsFont
			label.textColor = bottomLabelsColor
			bottomView?.addSubview(label)
			commentsLabel = label
		}
		if repostsLabel == nil {
			let label = UILabel(frame: CGRect(x: 184, y: 14, width: 41, height: 18))
			label.font = bottomLabelsFont
			label.textColor = bottomLabelsColor
			bottomView?.addSubview(label)
			repostsLabel = label
		}
		if viewsLabel == nil {
			let label = UILabel(frame: .zero)
			label.font = bottomLabelsFont
			label.textColor = bottomLabelsColor
			label.textAlignment = .right
			bottomView?.addSubview(label)
			viewsLabel = label
		}
	}

	private func updateViewsIcon(views: String) {
		guard let bottomView = bottomView, let viewsLabel = viewsLabel, let viewsImageView = viewsImageView else { return }

		viewsLabel.text = views
		viewsLabel.sizeToFit()
		viewsLabel.frame = CGRect(x: bottomView.bounds.size.width - 18 - viewsLabel.bounds.size.width, y: 14,
								  width: viewsLabel.bounds.size.width, height: 18)
		var frame = viewsImageView.frame
		frame.origin.x = viewsLabel.frame.origin.x - frame.size.width - 2
		viewsImageView.frame = frame
		viewsImageView.isHidden = false
	}

	func updateModel(postModel: Post) {
		if var textLabelFrame = postTextLabel?.frame {
			textLabelFrame.size.height = postModel.textHeight
			postTextLabel?.frame = textLabelFrame
			postTextLabel?.attributedText = postModel.text
		}
		photosView?.frame = CGRect(x: 0, y: contentView.bounds.height - 46 - postModel.totalPhotosHeight + 15,
								   width: contentView.bounds.width, height: postModel.totalPhotosHeight - 15)
		photosView?.setImageViews(postModel.photos)
		avatarImageView?.kf.setImage(with: URL(string: postModel.imageURLString))
		postAuthorLabel?.text = postModel.author
		dateLabel?.text = postModel.date
		likesLabel?.text = postModel.likes
		commentsLabel?.text = postModel.comments
		repostsLabel?.text = postModel.reposts
		bottomView?.frame = CGRect(x: 0, y: contentView.bounds.height - 46,
								   width: contentView.bounds.width, height: 46)
		updateViewsIcon(views: postModel.views)
	}
}
