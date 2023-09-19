//
//  CafeListItem.swift
//  CoffeTimeMVC
//
//  Created by AndrRum on 19.09.2023.
//

import Foundation
import UIKit

protocol CafeListItemDelegate: AnyObject {
   
}

class CafeListItem: UITableViewCell {
   
    static let reuseId = "CafeListItem"
    
    private(set) var cafeItem: CafeModel!
    
    weak var delegate: CafeListItemDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setParametersForCafeItem(_ cafeItem: CafeModel) {
        self.cafeItem = cafeItem
    }
}
