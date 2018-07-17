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


class TrainerDatasource: Datasource {
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ProfileCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [ProfileHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [ProfileFooter.self]
    }
    
    
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return profileArray[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return profileArray.count
    }
    
    
}
