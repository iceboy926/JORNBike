//
//  CORegisterEndViewController.m
//  CoMoBicycle
//
//  Created by 金玉衡 on 16/10/25.
//  Copyright © 2016年 AutoMo. All rights reserved.
//

#import "CORegisterEndViewController.h"
#import "CORegisterNextViewController.h"

#import "CORegisterEndView.h"
#import "CORegisterViewModel.h"

#import "COMediator+COBikeMainComponet.h"

#import "AppDelegate.h"
#import "COBaseNavigationController.h"


@interface CORegisterEndViewController() <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerControllerSourceType  sourceType;
}

@property (nonatomic, strong) CORegisterEndView *endView;

@property (nonatomic, strong) CORegisterViewModel *registerViewModel;


@end

@implementation CORegisterEndViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.endView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addUIConstraints];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self addVMKVOHandle];
}

#pragma mark ui layout

- (void)addUIConstraints
{
    [self.endView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.equalTo(self.view);
        
    }];
}

#pragma mark KVO Controller

- (void)addVMKVOHandle
{
    
    [self.KVOController observe:self.registerViewModel keyPath:@"netStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change) {
       
        if([self.registerViewModel.netStatus boolValue])
        {
            [self showInfoStatus:self.registerViewModel.invalidMsg];
        }
        
    }];
    
    [self.KVOController observe:self.registerViewModel keyPath:@"registerStatus" options:NSKeyValueObservingOptionNew block:^(id observer, id object, NSDictionary *change){
    
        if([self.registerViewModel.registerStatus boolValue])
        {
            [self gotoNextViewController];
        }
        else
        {
            [self showInfoStatus:self.registerViewModel.invalidMsg];
        }
    
    }];
}


#pragma mark ui lazy load

-(CORegisterEndView *)endView
{
    if(_endView == nil)
    {
        WEAK_SELF(weakself)
        _endView = [[CORegisterEndView alloc] init];
        
        _endView.headImageBtnClickedBlock = ^{
            
            [weakself chooseHeadImage];
        };
        
        _endView.finishedBtnClickedBlock = ^{
            
            weakself.registerViewModel.nickname = weakself.endView.nickNameTextFiled.text;
            [weakself.registerViewModel finishRegister];
        };
        
    }
    
    return _endView;
}

- (CORegisterViewModel *)registerViewModel
{
    if(_registerViewModel == nil)
    {
        _registerViewModel = [CORegisterViewModel shareInstance];
    }
    
    return _registerViewModel;
}

#pragma mark custom function

- (void)loadImageSourceController:(UIImagePickerControllerSourceType) type
{
    __block UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = type;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.navigationBar.barTintColor =[UIColor whiteColor];
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self presentViewController:picker animated:YES completion:^{
        picker = nil;
    }];
}

- (void)chooseHeadImage
{
    if(ISIOS8)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
            [self loadImageSourceController:UIImagePickerControllerSourceTypeCamera];
            
        }];
        
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            
            [self loadImageSourceController:UIImagePickerControllerSourceTypePhotoLibrary];
            
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alertController addAction:cameraAction];
        [alertController addAction:photoAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
}


#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = nil;
        if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            UIImage* original = [info objectForKey:UIImagePickerControllerOriginalImage];
            //获取图片裁剪的图
            UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
            //获取图片裁剪后，剩下的图
            UIImage* crop = [info objectForKey:UIImagePickerControllerCropRect];
            
            image = edit;
        }
        else
        {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        
        UIImage *smallImage = [UIImage imageWithImage:image ScaleSize:CGSizeMake(100, 100)];
        
        WEAK_SELF(weakself)
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            weakself.registerViewModel.headImageData = UIImagePNGRepresentation(smallImage);
            [weakself.endView setHeadImage:smallImage];
        }];
    }
    

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark main page

- (void)gotoNextViewController
{
    UIViewController *mainVC = [[COMediator shareInstance] COBikeComponet_ViewController];
    
    [AppDelegate globalDelegate].rootNavigationController = [[COBaseNavigationController alloc] initWithRootViewController:mainVC];
    
    [[AppDelegate globalDelegate] showMainPage];
    
}

@end
