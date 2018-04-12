//
//  ChatCell.swift
//  LetsPass
//
//  Created by Sansus soft on 03/08/17.
//  Copyright © 2017 Sansus soft. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet var collectionView: [UIView]!
    @IBOutlet var viewSend: UIView!
    @IBOutlet var lblSendTime: UILabel!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var imgSend: UIImageView!
    @IBOutlet var imgSenderProfile: UIImageView!
    @IBOutlet var imgSender: UIImageView!
    @IBOutlet var imgMediaSender: UIImageView!
    @IBOutlet var constrainViewSenderWidth: NSLayoutConstraint!
    
    @IBOutlet var viewReceive: UIView!
    @IBOutlet var lblReceiveTime: UILabel!
    @IBOutlet var lblReceiveMessage: UILabel!
    @IBOutlet var imgReceiverProfile: UIImageView!
    @IBOutlet var imgReceiver: UIImageView!
    @IBOutlet var imgMediaReceiver: UIImageView!
    @IBOutlet var constrainViewReceiverWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let senderImage: UIImage? = SWNinePatchImageFactory.createResizableNinePatchImageNamed("ic_sender.9")
        let receiverImage: UIImage? = SWNinePatchImageFactory.createResizableNinePatchImageNamed("ic_receiver.9")
        imgSender.image = senderImage
        imgReceiver.image = receiverImage
        imgSenderProfile.layer.cornerRadius = imgSenderProfile.frame.size.height/2
        imgSenderProfile.clipsToBounds = true
        imgReceiverProfile.layer.cornerRadius = imgReceiverProfile.frame.size.height/2
        imgReceiverProfile.clipsToBounds = true
        imgMediaReceiver.layer.cornerRadius = 6.0
        imgMediaReceiver.clipsToBounds = true
        imgMediaSender.layer.cornerRadius = 6.0
        imgMediaSender.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
