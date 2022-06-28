//
//  CustomTableViewCell.swift
//  API
//
//  Created by Ruslan on 28/06/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    static let id = "CustomTableViewCell"
    
    var articles: Articles? {
        didSet {
            guard let articles = articles else {return}
            newsTitle.text = articles.title
            newsContent.text = articles.content
        }
    }
    
    let newsImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    
    let newsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Futura", size: 14)
        return label
    }()
    
    let newsContent: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(newsImage)
        contentView.addSubview(newsTitle)
        contentView.addSubview(newsContent)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.right.equalTo(contentView).inset(10)
            make.width.equalTo(150)
            make.height.equalTo(130)
        }
        
        newsTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(50)
            make.right.equalTo(newsImage.snp_leftMargin).inset(-30)
            make.left.equalTo(contentView).inset(10)
        }
        
        newsContent.snp.makeConstraints { make in
            make.top.equalTo(newsTitle.snp_bottomMargin).inset(-15)
            make.right.equalTo(newsImage.snp_leftMargin).inset(-35)
            make.left.equalTo(contentView).inset(10)
        }
    }
}
