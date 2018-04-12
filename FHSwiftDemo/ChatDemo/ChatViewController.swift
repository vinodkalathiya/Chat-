//
//  ChatViewController.swift
//  LetsPass
//
//  Created by Sansus soft on 03/08/17.
//  Copyright © 2017 Sansus soft. All rights reserved.
//

import UIKit
let MSG_PLACEHOLDER_TEXT = "Enter Your Message"

class ChatViewController: UIViewController {
    
    //MARK: - IBOUTLET methods
    @IBOutlet var tblMessage: UITableView!
    @IBOutlet var txtMessage: UITextView!
    @IBOutlet var viewFooter: UIView!
    @IBOutlet var constraintViewFooterHeight: NSLayoutConstraint!
    @IBOutlet var constraintViewFooterBottom: NSLayoutConstraint!
    
    //MARK: - Variables
    var oldTextHeight: CGFloat = 0.0
    var txtMaxHeight: CGFloat = 0.0
    var footerOriginalHeight: CGFloat = 0.0
    var singleTap: UITapGestureRecognizer?
    var arrMessages = [Any]()
    var userName : String!
    var strfromId : String!
    var strtoId : String!
    var isLoad : Bool = false
    var isShouldScrollToLastRow: Bool = false
    
    //MARK: - OVERRIDE methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationMethod()
        self.setUI()
        self.setDefaultMessages()
        self.setDoneButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - nevigation methods
    func setNavigationMethod() {
        self.title = "Hardika"
        
        let btnback = UIButton(type: .custom)
        btnback.setImage(UIImage(named: "ic_back"), for: .normal)
        btnback.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnback.showsTouchWhenHighlighted = true
        btnback.addTarget(self, action: #selector(self.btnback_Click), for: .touchUpInside)
        let leftBarButtonItems = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftBarButtonItems.addSubview(btnback)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItems)
        
    }
    
    @IBAction func btnback_Click(_ sender: Any) {
        _ =  navigationController?.popViewController(animated: true)
    }
    
    //MARK: KEYBOARD
    fileprivate func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    internal func keyboardWasShown(_ aNotification: Notification) {
        let info: [AnyHashable: Any] = (aNotification as NSNotification).userInfo!;
        var keyboardRect: CGRect = ((info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue)
        keyboardRect = self.view.convert(keyboardRect, from: nil);
        
        constraintViewFooterBottom.constant = keyboardRect.height
//        DispatchQueue.main.async(execute: {() -> Void in
//            self.tblMessage.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
//            self.tblMessage.reloadData()
//        })
        DispatchQueue.main.async(execute: {() -> Void in
            if self.arrMessages.count > 1{
                let indexPath = IndexPath(item: self.arrMessages.count - 1, section: 0)
                self.tblMessage.scrollToRow(at: indexPath, at: .bottom, animated: false)
            }
        })
    }
    
    internal func keyboardWillBeHidden(_ aNotification: Notification) {
        constraintViewFooterBottom.constant = 0
    }
    
    //MARK: - custom methods
    func setUI() {
        arrMessages = [Any]()
        txtMessage.text = MSG_PLACEHOLDER_TEXT
        txtMessage.textColor = UIColor.gray
        oldTextHeight = 0
        txtMaxHeight = txtMessage.frame.height
        footerOriginalHeight = constraintViewFooterHeight.constant
        tblMessage.rowHeight = UITableViewAutomaticDimension
        tblMessage.estimatedRowHeight = 68.0
        txtMessage.autocapitalizationType = .none
        txtMessage.autocorrectionType = .no
        isShouldScrollToLastRow = true
    }
    
    func setDoneButton() {
        let barWidth: CGFloat = UIScreen.main.bounds.width
        let toolbar = UIToolbar(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: barWidth, height: CGFloat(30)))
        toolbar.isTranslucent = false
        toolbar.barTintColor = UIColor.init(colorLiteralRed: 200.0/255.0, green: 203.0/255.0, blue: 211.0/255.0, alpha: 1.0)
        toolbar.tintColor = UIColor.init(colorLiteralRed: 14.0/255.0, green: 116.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        toolbar.alpha = 0.9
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.btnBarDoneAction))
        let barItems = [flexSpace, doneButton]
        toolbar.setItems(barItems, animated: true)
        txtMessage.inputAccessoryView = toolbar
    }
    
    func btnBarDoneAction() {
        txtMessage.resignFirstResponder()
    }
    
    func setModel(toid: String, fromid: String, is_Sender: String, message: String, status: Int, type: String) {
        let mInfo = MessageInfo()
        mInfo.to_ID = toid
        mInfo.FROM_ID = fromid
        mInfo.IS_SENDER = is_Sender
        mInfo.MESSAGE = message
        mInfo.MSG_TIME = getCurrentDate("hh:mm a")
        mInfo.MSG_STATUS = status
        mInfo.MSG_TYPE = type  //Text, Image
        arrMessages.append(mInfo)
    }
    
    func setDefaultMessages() {
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "Hello", status: 1, type: "Text")
        self .setModel(toid: "2", fromid: "1", is_Sender: "0", message: "How are you?", status: 1, type: "Text")
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "Fine", status: 2, type: "Text")
        self .setModel(toid: "2", fromid: "1", is_Sender: "0", message: "hsfk ghashg aghal;gh hgal;shg", status: 1, type: "Text")
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg", status: 2, type: "Text")
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg", status: 2, type: "Text")
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg", status: 1, type: "Text")
        self .setModel(toid: "1", fromid: "2", is_Sender: "0", message: "hsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shg", status: 2, type: "Text")
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "Hello", status: 1, type: "Image")
        self .setModel(toid: "1", fromid: "2", is_Sender: "0", message: "Hello", status: 1, type: "Image")
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg", status: 2, type: "Text")
        self .setModel(toid: "1", fromid: "2", is_Sender: "1", message: "hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shghsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg hsfk ghashg aghal;gh hgal;shg", status: 1, type: "Text")
        self.tblMessage.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
        DispatchQueue.main.async(execute: {() -> Void in
            self.tblMessage.reloadData()
        })
    }
    
    func getCurrentDate(_ dateFormate: String) -> String {
        let currDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormate
        let currentDate: String = dateFormatter.string(from: currDate)
        return currentDate
    }
    
    //MARK: - IBAction methods
    @IBAction func btnSend_click(_ sender: UIButton) {
        
        if txtMessage.text != "" && txtMessage.text != MSG_PLACEHOLDER_TEXT {
            DispatchQueue.main.async(execute: {() -> Void in
                self.constraintViewFooterHeight.constant = self.footerOriginalHeight
            })
            self.setModel(toid: "1", fromid: "2", is_Sender: "1", message: txtMessage.text, status: 0, type: "Text")
            txtMessage.text = ""
            self.tblMessage.setContentOffset(CGPoint(x: 0, y: CGFloat.greatestFiniteMagnitude), animated: false)
            self.tblMessage.reloadData()
        }
    }
}

