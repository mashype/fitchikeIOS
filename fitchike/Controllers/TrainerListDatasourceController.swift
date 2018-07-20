//
//  ProfileDatasourceController.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import FirebaseFirestore


class TrainerListDatasourceController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //if I wanted a custom background for the whole page.
        //collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        let trainerListDatasource = TrainerListDatasource()
        self.datasource = trainerListDatasource
        observeData()
        
    }

    
    func observeData() {
        let profileRef = db.collection("users")
        profileRef.getDocuments { (snapshot, error) in
            if error != nil {
                print(error as Any)
            } else {
                //set the profile array to equal whatever I am querying below
                profileArray = (snapshot?.documents.compactMap({Profile(dictionary: $0.data())}))!
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    func showTrainerDetailController(profile: Profile) {
        let trainerDetailController = TrainerDetailController()
        let navController = UINavigationController(rootViewController: trainerDetailController)
        trainerDetailController.profile = profile
        present(navController, animated: true, completion: nil)
    }
    

    
    //selected the controller based on the table selection
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = profileArray[indexPath.row]
        showTrainerDetailController(profile: profile)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
    
}
