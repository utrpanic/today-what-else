//
//  SecondViewController.swift
//  DynamicTableViewScrollPerformance
//
//  Created by gurren-l on 2017. 4. 18..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var repeatCount: Int = 20
    var testStrings = [
        "아아아아아",
        "아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아",
        "아아아아아아아아아아",
        "아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아",
        "아아아아아아아아아아아아아아아아아아아아아아아아아아아아아아",
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = StaticListCell.defaultHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // Mark: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testStrings.count * self.repeatCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DynamicListCell") as! DynamicListCell
        cell.configureCell(self.testStrings[indexPath.row % self.testStrings.count], indexPath: indexPath)
        return cell
    }
    
}

class DynamicListCell: UITableViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    @IBOutlet weak var testImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var testImageViewHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.testImageView.layer.borderWidth = 0.5
        self.testImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    }
    
    func configureCell(_ testString: String, indexPath: IndexPath) {
        self.testLabel.text = testString
        self.testImageViewWidth.constant = indexPath.row % 2 == 0 ? 0 : self.testImageViewHeight.constant
        self.setNeedsUpdateConstraints()
    }
    
}
