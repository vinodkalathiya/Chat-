//
//  MainListViewController.swift
//  FHSwiftDemo
//
//  Created by Sansus soft on 03/08/17.
//  Copyright © 2017 Sansus soft. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController {
    
    //MARK: - IBOUTLET methods
    @IBOutlet var tbl : UITableView!
    
    // MARK: - PRIVATE VARIABLES
    fileprivate var arrSetting :Array = ["Chat Demo"]
    
    //MARK: - OVERRIDE methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationMethod()
        self.setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - nevigation methods
    func setNavigationMethod() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "Main List"
    }
    
    //MARK: - custom methods
    func setUI() {
        tbl.register(UINib.init(nibName: "MainListCell", bundle: nil), forCellReuseIdentifier: "MainListCell")
    }
}

extension MainListViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSetting.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MainListCell = tableView.dequeueReusableCell(withIdentifier: "MainListCell") as! MainListCell;
        cell.lblName.text = arrSetting[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //Chat View
            let chatVC = ChatViewController(nibName: "ChatViewController", bundle: nil)
            self.navigationController?.pushViewController(chatVC, animated: true)
        }
    }
}
