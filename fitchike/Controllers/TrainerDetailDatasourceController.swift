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
        //sets the datasource for this class
        let trainerDetailDatasource = TrainerDetailDatasource()
        self.datasource = trainerDetailDatasource
        setupNavigationItems()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showCertifications()
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            if let profile = self.datasource?.item(indexPath) as? Profile {
                let approximateWidthofBioTextView = view.frame.width - 10 - 60 - 12 - 2
                let size = CGSize(width: approximateWidthofBioTextView, height: 1000)
                let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]
                let estimatedFrame = NSString(string: profile.bio!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
                return CGSize(width: view.frame.width, height: estimatedFrame.height + 240)
            }
            return CGSize(width: view.frame.width, height: 250)
        } else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //removes the default gap between the cells in the standard collection layout.
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            //.zero is a default CGSize to return nothing
            return .zero
        } else {
            return CGSize(width: view.frame.width, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: view.frame.width, height: 50)
        } else {
            return .zero
        }
    }
    
}
