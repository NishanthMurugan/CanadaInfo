//
//  ViewController.swift
//  Canada Special
//
//  Created by Nishanth Murugan on 19/09/18.
//  Copyright © 2018 WIPRO. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    var detailItems:[RowsModel?] = []
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeApiCall()
    }
    
    func setupUI() {
        //Setup tableview
        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor(red: 230/255, green: 230/250, blue: 230/250, alpha: 1.0)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.registerTableViewCells()
        self.view.addSubview(self.tableView)
        
        // Add constraints to tableview
        setConstraintsToTableView()
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshAPIData(_:)), for: .valueChanged)
    }
    
    @objc private func refreshAPIData(_ sender: Any) {
        makeApiCall()
    }
    
    func setConstraintsToTableView() {
        // Auto layouts
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        let window = UIApplication.shared.delegate?.window
        
        // Handle bottom safe area for iPhone X
        var bottomPadding : CGFloat = 0
        if #available(iOS 11.0, *) {
            bottomPadding = (window??.safeAreaInsets.bottom)!
        }
        
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -bottomPadding).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func makeApiCall() {
        let completionHandler: (Result<InfoModel>) -> Void = {result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    if let appTitle = result.value?.title {
                        self.title = appTitle
                    }
                    if let rawData = result.value?.rows {
                        self.detailItems = self.removeInvalidContent(rawContent: rawData as! [RowsModel])
                        self.tableView.reloadData()
                    }
                case .failure:
                    // Handle Negative Scenerio
                    self.showAlert(message: (result.error?.localizedDescription)!)
                }
                // Stop pull-to-refresh spinner
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
        }
        
        // Check internet availability and make API call
        if APIManager.isConnectedToInternet() {
            APIManager.makeApiCall(completionHandler: completionHandler)
        } else {
            self.showAlert(message: "Please Check your Internet Connection")
        }
    }
    
    func removeInvalidContent(rawContent: [RowsModel]) -> [RowsModel] {
        return rawContent.filter{$0.title != nil || $0.description != nil || $0.imageHref != nil  }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error !", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func registerTableViewCells() {
        tableView.register(InformationCell.self, forCellReuseIdentifier: "CellIdentifier")
    }
    
    
    // MARK: - Tableview Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: InformationCell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier",
                                                                  for: indexPath) as! InformationCell
        let detials:RowsModel = detailItems[indexPath.row]!
        cell.loadThumbnail(url: detials.imageHref ?? "")
        cell.titleLabel.text = detials.title
        cell.descriptionLabel.text = detials.description
        cell.selectionStyle = .none
        return cell
    }
    
    // Handle Memory warnings
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Clear Cache of thumbnails on memory warnings
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
    }
    
}
