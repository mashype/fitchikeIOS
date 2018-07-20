//
//  TrainerDetailDatasource.swift
//  fitchike
//
//  Created by Seth Merritt on 7/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


class TrainerDetailDatasource: Datasource {
    
    let elements = ["Certifications", "Addresses", "Reviews"]
    
    let test = ["po1", "poo2"]
    
    //thrse are returning as arrays so that the collection view can have multple sections.
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [ElementCell.self, TestCell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [TrainerDetailHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [TrainerDetailFooter.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0 {
            return elements[indexPath.item]
        } else {
            return test[indexPath.item]
        }
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        
        if section == 0 {
            return elements.count
        } else {
            return test.count
        }
    }
}
