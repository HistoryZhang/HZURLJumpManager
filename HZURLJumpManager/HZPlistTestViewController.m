//
//  HZTestViewController.m
//  HZURLJumpManager
//
//  Created by History on 14-8-10.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZPlistTestViewController.h"

@interface HZPlistTestViewController ()

@end

@implementation HZPlistTestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *title = self.moduleObject[@"title"];
    if (title.length) {
        self.title = title;
    }
    else {
        self.title = @"未知";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
