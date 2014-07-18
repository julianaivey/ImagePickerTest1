//
//  JBICollectionViewLayout.m
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/17/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import "JBICollectionViewLayout.h"
#define ITEM_WIDTH  128.0f
#define ITEM_HEIGHT 180.0f

static NSUInteger       const RotationCount         = 32;
static NSUInteger       const RotationStride        = 3;
static NSUInteger       const PhotoCellBaseZIndex   = 100;

@interface JBICollectionViewLayout ()

@property(strong,nonatomic) NSArray     *rotations;
@property(strong,nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation JBICollectionViewLayout

#pragma mark - Lifecycle
-(id)initWithSelectedCellIndexPath:(NSIndexPath *)indexPath{
    self = [super init];
    if (self) {
        self.selectedIndexPath = indexPath;
        [self setup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self){
        [self setup];
    }
    return self;
}

-(void)setup{
    NSMutableArray *rotations = [NSMutableArray arrayWithCapacity:RotationCount];
    CGFloat percentage = 0.0f;
    
    for (NSUInteger i = 0; i < RotationCount; i++) {
        // Ensure that each angle is different enough to be seen
        CGFloat newPercentage = 0.0f;
        do {
            newPercentage = ((CGFloat)(arc4random() % 220) - 110) * 0.0001f;
        } while (fabsf(percentage - newPercentage) < 0.006);
        
        percentage = newPercentage;
        
        CGFloat angle = 2 * M_PI * (1.0f + percentage);
        CATransform3D transform = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
        [rotations addObject:[NSValue valueWithCATransform3D:transform]];
    }
    
    self.rotations = rotations;
}

-(void) prepareLayout {
    [super prepareLayout];
    
    CGSize size = self.collectionView.frame.size;
    self.cellCount = [self.collectionView numberOfItemsInSection:(0)];
    self.center = CGPointMake(size.width / 2.0, size.height /2.0);
    
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attributes.size = CGSizeMake(ITEM_WIDTH, ITEM_HEIGHT);
    attributes.center = self.center;
    if (indexPath.item == self.selectedIndexPath.item) {
        attributes.zIndex = 100;
    }else{
        attributes.transform3D = [self transformForPersonViewAtIndex:indexPath];
    }
    
    return attributes;
}


-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = [NSMutableArray array];
    for (NSInteger i = 0; i < self.cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i
                                                     inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}


#pragma mark - Private
-(CATransform3D)transformForPersonViewAtIndex:(NSIndexPath *)indexPath{
    NSInteger offset = (indexPath.section * RotationStride + indexPath.item);
    return [self.rotations[offset % RotationCount] CATransform3DValue];
}

@end
