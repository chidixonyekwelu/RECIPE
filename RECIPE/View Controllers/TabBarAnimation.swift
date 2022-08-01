//
//  TabBarAnimation.swift
//  RECIPE
//
//  Created by Chidi Onyekwelu on 7/31/22.
//

import UIKit

@objcMembers
class TabBarFormat : NSObject {
    
    func ChangeRadiusOfTabBarItem(_ tabBar: UITabBar)  {
        tabBar.layer.masksToBounds = true;
        tabBar.isTranslucent = true;
        tabBar.layer.cornerRadius = 50
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
    }
    
    func ChangeUnselectedColor(_ tabBar: UITabBar){
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    func ChangeHeightOfTabbar(_ tabBar: UITabBar){
        
        if UIDevice().userInterfaceIdiom == .phone {
            var tabFrame            = tabBar.frame
            tabFrame.size.height    = 300
            tabFrame.origin.y       = tabBar.frame.size.height - 100
            tabBar.frame            = tabFrame
        }
    }
    func SimpleAnnimationWhenSelectItem(_ item: UITabBarItem){
        guard let barItemView = item.value(forKey: "view") as? UIView else { return }
        
        let timeInterval: TimeInterval = 1.0
        let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.6) {
            barItemView.transform = CGAffineTransform.identity.scaledBy(x: 4.9, y: 4.9)
        }
        propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
        propertyAnimator.startAnimation()
    }
}
