//
//  JBIPhotoCell.m
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/14/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import "JBIPhotoCell.h"

@interface JBIPhotoCell ()

@property(nonatomic, weak) IBOutlet UIImageView *photoImageView;
@end


@implementation JBIPhotoCell
- (void) setAsset:(ALAsset *)asset
{
    // 2
    _asset = asset;
    self.photoImageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
}

/*@implementation JBIPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
