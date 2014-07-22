//
//  JBIViewController.h
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/14/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBISourcePicker.h"

@interface JBIViewController : UIViewController <JBISourcePickerDelegate, UITextFieldDelegate> {
    JBISourcePicker *picker;
    UIPopoverController *pickerPopOver;
    UIPopoverController *pOC;
    CGRect popRect;
}


@end
