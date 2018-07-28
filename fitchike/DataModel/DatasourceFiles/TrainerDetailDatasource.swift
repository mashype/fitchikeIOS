//
//  TrainerDetailDatasource.swift
//  fitchike
//
//  Created by Seth Merritt on 7/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents

var selectedProfile = Profile() //globabl variable for the currently selected trainer profile

//NOT USING THIS RIGHT NOW
class TrainerDetailDatasource: Datasource {
    
    let trainerSpecs = ["Certifications", "Addresses", "Reviews"]
    let test = ["po1", "poo2"]

    //these are returning as arrays so that the collection view can have multple sections.
    override func numberOfSections() -> Int {
        return 3
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [TrainerDetailCell.self, TrainerSpecCell.self, Section2Cell.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [TrainerDetailHeader.self]
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [TrainerDetailFooter.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 0 {
            return selectedProfile
        }
        else if indexPath.section == 1 {
            return trainerSpecs[indexPath.item]
        }
        else {
            return test[indexPath.item]
        }
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        else if section == 1 {
            return trainerSpecs.count
        }
        else {
            return test.count
        }
    }
}
