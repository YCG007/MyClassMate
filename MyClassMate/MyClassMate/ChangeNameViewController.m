//
//  ChangeNameViewController.m
//  MyClassMate
//
//  Created by apple on 16/1/13.
//  Copyright © 2016年 Lan Qiao. All rights reserved.
//

#import "ChangeNameViewController.h"

@interface ChangeNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtName;

@end

@implementation ChangeNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.txtName.text = self.classMate.name;
}

-(void)SaveAndGoBack {
    self.classMate.name = self.txtName.text;
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
