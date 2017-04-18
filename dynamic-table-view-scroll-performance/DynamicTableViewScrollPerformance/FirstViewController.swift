//
//  FirstViewController.swift
//  DynamicTableViewScrollPerformance
//
//  Created by gurren-l on 2017. 4. 18..
//  Copyright © 2017년 boxjeon. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
        self.tableView.rowHeight = StaticListCell.defaultHeight
    }
    
    // Mark: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testStrings.count * self.repeatCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StaticListCell") as! StaticListCell
        cell.configureCell(self.testStrings[indexPath.row % self.testStrings.count])
        return cell
    }
    
}

class StaticListCell: UITableViewCell {
    
    class var defaultHeight: CGFloat { return 48 }
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var testImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.testImageView.layer.borderWidth = 0.5
        self.testImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
    }
    
    func configureCell(_ testString: String) {
        self.testLabel.text = testString
    }
    
}

