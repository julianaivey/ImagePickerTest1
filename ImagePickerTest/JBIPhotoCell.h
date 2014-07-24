//
//  JBIPhotoCell.h
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/14/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#include "UIImage+Resize.h"

@interface JBIPhotoCell : UICollectionViewCell
@property(nonatomic, strong) ALAsset *asset;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

