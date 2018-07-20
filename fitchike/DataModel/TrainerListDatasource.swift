//
//  TrainerDatasource.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import FirebaseFirestore
import UIKit

var profileArray = [Profile]()


class TrainerListDatasource: Datasource {
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [TrainerListCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [TrainerListHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [TrainerListFooter.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return profileArray[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return profileArray.count
    }
    
    
}