extension ChatViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == txtMessage {
            if (txtMessage.text == MSG_PLACEHOLDER_TEXT) {
                txtMessage.text = ""
                txtMessage.textColor = UIColor.black
            }
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let resultingString: String = (textView.text as NSString).replacingCharacters(in: range, with: text)
        var textHeight: CGFloat = getTextHeight(resultingString, textWidth: textView.frame.width, textFont: textView.font!) + 15
        textHeight = ceil(textHeight)
        if oldTextHeight != textHeight && textHeight < 190 {
            if textHeight > txtMaxHeight {
                constraintViewFooterHeight.constant = textHeight + 15
            }
        }
        oldTextHeight = textHeight
        return true
    }
    
    func getTextHeight(_ text: String, textWidth: CGFloat, textFont: UIFont) -> CGFloat {
        let textRect: CGRect = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: textFont], context: nil)
        let textSize: CGSize = textRect.size
        return textSize.height
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ChatCell? = (tableView.dequeueReusableCell(withIdentifier: "ChatCell") as? ChatCell)
        if cell == nil {
            let nib: [Any] = Bundle.main.loadNibNamed("ChatCell", owner: self, options: nil)!
            cell = (nib[0] as? ChatCell)
        }
        let mInfo: MessageInfo? = (arrMessages[indexPath.row] as? MessageInfo)
        if CInt((mInfo?.IS_SENDER)!) == 1 {
            //Sender
            cell?.imgSenderProfile?.isHidden = false
            cell?.imgReceiverProfile?.isHidden = true
            cell?.viewSend?.isHidden = false
            cell?.viewReceive?.isHidden = true
            cell?.lblMessage?.text = mInfo?.MESSAGE
            cell?.lblSendTime?.text = mInfo?.MSG_TIME
            if mInfo?.MSG_STATUS == 2 {
                cell?.imgSend?.image = UIImage(named: "icon_not_send")
            }
            else if mInfo?.MSG_STATUS == 0 {
                cell?.imgSend?.image = UIImage(named: "ic_send")
            }
            else if mInfo?.MSG_STATUS == 1 {
                cell?.imgSend?.image = UIImage(named: "ic_read")
            }
            
            cell?.imgMediaSender?.isHidden = (mInfo?.MSG_TYPE == "Text") ? true : false
            cell?.lblMessage?.isHidden = (mInfo?.MSG_TYPE == "Text") ? false : true
            if (mInfo?.MSG_TYPE == "Image") {
                cell?.constrainViewSenderWidth?.isActive = true
            }
            else {
                cell?.constrainViewSenderWidth?.isActive = false
            }
        }
        else {
            //Receiver
            cell?.viewSend?.isHidden = true
            cell?.viewReceive?.isHidden = false
            cell?.imgSenderProfile?.isHidden = true
            cell?.imgReceiverProfile?.isHidden = false
            cell?.lblReceiveMessage?.text = mInfo?.MESSAGE
            cell?.lblReceiveTime?.text = mInfo?.MSG_TIME
            cell?.imgMediaReceiver?.isHidden = (mInfo?.MSG_TYPE == "Text") ? true : false
            cell?.lblReceiveMessage?.isHidden = (mInfo?.MSG_TYPE == "Text") ? false : true
            if (mInfo?.MSG_TYPE == "Image") {
                cell?.constrainViewReceiverWidth?.isActive = true
            }
            else {
                cell?.constrainViewReceiverWidth?.isActive = false
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let mInfo: MessageInfo? = (arrMessages[indexPath.row] as? MessageInfo)
        if (mInfo?.MSG_TYPE == "Text") {
            return UITableViewAutomaticDimension
        }
        else {
            return 205
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let mInfo: MessageInfo? = (arrMessages[indexPath.row] as? MessageInfo)
        if (mInfo?.MSG_TYPE == "Text") {
            return 68
        }
        else {
            return 205
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
