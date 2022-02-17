//
//  ViewModel.swift
//  SeSACFriendsApp
//
//  Created by 박근보 on 2022/02/14.
//

import UIKit

protocol ViewModel {
    
}

extension ViewModel {

    func sesacImageChangeIntToUIImage(sesacimage: Int) -> UIImage {
        switch sesacimage {
        case 0: return Asset.Home.SeSACImage.image1.image
        case 1: return Asset.Home.SeSACImage.image2.image
        case 2: return Asset.Home.SeSACImage.image3.image
        case 3: return Asset.Home.SeSACImage.image4.image
        case 4: return Asset.Home.SeSACImage.image5.image
        default: return Asset.Home.SeSACImage.image1.image
        }
    }

    func sesacBackgroundImageIntToUIImage(backgroundImage: Int) -> UIImage {
        switch backgroundImage {
        case 0: return Asset.Home.Background.backgroundImage1.image
        case 1: return Asset.Home.Background.backgroundImage2.image
        case 2: return Asset.Home.Background.backgroundImage3.image
        case 3: return Asset.Home.Background.backgroundImage4.image
        case 4: return Asset.Home.Background.backgroundImage5.image
        case 5: return Asset.Home.Background.backgroundImage6.image
        case 6: return Asset.Home.Background.backgroundImage7.image
        case 7: return Asset.Home.Background.backgroundImage8.image
        case 8: return Asset.Home.Background.backgroundImage9.image
        default: return Asset.Home.Background.backgroundImage1.image
        }
    }

    func removeDuplication(in array: [String]) -> [String] {
        let set = Set(array)
        let duplicationRemovedArray = Array(set)
        return duplicationRemovedArray
    }
}
