//
//  JBICollectionViewLayout.h
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/17/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBICollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign) CGPoint   center;
@property (nonatomic, assign) NSInteger cellCount;

-(id)initWithSelectedCellIndexPath:(NSIndexPath *)indexPath;

@end
