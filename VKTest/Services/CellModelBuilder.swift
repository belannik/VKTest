//
//  CellModelBuilder.swift
//  VKTest
//
//  Created by Anton on 04.08.2020.
//  Copyright © 2020 Anton. All rights reserved.
//

import UIKit
import CoreGraphics

private struct CellHeight
{
	static let headerTop = 10
	static let avatarHeight = 40
	static let textTop = 15
	static let imageTop = 15
	static let bottomBarTop = 10
	static let iconsHeight = 26
	static let bottomBarBottom = 10

	static var minHeight: CGFloat { CGFloat(headerTop + avatarHeight + textTop + bottomBarTop + iconsHeight + bottomBarBottom) }
}

class CellModelBuilder
{
    // MARK: - Property list

	private let textMaxWidth = UIScreen.main.bounds.width - 36
	private let imageMaxHeight = UIScreen.main.bounds.size.height / 2
	private let imageMaxWidth = UIScreen.main.bounds.size.width
	private let builderQueue = DispatchQueue(label: "builderQueue", qos: .userInitiated)

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
        return dateFormatter
    }()

    // MARK: - Internal methods

    func buildFromResponseModel(responseModel: ResponseFeedModel, callBack: @escaping ([Post]) -> () ) {
		builderQueue.async { [weak self] in
			guard let self = self else { return }

			let groups: [ProfileAndGroupsCombine] = responseModel.response.groups
			let profiles: [ProfileAndGroupsCombine] = responseModel.response.profiles
			let items = responseModel.response.items
			var textHeight: CGFloat = 0
			
			var posts = [Post]()
			
			for item in items {
				
				guard let headerInfo = item.sourceId < 0 ? groups.first(where: { $0.id == -item.sourceId}) : profiles.first(where: { $0.id == item.sourceId }) else { continue }
				let date = Date(timeIntervalSince1970: item.date)
				var dateString = self.dateFormatter.string(from: date)
				dateString = dateString.replacingOccurrences(of: ".", with: "")
				let text = self.checkText(textHeight: &textHeight, text: item.text)
				let photos = self.createImageInfoArray(from: item)
				let photosHeight = self.calculatePhotosHeight(images: photos)
				let post = Post(totalHeight: CellHeight.minHeight + textHeight + photosHeight,
								textHeight: textHeight,
								totalPhotosHeight: photosHeight,
								imageURLString: headerInfo.photo50,
								author: headerInfo.displayedName,
								date: dateString,
								likes: item.likes?.count?.formatUsingAbbrevation() ?? "0",
								reposts: item.reposts?.count?.formatUsingAbbrevation() ?? "0",
								comments: item.comments?.count?.formatUsingAbbrevation() ?? "0",
								views: item.views?.count?.formatUsingAbbrevation() ?? "0",
								text: text,
								photos: photos)
				posts.append(post)
			}
			DispatchQueue.main.async {
				callBack(posts)
			}
		}
    }

    // MARK: - Private methods

	private func calculatePhotosHeight(images: [PreviewImage]) -> CGFloat {
		return images.sorted(by: { $0.height > $1.height }).first?.height ?? 0
	}

    private func createImageInfoArray(from item: Item) -> [PreviewImage] {
		guard let attachments = item.attachments else { return [] }
		var images = [PreviewImage]()
		for element in attachments {
			if element.type == ImageType.photo.rawValue {
				guard let image = element.photo?.biggestImage else { continue }
				var previewImage = PreviewImage(height: CGFloat(image.height), width: CGFloat(image.width), path: image.url, type: .photo, duration: nil)
				previewImage.resize(maxWidth: imageMaxWidth, maxHeight: imageMaxHeight)
				images.append(previewImage)
			}
			else if element.type == ImageType.video.rawValue {
				guard let image = element.video?.biggestImage else { continue }
				var previewImage = PreviewImage(height: CGFloat(image.height), width: CGFloat(image.width), path: image.url, type: .video, duration: element.video?.duration)
				previewImage.resize(maxWidth: imageMaxWidth, maxHeight: imageMaxHeight)
				images.append(previewImage)
			}
		}
		return images
    }

	private func checkText(textHeight: inout CGFloat, text: String?) -> NSAttributedString {
		if let text = text, text.count > 0 {
			let attributedString = NSMutableAttributedString(string: text)
			let range = NSMakeRange(0, attributedString.string.count - 1)
			let font = UIFont.systemFont(ofSize: 14)
			attributedString.addAttributes([NSAttributedString.Key.font: font], range: range)
			attributedString.addAttributes([NSAttributedString.Key.kern: -0.15], range: range)
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.lineBreakMode = .byWordWrapping
			attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: range)
			
			let size = attributedString.boundingRect(with: CGSize(width: textMaxWidth, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
			textHeight = size.height
			return attributedString
		} else {
			textHeight = 0
			return NSAttributedString(string: "")
		}
	}
}
