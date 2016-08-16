//
//  ChooseImageViewController.h
//  MyClassMate
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Lan Qiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassMateData.h"

@interface ChooseImageViewController : UIViewController <UINavigationControllerDelegate , UIImagePickerControllerDelegate>

@property (nonatomic)ClassMate *classMate;

@end
