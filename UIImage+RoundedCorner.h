//
//  UIImage+RoundedCorner.h
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/18/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RoundedCorner)
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;
@end
