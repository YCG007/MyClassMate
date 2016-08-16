//
//  DetailTableViewController.m
//  MyClassMate
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Lan Qiao. All rights reserved.
//

#import "DetailTableViewController.h"
#import "ChooseImageViewController.h"
#import "ChangeNameViewController.h"
#import "ChangeMobileViewController.h"
#import "ChangeProfileViewController.h"
#import "ClassMateData.h"

@interface DetailTableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblMobile;
@property (weak, nonatomic) IBOutlet UILabel *lblProfile;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnTrash;

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = YES;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self LoadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    [self LoadData];
}


-(void)LoadData{
    //新建状态是隐藏删除按钮
    NSMutableArray* rightBarButtons = [self.navigationItem.rightBarButtonItems mutableCopy];
    
    if (self.classMate) {
        self.imgPhoto.image = self.classMate.photoImage;
        
        if (self.classMate.name && self.classMate.name.length > 0) {
            self.lblName.text = self.classMate.name;
            self.title = self.classMate.name;
        } else {
            self.lblName.text = @"请更新姓名";
        }
        
        if (self.classMate.mobile && self.classMate.mobile.length > 0) {
            self.lblMobile.text = self.classMate.mobile;
        } else {
            self.lblMobile.text = @"请更新手机号码";
        }
        if (self.classMate.profile && self.classMate.profile.length > 0) {
            self.lblProfile.text = self.classMate.profile;
        } else {
            self.lblProfile.text = @"请更新简介";
        }
        
        if (![rightBarButtons containsObject:self.btnTrash]) {
            [rightBarButtons addObject:self.btnTrash];
            [self.navigationItem setRightBarButtonItems: rightBarButtons animated:YES];
        }
        
        
    } else {
        self.title = @"新建同学信息";
        self.imgPhoto.image= [UIImage imageNamed:@"no_Image"];
        self.lblName.text = @"请输入同学姓名";
        self.lblMobile.text  = @"请输入同学手机号码";
        self.lblProfile.text  = @"请输入同学简介";
        
        if ([rightBarButtons containsObject:self.btnTrash]) {
            [rightBarButtons removeObject:self.btnTrash];
            [self.navigationItem setRightBarButtonItems:rightBarButtons animated:YES];
        }
    }
    
}
- (IBAction)btnTrashPressed:(id)sender {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"确定删除此信息吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action){
        [[ClassMateData sharedClassMateData] removeClassMate:self.classMate];
        [[ClassMateData sharedClassMateData] save];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if (self.classMate == nil) {
        self.classMate = [[ClassMateData sharedClassMateData] createClassMate];
    }
    
    
    if ([segue.identifier isEqualToString:@"GoToChooseImage"]) {
        ChooseImageViewController* chooseImageVC = segue.destinationViewController;
        chooseImageVC.classMate = self.classMate;
    } else if ([segue.identifier isEqualToString:@"GoToChangeName"]) {
        ChangeNameViewController* changeNameVC = segue.destinationViewController;
        changeNameVC.classMate = self.classMate;
    } else if ([segue.identifier isEqualToString:@"GoToChangeMobile"]) {
        ChangeMobileViewController* changeMobileVC = segue.destinationViewController;
        changeMobileVC.classMate = self.classMate;
    } else if ([segue.identifier isEqualToString:@"GoToChangeProfile"]) {
        ChangeProfileViewController* changeProfileVC = segue.destinationViewController;
        changeProfileVC.classMate = self.classMate;
    }
}


@end
