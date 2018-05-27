import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var myCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        
        // CollectionViewを生成.
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        // Cellに使われるクラスを登録.
        myCollectionView.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "TestCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        self.view.addSubview(myCollectionView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //データの個数を返すメソッド
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 30
    }
    
    //データを返すメソッド
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //コレクションビューから識別子「TestCell」のセルを取得する。
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath as IndexPath)
        
        return cell
    }
    
}

