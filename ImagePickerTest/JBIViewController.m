//
//  JBIViewController.m
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/14/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import "JBIViewController.h"
#import "JBIPhotoCell.h"
#import "JBICell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "JBICollectionViewLayout.h"

static CGFloat expandedHeight = 100.0;
static CGFloat contractedHeight = 44.0;

@interface JBIViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic, strong) NSArray *assets;
@property(nonatomic, strong) NSIndexPath *expandedIndexPath;
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic) NSUInteger numberOfTapsRequired;
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

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}


- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = self.assets[indexPath.row];
    ALAssetRepresentation *defaultRep = [asset defaultRepresentation];
    UIImage *image = [UIImage imageWithCGImage:[defaultRep fullScreenImage] scale:[defaultRep scale] orientation:0];
    // Do something with the image
    
}


- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   JBIPhotoCell *cell = (JBIPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    ALAsset *asset = self.assets[indexPath.row];
    cell.asset = asset;
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}


- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 4;
}


- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}

#pragma mark - Actions

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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [sources count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sources count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [sources objectAtIndex:indexPath.row];
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self updateTableView];
}


-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self updateTableView];
}


 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     if ([tableView indexPathsForSelectedRows].count) {
         
         if ([[tableView indexPathsForSelectedRows] indexOfObject:indexPath] != NSNotFound) {
             return expandedHeight; // Expanded height
         }
         
         return contractedHeight; // Normal height
     }
     
     return contractedHeight; // Normal height
}


- (void)updateTableView
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
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


@end
