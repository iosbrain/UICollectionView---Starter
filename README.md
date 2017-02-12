# UICollectionView Starter
This is a UICollectionView starter project (Xcode 8.2.1) written in Swift 3.0. Feel free to use it as a template for building out a complete UICollectionView user interface. Build and run this code in the Simulator or on an iPhone and see that you can add, select/highlight, deselect/unhighlight, and remove UICollectionViewCell's. You can select, deselect, add, and remove one cell at a time, or multiple cells at a time. And most importantly, I demonstrate the importance of the relationship between a UICollectionView and its data source, and the importance of keeping a UICollectionView and its data source synchronized.

## Xcode 8.2.1 project settings
**To get this project running on the Simulator or a physical device (iPhone, iPad)**, go to the following locations in Xcode and make the suggested changes:

1. Project Navigator -> [Project Name] -> Targets List -> TARGETS -> [Target Name] -> General -> Signing
- [ ] Tick the "Automatically manage signing" box
- [ ] Select a valid name from the "Team" dropdown
  
2. Project Navigator -> [Project Name] -> Targets List -> TARGETS -> [Target Name] -> General -> Identity
- [ ] Change the "com.yourDomainNameHere" portion of the value in the "Bundle Identifier" text field to your real reverse domain name (i.e., "com.yourRealDomainName.Project-Name").
