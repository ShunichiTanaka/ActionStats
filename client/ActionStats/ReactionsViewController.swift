//
//  ReactionsViewController.swift
//  ActionStats
//
//  Created by admin on 2018/09/10.
//  Copyright © 2018年 tnk-shunichi. All rights reserved.
//

import UIKit

class ReactionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var mainUITableView: UITableView!

    var selectedOutcomes: Array<[String: Any]> = []

    override func viewDidLoad() {
        super.viewDidLoad()

        mainUITableView.delegate = self
        mainUITableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // Method which returns the data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutcomeCell", for: indexPath) as! ReactionsTableViewCell

        let nameText = selectedOutcomes[indexPath.row]["name"] as! String
        cell.outcomeLabel.text = nameText

        // Color of label
        let r_value = selectedOutcomes[indexPath.row]["r"] as! Int
        let g_value = selectedOutcomes[indexPath.row]["g"] as! Int
        let b_value = selectedOutcomes[indexPath.row]["b"] as! Int
        let r = CGFloat(r_value) / 255.0
        let g = CGFloat(g_value) / 255.0
        let b = CGFloat(b_value) / 255.0
        cell.outcomeLabel.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)

        return cell
    }

    // Method which returns the number of the sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Method which returns the number of the data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedOutcomes.count
    }
}
