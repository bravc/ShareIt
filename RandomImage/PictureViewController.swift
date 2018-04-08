//
//  PictureViewController.swift
//  RandomImage
//
//  Created by Cameron Braverman on 4/6/18.
//  Copyright © 2018 Cameron Braverman. All rights reserved.
//

import UIKit
import Alamofire

class PictureViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    var images: Array<ViewController.image>!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: collectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flickrImage", for: indexPath) as! FlickrImageCollectionViewCell
        
        let photo = self.images[indexPath.row]
        let url = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        
        Alamofire.request(url).responseData { (response) in
            if let data = response.result.value{
                print(data)
                let image = UIImage(data: data)
                cell.data = data

                cell.flickrImage.image = image
            }
        }
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FlickrImageCollectionViewCell
        
        image = cell.flickrImage.image
        self.performSegue(withIdentifier: "zoomImage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! ImageViewController
        destination.image = self.image
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
