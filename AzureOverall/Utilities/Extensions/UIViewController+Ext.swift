//
//  UIViewController+Ext.swift
//  AzureOverall
//
//  Created by Jocelyn Boyd on 9/2/20.
//  Copyright © 2020 Jocelyn Boyd. All rights reserved.
//

import Foundation
import SafariServices

extension UIViewController {
	func presentSafairVC(with url: URL) {
		let safariVC = SFSafariViewController(url: url)
		safariVC.preferredBarTintColor = .systemBlue
		present(safariVC, animated: true)
	}
}
