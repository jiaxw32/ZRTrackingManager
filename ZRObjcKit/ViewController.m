//
//  ViewController.m
//  ZRObjcKit
//
//  Created by jiaxw-mac on 2017/12/10.
//  Copyright © 2017年 jiaxw. All rights reserved.
//

#import "ViewController.h"
#import "ZRFileHelper.h"
#import "ZRFileListViewController.h"
#import "ZRTextViewAutoSizeViewController.h"
#import "ZRTextViewAutoSizeExViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)onButtonClick:(id)sender {
    
    UIStoryboard *fileStoryboard = [UIStoryboard storyboardWithName:@"ZRFileStoryboard" bundle:[NSBundle mainBundle]];
    ZRFileListViewController *fileListViewController = [fileStoryboard instantiateViewControllerWithIdentifier:@"fileListViewController"];
    fileListViewController.filePath = NSHomeDirectory();
    if (fileListViewController) {
        [self.navigationController pushViewController:fileListViewController animated:YES];
    }
}

- (IBAction)onMainBundleButtonClick:(id)sender {
    UIStoryboard *fileStoryboard = [UIStoryboard storyboardWithName:@"ZRFileStoryboard" bundle:[NSBundle mainBundle]];
    ZRFileListViewController *fileListViewController = [fileStoryboard instantiateViewControllerWithIdentifier:@"fileListViewController"];
    fileListViewController.filePath = [NSBundle mainBundle].bundlePath;
    if (fileListViewController) {
        [self.navigationController pushViewController:fileListViewController animated:YES];
    }
}
- (IBAction)onTextViewAutoSizeButtonClickHandler:(id)sender {
//    UIStoryboard *fileStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    ZRTextViewAutoSizeViewController *textViewAutoSizeVC = [fileStoryboard instantiateViewControllerWithIdentifier:@"ZRTextViewAutoSizeScene"];
//    if (textViewAutoSizeVC) {
//        [self.navigationController pushViewController:textViewAutoSizeVC animated:YES];
//    }
    
    ZRTextViewAutoSizeExViewController *vc = [[ZRTextViewAutoSizeExViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
