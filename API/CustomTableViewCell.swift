//
//  CustomTableViewCell.swift
//  API
//
//  Created by Ruslan on 27/06/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

   static let ID = "CustomTableViewCell"
    
    var characters: Characters? {
        didSet{
            guard let characters = characters else {return}
            imageCharacter.image = UIImage(named: characters.img)
            characterName.text = characters.localized_name
        }
    }
    
    let imageCharacter: UIImageView = {
        let pic = UIImageView()
        pic.clipsToBounds = true
        pic.layer.cornerRadius = 60
        pic.layer.borderWidth = 4
        pic.layer.borderColor = UIColor.systemGreen.cgColor
        return pic
    }()
    
    let characterName: UILabel = {
        let label = UILabel()
        label.textColor = .link
        label.font = UIFont(name: "Futura", size: 25)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageCharacter)
        contentView.addSubview(characterName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageCharacter.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(contentView).inset(15)
            make.width.height.equalTo(120)
        }
        
        characterName.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.left.equalTo(imageCharacter.snp_rightMargin).inset(-25)
        }
    }
}
