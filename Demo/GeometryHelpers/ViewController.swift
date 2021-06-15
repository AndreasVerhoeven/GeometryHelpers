//
//  ViewController.swift
//  GeometryHelpers
//
//  Created by Andreas Verhoeven on 13/05/2021.
//

import UIKit

class ViewController: UIViewController {
	let titleLabel = UILabel()
	let messageLabel = UILabel()
	let redView = UIView()

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let insets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)

		let availableSize = view.safeSize.insetted(by: view.layoutMargins)
		let titleSize = titleLabel.fittingSizeThatFits(availableSize)

		let leftOverSize = availableSize.subtracting(height: titleSize.height)

		// this is the same as `fittingSizeThatFits()`
		let messageSize = messageLabel.sizeThatFits(leftOverSize).min(leftOverSize)

		// our title label is transformed, so if we would use `frame = `, it would end up at the incorrect position
		// due to the transform.
		titleLabel.safeFrame = titleSize.rectAtZeroOrigin.offsettted(by: insets)
		messageLabel.safeFrame = messageSize.rectAtZeroOrigin.offsettted(y: titleSize.height).offsettted(by: insets)

		redView.safeCenter = view.safeSize.center
		redView.safeSize = titleSize.verticallyStacked(with: messageSize).adding(insets)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		titleLabel.text = "This is a Flipped Title"
		titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
		titleLabel.numberOfLines = 0
		titleLabel.transform = CGAffineTransform(scaleX: 1, y: -1)
		redView.addSubview(titleLabel)

		messageLabel.text = "This is a multi line message\nIt wraps multiple lines.\nThis is the last line."
		messageLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
		messageLabel.numberOfLines = 0
		redView.addSubview(messageLabel)

		redView.backgroundColor = .red
		view.addSubview(redView)
	}
}
