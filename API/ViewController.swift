//
//  ViewController.swift
//  API
//
//  Created by Ruslan on 27/06/22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let json = JSON()
    var charactersArray = [Characters]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.ID)
        table.rowHeight = 190
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGreen
        title = "Main"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        JSON1 {
            print("STH")
        }
        
    }
    
    func JSON1(arr: @escaping () -> ()) {
        
        let url = "https://api.opendota.com/api/heroStats"
        
        guard let url = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {return}
            DispatchQueue.main.async {
            do {
                let decoder = JSONDecoder()
                let characters = try decoder.decode([Characters].self, from: data)
                for el in characters {
                    self.charactersArray += [el]
                }
                self.tableView.reloadData()
                arr()
            } catch {
                print(error.localizedDescription)
            }
            }
        } .resume()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview().inset(0)
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.ID, for: indexPath) as! CustomTableViewCell
        cell.characters = charactersArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
