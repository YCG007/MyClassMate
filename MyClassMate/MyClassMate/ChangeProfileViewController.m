//
//  ChangeProfileViewController.m
//  MyClassMate
//
//  Created by 杨春贵 on 16/8/15.
//  Copyright © 2016年 Lan Qiao. All rights reserved.
//

#import "ChangeProfileViewController.h"

@interface ChangeProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextView *profileTextView;

@end

@implementation ChangeProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profileTextView.text = self.classMate.profile;
}

-(void)SaveAndGoBack {
    self.classMate.profile = self.profileTextView.text;
    [[ClassMateData sharedClassMateData] save];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDonePressed:(id)sender {
    [self.view endEditing:YES];
    [self SaveAndGoBack];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self SaveAndGoBack];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
