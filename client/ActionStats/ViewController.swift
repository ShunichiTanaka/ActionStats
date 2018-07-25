import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var myCollectionView : UICollectionView!

    var outcomes: Array<[String: Any]> = []

    override func viewDidLoad() {
        loadOutcomes()

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Generate layout of CollectionView
        let layout = UICollectionViewFlowLayout()

        // Size of cell
        layout.itemSize = CGSize(width: 120, height: 50)

        // Margin of cell
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 32, right: 16)

        // Generate CollectionView
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        // Register the class used for the cells
        myCollectionView.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "OutcomeCell")

        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        while(outcomes.count == 0) {
            sleep(1)
        }
        self.view.addSubview(myCollectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Method whitch returns the number of the data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return outcomes.count
    }

    // Method whitch returns the data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        // Get the cell, the identifier of which is "OutcomeCell", from collectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OutcomeCell", for: indexPath as IndexPath)

        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }

        let label = UILabel()
        let title = outcomes[indexPath.row]["name"] as! String
        label.text = title
        label.sizeToFit()
        label.center = cell.contentView.center
        cell.contentView.addSubview(label)

        // Color of cell
        let r_value = outcomes[indexPath.row]["r"] as! Int
        let g_value = outcomes[indexPath.row]["g"] as! Int
        let b_value = outcomes[indexPath.row]["b"] as! Int
        let r = CGFloat(r_value) / 255.0;
        let g = CGFloat(g_value) / 255.0;
        let b = CGFloat(b_value) / 255.0;
        cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)

        return cell
    }

    func loadOutcomes() {
        guard let url = URL(string: "\(Settings.serverUrl)/api/outcomes") else {
            return
        }

        var request = URLRequest(url: url)
        let session = URLSession.shared
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let params:[String:Any] = [
            // TODO: Fix to get data from UserDefaults
            "identifier": "abc123"
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            let task = session.dataTask(with: request) {
                (data:Data?,response:URLResponse?, error:Error?) in
                guard error == nil else {
                    self.outcomes = [["name": "error"]]
                    return
                }
                guard let data = data else {
                    self.outcomes = [["name": "error"]]
                    return
                }
                do {
                    let items = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
                    self.outcomes = items["data"] as! Array<[String: Any]>
                } catch let error {
                    self.outcomes = [["name": "error"]]
                    print(error)
                }
            }
            task.resume()
        } catch {
            return
        }
    }
}
