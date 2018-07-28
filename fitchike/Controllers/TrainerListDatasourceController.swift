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
        collectionView?.backgroundColor = UIColor(r: 232, g: 236, b: 241)
        
        //adds observer to listen for the notification when the table header buttons are called.
        NotificationCenter.default.addObserver(self, selector: #selector(TrainerListDatasourceController.showTrainerDetailForTrainer), name:NSNotification.Name(rawValue: "notifyOpenTrainerDetail"), object: nil)
        
        setupNavigationBarItems()
        
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

    //show the trainer detail page
    func showTrainerDetailController(profile: Profile) {
        let trainerDetailController = TrainerDetailDatasourceController()
        let navController = UINavigationController(rootViewController: trainerDetailController)
        selectedProfile = profile
        present(navController, animated: true, completion: nil)
    }
    
    //click from the button to show more complex trainer detail
    @objc func showTrainerDetailForTrainer() {
//        let trainerDetailDatasource = TrainerDetailDatasource()
//        let trainerDetailController = TrainerDetailDatasourceController()
//        let navController = UINavigationController(rootViewController: trainerDetailController)
//        trainerDetailDatasource.profile = trainer
//        present(navController, animated: true, completion: nil)
    }
    
    
    //selected the controller based on the table selection
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = profileArray[indexPath.row]
        showTrainerDetailController(profile: profile)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //get the user record within the size from the datasource to dynamically size. The ITEM is from the array call for the specific cell
        if let profile = self.datasource?.item(indexPath) as? Profile {
            //gets the width of the text view, which is the screen minus the padding and the imageview.
            let approximateWidthofBioTextView = view.frame.width - 10 - 60 - 12 - 2
            //the width calculated above and some arbitrarily large height.
            let size = CGSize(width: approximateWidthofBioTextView, height: 1000)
            //add the attributes from the text in the bio field.
            let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)]
            
            //get an estimate of the height of the cell based on the priofile.bio
            let estimatedFrame = NSString(string: profile.bio!).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
            
            //add the 70 on top of the estimated height based on the calculations above.
            return CGSize(width: view.frame.width, height: estimatedFrame.height + 66)
        }
        
        return CGSize(width: view.frame.width, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //removes the default gap between the cells in the standard collection layout.
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 30)
    }
    
}
