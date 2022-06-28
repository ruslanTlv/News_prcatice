//
//  SpacificNewsViewController.swift
//  API
//
//  Created by Ruslan on 28/06/22.
//

import UIKit

class SpacificNewsViewController: UIViewController {
    
    var image: Data!
    var newsHeader: String!
    var newsInfo: String!
    var newsPublishingDate: String!
    var titleHead: String!

    lazy var newsImage: UIImageView = {
        let photo = UIImageView()
        photo.image = UIImage(data: image)
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        return photo
    }()
    
    lazy var newsTitle: UILabel = {
        let label = UILabel()
        label.text = newsHeader
        label.textColor = UIColor.systemBackground
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var newsContent: UILabel = {
        let label = UILabel()
        label.text = newsInfo
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    lazy var newsDate: UILabel = {
        let label = UILabel()
        label.text = "Published at: \(newsPublishingDate ?? "")"
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var viewForAll: UIView = {
        let view = UIView()
        view.addSubview(newsImage)
        view.addSubview(newsTitle)
        view.addSubview(newsContent)
        view.addSubview(newsDate)
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [viewForAll])
        stack.axis = .vertical
        stack.distribution = .fill
        return stack
    }()
    
    lazy var scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.alwaysBounceVertical = true
        scroll.addSubview(stackView)
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        title = titleHead
        view.addSubview(scroll)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scroll.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.top.bottom.left.right.equalToSuperview().inset(0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(scroll).inset(0)
            make.width.equalTo(scroll)
        }
        
        viewForAll.snp.makeConstraints { make in
            make.height.equalTo(700)
        }
        
        newsImage.snp.makeConstraints { make in
            make.centerX.equalTo(viewForAll)
            make.top.left.right.equalTo(viewForAll).inset(0)
            make.height.equalTo(300)
        }
        
        newsTitle.snp.makeConstraints { make in
            make.centerX.equalTo(viewForAll)
            make.left.right.equalTo(viewForAll).inset(20)
            make.top.equalTo(newsImage.snp_bottomMargin).inset(-50)
        }
        
        newsContent.snp.makeConstraints { make in
            make.centerX.equalTo(viewForAll)
            make.left.right.equalTo(viewForAll).inset(20)
            make.top.equalTo(newsTitle.snp_bottomMargin).inset(-50)
        }
        
        newsDate.snp.makeConstraints { make in
            make.centerX.equalTo(viewForAll)
            make.top.equalTo(newsContent.snp_bottomMargin).inset(-15)
            make.left.right.equalTo(viewForAll).inset(30)
        }
    }

}
