//
//  MainCells.swift
//  iWatchList
//
//  Created by Brian Gomes on 24/10/2020.
//

import UIKit
import Kingfisher

class MainCells: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var imdbLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius = 20.0
           bgView.layer.shadowColor = UIColor.gray.cgColor
           bgView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
           bgView.layer.shadowRadius = 12.0
        bgView.layer.shadowOpacity = 1.0
       posterImage.clipsToBounds = true
        posterImage.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        
//        contentView.
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5))

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data:MainDataModel){
      
        let url = URL(string:"https://image.tmdb.org/t/p/w500"+data.posterPath)
        posterImage.kf.setImage(with:url)
        titleLbl.text = data.title
        releaseLbl.text = data.releaseDate
        imdbLbl.text = "iMDB : "+String(data.voteAverage)
        
    }
    
}

extension UIView
{
  func roundCorners(corners:UIRectCorner, radius: CGFloat)
  {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
