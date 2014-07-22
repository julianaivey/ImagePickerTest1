//
//  JBISourcePicker.h
//  ImagePickerTest
//
//  Created by Juliana Ivey on 7/21/14.
//  Copyright (c) 2014 Juliana Ivey. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JBISourcePickerDelegate <NSObject>

-(void)touchedPicker:(NSString *)string;

@optional
-(void)setInitialPickerValueToRow:(int)i inComponent:(int)j animated:(BOOL)k;

@end

@interface JBISourcePicker : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>{
    UIPickerView *pickerView;
}
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, assign) id<JBISourcePickerDelegate> delegatePicker;

- (id)initWithArray:(NSArray *)contents inFrame:(CGRect)pickerFrame;

@end

