//
//  ViewController.swift
//  API
//
//  Created by Ruslan on 27/06/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let json = Json()
    
    var allNewsArray = [Articles]()
    
    let loading: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.id)
        table.rowHeight = 140
        table.backgroundColor = UIColor.systemRed
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barStyle = .black
        title = "News"
        navigationController?.navigationBar.barTintColor = UIColor.systemRed
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .semibold)]
        navigationController?.navigationBar.tintColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        view.addSubview(loading)
        loading.startAnimating()
        
        
        json.decodeJSON { data in
            self.allNewsArray = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.loading.stopAnimating()
            }
        }
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(0)
        }
        
        loading.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allNewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.id, for: indexPath) as! CustomTableViewCell
        cell.articles = allNewsArray[indexPath.row]
        guard let url = URL(string: allNewsArray[indexPath.row].urlToImage) else {return UITableViewCell()}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                
                cell.newsImage.image = UIImage(data: data)
            }
            
        } .resume()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = SpacificNewsViewController()
        
        guard let url = URL(string: allNewsArray[indexPath.row].urlToImage) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                vc.image = data
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        } .resume()
        vc.newsHeader = allNewsArray[indexPath.row].title
        vc.newsInfo = allNewsArray[indexPath.row].content
        let timeSplit = allNewsArray[indexPath.row].publishedAt.split(separator: "T")
        vc.newsPublishingDate = "\(timeSplit[0])"
        let split = allNewsArray[indexPath.row].source.name.split(separator: " ")
        vc.titleHead = "\(split[1]) \(split[2]) \(split[3])"
    }
}
