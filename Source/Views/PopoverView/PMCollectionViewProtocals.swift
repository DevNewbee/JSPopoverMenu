//
//  PMCollectionView.swift
//  JSPopoverMenu
//
//  Created by 王俊硕 on 2017/11/4.
//  Copyright © 2017年 王俊硕. All rights reserved.
//

import UIKit

extension JSPopoverMenuView: UICollectionViewDelegate {
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 63, height: 30)
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    open func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let limitation = dynamicData.count - 1 - deletedCells.count
        return indexPath.row < limitation ? false : true
    }
    /// 只有待删除的cell和Add才会调用这个事件
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! JSMenuCell
        if isCollectionViewEditing {
            if (cell.label != nil) {
                cell.discharged()
                recoverCell(from: indexPath)
                deletedCells.remove(at: data.count+2-indexPath.row-1)// 总labrls=data.count+2; indexPath.row从0开始
            } else {
                // Add
                textField.show(onView: delegate.baseView) {
                }
            }
        } else {
            delegate.popoverMenu(self, didSelectedAt: indexPath)
            dismiss(completion: nil)
        }
        
       
    }
    
}

extension JSPopoverMenuView: UICollectionViewDataSource {
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dynamicData.count
    }
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! JSMenuCell
        let item = dynamicData[indexPath.row]
        if let item = item as? JSImageTag {
            cell.setupImage(image: item.image)
        } else {
            cell.setup(title: item.title)
        }
        return cell
    }
    
}
extension JSPopoverMenuView: UICollectionViewDelegateFlowLayout {
    
}
