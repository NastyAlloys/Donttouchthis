//
//  NotficationBodyViewCell.swift
//  ShakerNotifications
//
//  Created by Andrew on 10.02.16.
//  Copyright © 2016 Andrey. All rights reserved.
//

import UIKit
import TTTAttributedLabel

enum AvatarSeparator {
    case first, second,third
}

class NotficationBodyViewCell: UITableViewCell {
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpViews()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: define avatar UIViews & ImageViews
    /*
        создание переменных для отображанеия аватаров.
        второй и третий разделители нужны, когда с сервера приходят более одной картинки
    */
    var firstAvatarSeparator: UIView!
    
    var secondAvatarSeparator: UIView!
    var secondAvatarImageView: UIImageView!
    
//    var thirdAvatarSeparator: UIView!
    var thirdAvatarImageView: UIImageView!
    
    var defaultImage: UIImage! = UIImage(named: "avatar.placeholder.png")
    
    var avatarImage: UIImage!
    var avatarImageView: UIImageView!
    
//    var aMap: UILabel!
    var avatarButton: UIButton!
    
    var iconImageView: UIImageView!
    
    var nameLabel: UILabel!
    var descriptionLabel: UILabel!
    
    // MARK: UIViews setup
    func setUpViews() {
        self.clipsToBounds = true
        
        
        
        /*
//        firstAvatarSeparator!.backgroundColor = UIColor.whiteColor()
//        firstAvatarSeparator!.layer.shouldRasterize = true;
//        firstAvatarSeparator!.layer.rasterizationScale = UIScreen.mainScreen().scale
        */
        avatarImage = UIImage(named: "avatar.placeholder.png")
        avatarImageView = UIImageView(image: avatarImage)
        avatarImageView.frame = CGRectMake(0, 0, 35, 35)
        /*
        firstAvatarSeparator = UIView()
        firstAvatarSeparator!.backgroundColor = UIColor.whiteColor()
//        firstAvatarSeparator!.layer.shouldRasterize = true
//        firstAvatarSeparator!.layer.rasterizationScale = UIScreen.mainScreen().scale
        firstAvatarSeparator!.addSubview(avatarImageView)
        
        secondAvatarSeparator = UIView()
        secondAvatarSeparator.backgroundColor = UIColor.whiteColor()
//        secondAvatarSeparator!.layer.shouldRasterize = true
//        secondAvatarSeparator!.layer.rasterizationScale = UIScreen.mainScreen().scale
        secondAvatarSeparator!.addSubview(avatarImageView)
        
        thirdAvatarSeparator = UIView()
        thirdAvatarSeparator.backgroundColor = UIColor.whiteColor()
        thirdAvatarSeparator.addSubview(avatarImageView)
        */
        
        
        
        
        
        
        secondAvatarSeparator = UIView()
        secondAvatarImageView.backgroundColor = UIColor.whiteColor()
        secondAvatarImageView.image = avatarImage
        secondAvatarImageView.layer.shouldRasterize = true
        secondAvatarImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        thirdAvatarImageView.backgroundColor = UIColor.whiteColor()
        thirdAvatarImageView.image = avatarImage
        thirdAvatarImageView.layer.shouldRasterize = true
        thirdAvatarImageView.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        firstAvatarSeparator.backgroundColor = UIColor.whiteColor()
        firstAvatarSeparator.layer.shouldRasterize = true
        firstAvatarSeparator.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        secondAvatarSeparator = UIView()
        secondAvatarSeparator.backgroundColor = UIColor.whiteColor()
        secondAvatarSeparator.layer.shouldRasterize = true
        secondAvatarSeparator.layer.rasterizationScale = UIScreen.mainScreen().scale

        
        print(avatarImage!)

        self.contentView.addSubview(firstAvatarSeparator!)
        self.contentView.addSubview(secondAvatarSeparator!)
//        self.contentView.addSubview(thirdAvatarSeparator!)
        
//        aView = UIView(frame: CGRectMake(0, 0, 200, 50))
//        aMap = UILabel(frame: CGRectMake(0, 0, 200, 50))
//        self.contentView.addSubview(aView)
    }
    /*
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let cornerRadius = CGRectGetHeight(self.avatarButton.bounds) / 2
        
        avatarButton.layer.cornerRadius = cornerRadius
        avatarButton.clipsToBounds = true
        firstAvatarSeparator.layer.cornerRadius = cornerRadius
        firstAvatarSeparator.clipsToBounds = true
//        secondAvatarImageView.layer.cornerRadius = cornerRadius
//        secondAvatarImageView.clipsToBounds = YES;
        secondAvatarSeparator.layer.cornerRadius = cornerRadius
        secondAvatarSeparator.clipsToBounds = true
//        thirdAvatarImageView.layer.cornerRadius = cornerRadius
//        thirdAvatarImageView.clipsToBounds = true
//        descriptionButton.layer.cornerRadius = 2.5
//        descriptionButton.clipsToBounds = true
    }
*/
}
