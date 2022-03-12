//
//  PlayingVideoListCollectionViewCell.swift
//  SmartAppDemo
//
//  Created by Apple on 13/02/22.
//

import UIKit

class PlayingVideoListCollectionViewCell: UICollectionViewCell , UIGestureRecognizerDelegate{
    
    @IBOutlet weak var uiview_main: UIView!
    @IBOutlet weak var imgView_main: UIImageView!
    @IBOutlet weak var imgView_playButton: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var lbl_Overview: UITextView!
    var deleteLabel1: UILabel!
    var deleteLabel2: UILabel!
    var cellLabel: UILabel!
     var pan: UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
      }

      required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
      }

      private func commonInit() {
        self.contentView.backgroundColor = UIColor.gray
        self.backgroundColor = UIColor.red

        cellLabel = UILabel()
        cellLabel.textColor = UIColor.white
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(cellLabel)
        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true

        deleteLabel1 = UILabel()
        deleteLabel1.text = "delete"
        deleteLabel1.textColor = UIColor.white
        self.insertSubview(deleteLabel1, belowSubview: self.contentView)

        deleteLabel2 = UILabel()
        deleteLabel2.text = "delete"
        deleteLabel2.textColor = UIColor.white
        self.insertSubview(deleteLabel2, belowSubview: self.contentView)

        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        pan.delegate = self
        self.addGestureRecognizer(pan)
      }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        if (pan.state == UIGestureRecognizer.State.changed) {
          let p: CGPoint = pan.translation(in: self)
          let width = self.contentView.frame.width
          let height = self.contentView.frame.height
          self.contentView.frame = CGRect(x: p.x,y: 0, width: width, height: height);
          self.deleteLabel1.frame = CGRect(x: p.x - deleteLabel1.frame.size.width-10, y: 0, width: 100, height: height)
          self.deleteLabel2.frame = CGRect(x: p.x + width + deleteLabel2.frame.size.width, y: 0, width: 100, height: height)
        }

      }

    @objc func onPan(_ pan: UIPanGestureRecognizer) {
        if pan.state == UIGestureRecognizer.State.began {

        } else if pan.state == UIGestureRecognizer.State.changed {
          self.setNeedsLayout()
        } else {
          if abs(pan.velocity(in: self).x) > 500 {
            let collectionView: UICollectionView = self.superview as! UICollectionView
            let indexPath: IndexPath = collectionView.indexPathForItem(at: self.center)!
            collectionView.delegate?.collectionView!(collectionView, performAction: #selector(onPan(_:)), forItemAt: indexPath, withSender: nil)
          } else {
            UIView.animate(withDuration: 0.2, animations: {
              self.setNeedsLayout()
              self.layoutIfNeeded()
            })
          }
        }
      }
    
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
       return true
     }

     override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
       return abs((pan.velocity(in: pan.view)).x) > abs((pan.velocity(in: pan.view)).y)
     }
    
}

