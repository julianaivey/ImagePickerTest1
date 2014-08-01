//
//  JBICheckMark.h
//  ImagePickerTest
//
//  Created by Juliana Ivey on 8/1/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM( NSUInteger, JBICheckMarkStyle )
{
    JBICheckMarkStyleOpenCircle,
    JBICheckMarkStyleGrayedOut
};

@interface JBICheckMark : UIView

@property (readwrite) bool checked;
@property (readwrite) JBICheckMarkStyle checkMarkStyle;

@end
