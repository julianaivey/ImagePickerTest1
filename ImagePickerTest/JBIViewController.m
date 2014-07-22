//
//  JBIViewController.m
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/14/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import "JBIViewController.h"
#import "JBIPhotoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <QuartzCore/QuartzCore.h>
#import "JBICollectionViewLayout.h"
#import "UIImage+Resize.h"


@interface JBIViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *assets;
@property(nonatomic, strong) NSIndexPath *expandedIndexPath;
@property(nonatomic) NSUInteger numberOfTapsRequired;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation JBIViewController

{
    NSArray *sources;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sources = [NSArray arrayWithObjects: @"Camera Roll", @"source1", nil];
    
   // UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce:)];
    
   // tapOnce.numberOfTapsRequired = 1;
    
	
    _assets = [@[] mutableCopy];
    __block NSMutableArray *tmpAssets = [@[] mutableCopy];
    // Grab static instance of assets library
    ALAssetsLibrary *assetsLibrary = [JBIViewController defaultAssetsLibrary];
    // Enumerate through all of the ALAssets (photos) in the user’s Asset Groups (Folders)
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result)
            {
                // Enumerate each folder and add it’s ALAssets to the temporary array
                [tmpAssets addObject:result];
            }
        }];
        
        // Sort the assets list by date
        //NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
        //self.assets = [tmpAssets sortedArrayUsingDescriptors:@[sort]];
        self.assets = tmpAssets;
        
        // Reload the UICollectionView
        [self.collectionView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error loading images %@", error);
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//access assets library (camera roll)

+(ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

#pragma mark - collection view data source

//sets number of items in collection view to number of photos accessed (assets)

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}


//what to do when image is selected (not complete)

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = self.assets[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    //ALAssetRepresentation *thumbRep = [asset aspectRatioThumbnail];
    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    // Do something with the image
   
    
   
    
}

//configures collection view cell

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   JBIPhotoCell *cell = (JBIPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.row];
    cell.asset = asset;
    cell.backgroundColor = [UIColor redColor];
    
    
    return cell;
}




//line spacing for collection view

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}

//more spacing for collection view
- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark - Actions

//method for button that takes you to camera

- (IBAction)takePhotoButtonTapped:(id)sender
{
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO))
        return; // 1
    
    // 2
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    // 3
    [self presentViewController:mediaUI animated:YES completion:nil];
}


//method for button that takes you to albums

- (IBAction)albumsButtonTapped:(id)sender {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypePhotoLibrary] == NO))
        return;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    [self presentViewController:mediaUI animated:YES completion:nil];
}




//The following method will call zoomToRect in collection view to zoom in to full screen
/*- (void)tapOnce:(UIGestureRecognizer *)gesture {
    [self.[UICollectionView] zoomToRect:rectToZoomInTo animated:NO/YES];
}
 
 

MyLayout *stackedLayout = [[MyLayout alloc] initWithSelectedCellIndexPath:indexPath];
[stackedLayout invalidateLayout];
[self.collectionView setCollectionViewLayout:stackedLayout
                                    animated:YES];
*/

//From here on down: methods dealing with camera roll text field (drop down menu)



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    popRect = CGRectMake(406, 110, 0, 0);
    CGRect pickerRect = CGRectMake(0, 10, 0, 0);
    
    NSArray *contents = [[NSArray alloc] initWithObjects:@"Object 1", @"Object 2", @"Object 3", nil];
    picker = [[JBISourcePicker alloc] initWithArray:contents inFrame:pickerRect];
    picker.delegatePicker = self;
    
    pickerPopOver = [[UIPopoverController alloc] initWithContentViewController:picker];
    pickerPopOver.popoverContentSize = CGSizeMake(320, 250);
    [pickerPopOver presentPopoverFromRect:popRect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:TRUE];
    
    pOC = pickerPopOver;
}

-(void)touchedPicker:(NSString *)string{
    
//    [yourTextField setText:string];
    [pickerPopOver dismissPopoverAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    [pOC dismissPopoverAnimated:NO];
    return YES;
}


@end
