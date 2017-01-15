//
//  ViewController.swift
//  UIViewController - Starter
//
//  Created by Andrew Jaffee on 1/14/17.
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

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{

    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewDataSource: [String] = []
    
    // MARK: - UIViewController delegate
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.allowsMultipleSelection = true
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper methods
    
    func reloadCollectionViewData() -> Void
    {
        collectionViewDataSource.append("one")
        collectionViewDataSource.append("two")
        collectionViewDataSource.append("three")
    }
    
    // MARK: - UIToolbar: user interaction
    
    @IBAction func addButtonTapped(_ sender: Any)
    {
        collectionViewDataSource.append("added")
        collectionView.reloadData()
    }
    
    @IBAction func removeButtonTapped(_ sender: Any)
    {
    }
    
    @IBAction func reloadButtonTapped(_ sender: Any)
    {
        if collectionViewDataSource.count == 0
        {
            reloadCollectionViewData()
            collectionView.reloadData()
        }
    }

    // MARK: - UICollectionView members
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1;
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return collectionViewDataSource.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let collectionViewCell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellItemID", for: indexPath) as! CollectionViewCell
        
        let backgroundView: UIView = UIView(frame: collectionViewCell.frame)
        backgroundView.backgroundColor = UIColor.yellow
        collectionViewCell.selectedBackgroundView = backgroundView
        
        collectionViewCell.label.text = collectionViewDataSource[indexPath.row]
        
        return collectionViewCell
    }
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("Selected cell named: \(collectionViewDataSource[indexPath.row])")
    }

} // end class ViewController

