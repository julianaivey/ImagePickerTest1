//
//  JBISourcePicker.m
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/21/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import "JBISourcePicker.h"

@interface JBISourcePicker ()

@end

@implementation JBISourcePicker

@synthesize contentArray;
@synthesize delegatePicker;

- (id)initWithArray:(NSArray *)contents inFrame:(CGRect)pickerFrame
{
    self = [super init];
    if (self) {
        contentArray = [NSArray arrayWithArray: contents];
        
        pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
        pickerView.showsSelectionIndicator = YES;
        pickerView.delegate = self;
        
        [self.view addSubview:pickerView];
    }
    return self;
}
-(void)setInitialPickerValueToRow:(int)i inComponent:(int)j animated:(BOOL)k{
    [pickerView selectRow:i inComponent:j animated:k];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [contentArray count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [contentArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self.delegatePicker touchedPicker:[contentArray objectAtIndex:row]];
}

@end