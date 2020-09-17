//
//  RightTableViewCell.swift
//  SwiftProject
//
//  Created by daixingchuang on 2020/6/9.
//  Copyright © 2020 Dxc_iOS. All rights reserved.
//

import UIKit

class RightTableViewCell: UITableViewCell {
       var titleLabel = UILabel()
       var priceLabel = UILabel()
       var pictureView = UIImageView()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configUI(){
        
        titleLabel.frame = CGRect(x: 80, y: 10, width: 200, height: 30)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(titleLabel)
        
       
        priceLabel.frame = CGRect(x: 80, y: 42, width: 200, height: 30)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = RGB(232, 91, 77)
        contentView.addSubview(priceLabel)
        
        pictureView.frame = CGRect(x: 15, y: 15, width: 50, height: 50)
        contentView.addSubview(pictureView)
    }
    var model: RightTableModel? {
        didSet {
            guard let model = model else { return }
            self.titleLabel.text = model.name
            self.priceLabel.text = "￥\(model.price)"
            self.pictureView.image = UIImage(named: model.picture)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
