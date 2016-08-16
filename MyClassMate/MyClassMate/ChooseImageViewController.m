//
//  ChooseImageViewController.m
//  MyClassMate
//
//  Created by apple on 16/1/12.
//  Copyright © 2016年 Lan Qiao. All rights reserved.
//

#import "ChooseImageViewController.h"

@interface ChooseImageViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgPhoto;

@property (weak, nonatomic) IBOutlet UISwitch *switchAlloeEditing;

@end

@implementation ChooseImageViewController{
    Boolean _isNewImagePicked;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.classMate.photo) {
        self.imgPhoto.image = self.classMate.photoImage;
    }
    // Do any additional setup after loading the view.
}
- (IBAction)btnPickImageFromLibraryPressed:(id)sender {
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = self.switchAlloeEditing.isOn;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)btnTakeNewPhotoPressed:(id)sender {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = self.switchAlloeEditing.isOn;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        NSLog(@"NO CAMERA");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage* pickedImage;
    if (self.switchAlloeEditing.isOn) {
        pickedImage = info[UIImagePickerControllerOriginalImage];
    } else {
        pickedImage = info[UIImagePickerControllerOriginalImage];
    }

    self.imgPhoto.image = pickedImage;
    _isNewImagePicked = YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnDoneImage:(id)sender {
    if (_isNewImagePicked) {
        NSString* imagePath = self.classMate.photoFilePath;
        NSData* imageData = UIImageJPEGRepresentation(self.imgPhoto.image, 0.9);
        [imageData writeToFile:imagePath atomically:YES];
        NSLog(@"Image saved to: %@",imagePath);
        self.classMate.photo = [self.classMate photoFileName];
        [[ClassMateData sharedClassMateData] save];

    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
