//
//  ViewController.swift
//  FetchDataAssignment4CollectionView
//
//  Created by Mac on 21/12/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var postCollectionView: UICollectionView!

    
    var post : [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initializeCollectionViewCell()
        registerXIBWithCollectionView()
    }
    func fetchData()
    {
        let postUrl = URL(string: "https://jsonplaceholder.typicode.com/comments")
        
        var postUrlRequest = URLRequest(url: postUrl!)
        
        postUrlRequest.httpMethod = "Get"
        let postUrlSession = URLSession(configuration: .default)
        
        let postDataTask = postUrlSession.dataTask(with: postUrlRequest) { postData, postResponse, postError in
            let postResponse = try! JSONSerialization.jsonObject(with: postData!) as! [[String : Any]]
            
        
            
            for eachResponse in postResponse
            {
                let postDictionary = eachResponse as! [String : Any]
                let postUserId = postDictionary["postId"] as! Int
                let postId = postDictionary["id"] as! Int
                let postName = postDictionary["name"] as! String
                let postEmail = postDictionary["email"] as! String
                let postBody = postDictionary["body"] as! String
                
                let postObject = Post(postId: postUserId, id: postId, name: postName, email: postEmail, body: postBody)
                
                
                
                self.post.append(postObject)
            }
            DispatchQueue.main.async {
                self.postCollectionView.reloadData()
            }
            
        }
        postDataTask.resume()
        
    }
    func initializeCollectionViewCell()
    {
        postCollectionView.dataSource = self
        postCollectionView.delegate = self
        
    }
    func registerXIBWithCollectionView()
    {
        let uinib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        postCollectionView.register(uinib, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }
    

}

extension ViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        post.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCollectionViewCell = self.postCollectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        
        postCollectionViewCell.userIdLabel.text = String(post[indexPath.item].postId)
        postCollectionViewCell.idLabel.text = String(post[indexPath.item].id)
        postCollectionViewCell.nameLabel.text = post[indexPath.item].name
        postCollectionViewCell.emailLabel.text = post[indexPath.item].email
        postCollectionViewCell.bodyLabel.text = post[indexPath.item].body
        
        return postCollectionViewCell
    }
    
    
}
extension ViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenTheCells : CGFloat = (flowLayout.minimumInteritemSpacing ?? 0.0) + (flowLayout.sectionInset.left ?? 0.0) + (flowLayout.sectionInset.right ?? 0.0)
        
        let size = (self.postCollectionView.frame.width - spaceBetweenTheCells) / 2
        
        return CGSize(width: size, height: size)
    }
}
