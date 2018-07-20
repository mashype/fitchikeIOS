//
//  TrainerDetailDatasourceController.swift
//  fitchike
//
//  Created by Seth Merritt on 7/18/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents


class TrainerDetailDatasourceController: DatasourceController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainerDetailDatasource = TrainerDetailDatasource()
        //sets the datasource for this class
        self.datasource = trainerDetailDatasource
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 150)
        } else {
            return CGSize(width: 0, height: 0)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.width, height: 75)
        } else {
            return CGSize(width: 0, height: 0)
        }
    }
    
}
