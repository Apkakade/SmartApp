
//
//  ViewController.swift
//  SmartAppDemo
//
//  Created by Apple on 13/02/22.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator
import SwiftyJSON
import SVProgressHUD
import Reachability
import Toast_Swift
import SDWebImage

class ViewController: UIViewController , UITextFieldDelegate{
    
    @IBAction func txtSearchBtnAction(_ sender: UIBarButtonItem) {
        self.txtSearch.isHidden = false
        txtSearchheightConstraint.constant = 40.0
    }
    @IBOutlet weak var txtSearchheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var uiClcView_ListVideo: UICollectionView!
    @IBOutlet weak var txtSearch: UITextField!
    var modelPlayingList1 = [PlayingList]()
    var modelPlayingList = [PlayingList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtSearch.delegate = self
        self.txtSearch.isHidden = true
        txtSearchheightConstraint.constant = 00.0
        getApiData()
    }
    
    func getApiData()
    {
        AF.request(Webservices.MainBaseUrl, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil).response { [self] (response) in
               // print(response.result)
            if let data = response.data{
                do {
                    
                    let decoder = JSONDecoder()
                    // if the json type is array time use throwables
                    let model = try decoder.decode(PlayingListModelClass.self, from: data)
                    if model.results.count > 0
                    {

                    print(model.results)
                    self.modelPlayingList1 += model.results
                    self.modelPlayingList += model.results
                    self.uiClcView_ListVideo.reloadData()
                    }
                }
                catch let err {
                    print("into catch :\(err.localizedDescription)")
                    
                    
                }
            }
        }
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC"
        {
            var obj = segue.destination as! DetailViewScreenViewController
            obj.modelPlayingList = modelPlayingList[selectedIndex]
           
        }
    }
    
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         
         modelPlayingList1 = modelPlayingList.filter { ($0.title ?? "").range(of: txtSearch.text ?? "", options: [ .caseInsensitive, .diacriticInsensitive ]) != nil }
         if(self.txtSearch.text?.count == 0)
         {
             modelPlayingList1 = modelPlayingList
         }
         self.uiClcView_ListVideo.reloadData()
         return true
     }
     
     func textFieldDidEndEditing(_ textField: UITextField) {
         modelPlayingList1 = modelPlayingList.filter { ($0.title ?? "").range(of: txtSearch.text ?? "", options: [ .caseInsensitive, .diacriticInsensitive ]) != nil }
         if(self.txtSearch.text?.count == 0)
         {
             modelPlayingList1 = modelPlayingList
         }
         self.uiClcView_ListVideo.reloadData()
     }
    
    }
  
    
    extension ViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelPlayingList1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        
        var data = modelPlayingList1[indexPath.row]
        if data.vote_average! > 7.0
        {
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell1", for: indexPath) as! PlayingVideoListCollectionViewCell
            cell.imgView_main.sd_setImage(with: URL(string : "\(Webservices.ImageBaseUrl)\(data.backdrop_path!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), placeholderImage: UIImage(named:""))
            return cell
        }else{
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier:"cell2", for: indexPath) as! PlayingVideoListCollectionViewCell
            cell.imgView_main.sd_setImage(with: URL(string : "\(Webservices.ImageBaseUrl)\(data.poster_path!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), placeholderImage: UIImage(named:""))
            cell.lbl_title.text = data.title!
            cell.lbl_Overview.text = data.overview!
            return cell
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "DetailVC", sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width)  , height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        modelPlayingList1.remove(at: indexPath.row)
        modelPlayingList.remove(at: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
      }
        
    }
    


