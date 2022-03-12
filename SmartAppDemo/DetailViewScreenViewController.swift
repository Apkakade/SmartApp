//
//  DetailViewScreenViewController.swift
//  SmartAppDemo
//
//  Created by Apple on 13/02/22.
//

import UIKit

class DetailViewScreenViewController: UIViewController {

    @IBOutlet weak var lbl_overview: UILabel!
    @IBOutlet weak var imageView_opt: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    var modelPlayingList : PlayingList?
    override func viewDidLoad() {
        super.viewDidLoad()

        if (modelPlayingList?.vote_average)! > 7.0
        {
            self.imageView_opt.sd_setImage(with: URL(string : "\(Webservices.ImageBaseUrl)\(modelPlayingList!.backdrop_path!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), placeholderImage: UIImage(named:""))
        }else{
            self.imageView_opt.sd_setImage(with: URL(string : "\(Webservices.ImageBaseUrl)\(modelPlayingList!.poster_path!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), placeholderImage: UIImage(named:""))
        }
        self.lbl_title.text = modelPlayingList!.title!
        self.lbl_overview.text = modelPlayingList!.overview!
        // Do any additional setup after loading the view.
    }
    

    

}
