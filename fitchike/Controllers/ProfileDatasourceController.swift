//
//  ProfileDatasourceController.swift
//  fitchike
//
//  Created by Seth Merritt on 7/16/18.
//  Copyright © 2018 leftyseth. All rights reserved.
//

import LBTAComponents
import FirebaseFirestore


class TrainerDatasourceController: DatasourceController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let trainerDatasource = TrainerDatasource()
        self.datasource = trainerDatasource
        observeData()
        
    }
    
    func setupNavigationBarItems() {
        setupRemainingNavItems()
    }
    
    func observeData() {
        
        let profileRef = db.collection("users")
        
        profileRef.getDocuments { (snapshot, error) in
            if error != nil {
                print(error as Any)
            } else {
                //set the profile array to equal whatever I am querying below
                healthCategoryArray = (snapshot?.documents.compactMap({HealthCategory(dictionary: $0.data())}))!
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    //selected the controller based on the table selection
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = healthCategoryArray[indexPath.row]
        
        if category.name == "Medications" {
            let baseController = PharmacyDatasourceController()
            let navController = UINavigationController(rootViewController: baseController)
            present(navController, animated: true, completion: nil)
            
        } else if category.name == "Care Team" {
            let baseController = CareTeamDatasourceController()
            let navController = UINavigationController(rootViewController: baseController)
            present(navController, animated: true, completion: nil)
            
        } else if category.name == "Conditions" {
            let baseController = ConditionDatasourceController()
            let navController = UINavigationController(rootViewController: baseController)
            present(navController, animated: true, completion: nil)
            
        } else {
            let baseController = ConditionDatasourceController()
            let navController = UINavigationController(rootViewController: baseController)
            present(navController, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    private func setupRemainingNavItems() {
        
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "dx_header"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
}
