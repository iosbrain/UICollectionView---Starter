//
//  ViewController.swift
//  UIViewController - Starter
//
//  Created by Andrew Jaffee on 1/14/17.
//  UPDATED: 1/20/2017
//
/*
 
 Copyright (c) 2017 Andrew L. Jaffee, microIT Infrastructure, LLC, and
 iosbrain.com.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

import UIKit

// Note that this class adopts the UICollectionViewDelegate 
// and UICollectionViewDataSource protocols.
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    // the UICollectionView's data source; each cell represents one element
    // of this array; the relationship between this array and UICollectionViewCell's
    // is one-to-one, like:
    //
    // collectionViewDataSource[i] <-> collectionView.insertItems(at: newCellIndexPaths as [IndexPath])
    //
    // where
    //
    // let newCell1 : NSIndexPath = NSIndexPath(row: 0, section: 0)
    // let newCell2 : NSIndexPath = NSIndexPath(row: 1, section: 0)
    // let newCell3 : NSIndexPath = NSIndexPath(row: 2, section: 0)
    //
    // let newCellIndexPaths = [newCell1, newCell2, newCell3]
    //
    // self.collectionView.insertItems(at: newCellIndexPaths as [IndexPath])
    //
    var collectionViewDataSource: [Int] = []
    
    // MARK: - UIViewController delegate
    
    /**         
     
     1) "...[This UIViewController instance] acts as the delegate of the collection view.
 
     The delegate must adopt the UICollectionViewDelegate protocol. The collection view 
     maintains a weak reference to the delegate object.
 
     The delegate object is responsible for managing selection behavior and interactions 
     with individual items. ...

     2) [This UIViewController instance] provides the data for the collection view.
 
     The data source must adopt the UICollectionViewDataSource protocol. The collection view maintains a weak reference to the data source object.
     
     3) Allows users to "select more than one item in the collection view."
     
    */
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self      // 1)
        collectionView.dataSource = self    // 2)
        
        collectionView.allowsMultipleSelection = true   // 3)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper methods
    
    /**
     Allows you to quickly add three cells to the collection view's
     data source.
    */
    func reloadCollectionViewData() -> Void
    {
        if collectionViewDataSource.count == 0
        {
            collectionViewDataSource.append(0)
            collectionViewDataSource.append(1)
            collectionViewDataSource.append(2)
        }
    }
    
    // MARK: - UIToolbar: user interaction
    
    /**
     When a user taps the "Add" button: 1) we add a value to the end of the
     collection view data source if its NOT empty; or, 2) we add a value of zero 
     to the collection view data source if it's empty. Either way, we "reload" 
     the collection view so it displays as many cells as there are data source
     items.
    */
    @IBAction func addButtonTapped(_ sender: Any)
    {
        var newCellValue: Int
        
        if collectionViewDataSource.count > 0
        {
            newCellValue = collectionViewDataSource.max()! + 1
        }
        else
        {
            newCellValue = 0
        }
        collectionViewDataSource.append(newCellValue)
        collectionView.reloadData()
    }
    
    /**
     When a user taps the "Remove" button, we: 1) remove the data items
     from the data source which correspond to the currently selected
     UICollectionViewCell's; and, 2) we delete the currently selected
     UICollectionViewCell's.
     
     NOTE: LOOK AT THE ALGORITHM FOR REMOVING ITEMS FROM THE COLLECTION
     VIEW'S DATA SOURCE. IT MAY NOT SEEM SUCH A SUBTLY COMPLEX TASK, BUT
     IT IS. I WANT YOU TO THINK ABOUT ALGORITHMS AND DATA STRUCTURES BEFORE
     I EXPLAIN THE LOGIC.
    */
    @IBAction func removeButtonTapped(_ sender: Any)
    {
        print(collectionViewDataSource)
        
        // get a list of the current user-selected cells
        // (hihglighted in yellow); this list is usually unordered
        if let selectedItemPaths = collectionView.indexPathsForSelectedItems
        {
            print(selectedItemPaths)
            
            // we know we only have one section, so get the cell item
            // ID's ("row") of each selected cell
            var indexesToRemove: [Int] = []
            
            for indexPath in selectedItemPaths
            {
                indexesToRemove.append(indexPath.row)
            }
            
            // SORT the cell ID's in ascending order
            print("remove these: \(indexesToRemove)")
            indexesToRemove.sort()
            print("remove these: \(indexesToRemove)")
            
            // REVERSE the order of the array to DESCENDING... WHY?
            let reversedIndexesToRemove = Array(indexesToRemove.reversed())
            
            if selectedItemPaths.count > 0
            {
                //
                // STEP 1: remove selected items from data source
                //
                for index in reversedIndexesToRemove
                {
                    let dataIndexToRemove = collectionViewDataSource[index]
                    print(dataIndexToRemove)
                    
                    if collectionViewDataSource.contains(dataIndexToRemove)
                    {
                        if let removeIndex = collectionViewDataSource.index(of: dataIndexToRemove)
                        {
                            collectionViewDataSource.remove(at: removeIndex)
                            print("remove: \(dataIndexToRemove)")
                        }
                    }
                } // end for index in reversedIndexesToRemove
                
                print(collectionViewDataSource)
                
                //
                // STEP 2: remove cells from collection view
                //
                self.collectionView.deleteItems(at: selectedItemPaths)
                
            } // end if selectedItemPaths.count > 0
            
        } // end if let selectedItemPaths = collectionView.indexPathsForSelectedItems
        
    } // end func removeButtonTapped
    
    /**
     Called when the "(Re)Load" button is tapped. This helper method
     allows you to quickly add three cells to the collection view's
     data source, and then update the collection view to reflect the 
     new items in the data source.
    */
    @IBAction func reloadButtonTapped(_ sender: Any)
    {
        if self.collectionViewDataSource.count == 0
        {
            self.reloadCollectionViewData()
            self.collectionView.reloadData()
        }
    }

    // MARK: - UICollectionView members
    
    /**
     We only have one section is our UICollectionView, but you
     can have many.
    */
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    // MARK: - UICollectionViewDataSource
    
    /**
     "Asks your data source object [collectionViewDataSource] for the number of items in the 
     specified section [we only have 1 section; it's 0]."
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return collectionViewDataSource.count;
    }
    
    /**
     This method is crucial to the proper rendering of a UICollectionViewCell based on its
     corresponding data source item. Here you specify:
     
     - what text your cell will display;
     - what image your cell will display;
     - any other type of special gizmos you want to put in your cell;
     - the background that will be displayed when the user selects your cell
        (i.e., the way you want to convey the fact that your cell is selected)...
     
     REMEMBER that this call ties your data source to your UICollectionViewCell's.
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let collectionViewCell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItemID", for: indexPath) as! CollectionViewCell
        
        let backgroundView: UIView = UIView(frame: collectionViewCell.frame)
        backgroundView.backgroundColor = UIColor.yellow
        collectionViewCell.selectedBackgroundView = backgroundView
        
        collectionViewCell.label.text = String(collectionViewDataSource[indexPath.row])
        
        return collectionViewCell
    }
    
    // MARK: - UICollectionViewDelegate

    /**
     Allows you to control whether a cell is added to the list of selected
     cells. So, if a user selected a cell, you can tell the collection view
     to "remember" that this cell was tapped/selected by the user (or not).
     */
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /**
     Allows you to control whether a cell is removed from the list of selected
     cells. So, if a user selected a cell, you can tell the collection view
     to "forget" that this cell was tapped/selected by the user (or not).
    */
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /**
     Allow the cell to be visually highlighted when selected/tapped (or not).
    */
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    /**
     Useful for confirming which cell was just selected/tapped.
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("Selected cell named: \(collectionViewDataSource[indexPath.row])")
    }

} // end class ViewController

