//
//  DetailViewController.swift
//  NewsFeed
//
//  Created by asm on 28/03/19.
//  Copyright © 2019 XYZ. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        self.title = "Detail"
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.newsModel.title
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: NewsViewModel? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

