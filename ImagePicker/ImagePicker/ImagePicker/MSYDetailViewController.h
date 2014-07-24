//
//  MSYDetailViewController.h
//  ImagePicker
//
//  Created by Matthew Yundt on 7/24/14.
//  Copyright (c) 2014 Jigsaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSYDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
