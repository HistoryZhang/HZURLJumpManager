//
//  HZViewController.m
//  HZURLJumpManager
//
//  Created by History on 14-8-10.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZViewController.h"
#import "HZURLJumpManager.h"

@interface HZViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *tableDataSource;
@end

@implementation HZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _tableDataSource = @[@"Push已注册的URL", @"Push未注册的URL",
                         @"Present已注册的URL", @"Present未注册的URL",
                         @"Jump-Push已注册的URL", @"Jump-Push未注册的URL",
                         @"Jump-Present已注册的URL", @"Jump-Present未注册的URL"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCellInfoIdf = @"kCellInfoIdf";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellInfoIdf];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellInfoIdf];
    }
    cell.textLabel.text = _tableDataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: { // @"Push已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=Test"];
            [[HZURLJumpManager share] pushToURL:url fromNavigationController:self.navigationController];
        }
            break;
        case 1: { // @"Push未注册的URL"
            [[HZURLJumpManager share] pushToURLString:@"hzjump://go?url=TestNo" fromNavigationController:self.navigationController];
        }
            break;
        case 2: { // @"Present已注册的URL"
            [[HZURLJumpManager share] presentToURLString:@"hzjump://go?url=Test" fromViewController:self];
        }
            break;
        case 3: { // @"Present未注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=TestNo"];
            [[HZURLJumpManager share] presentToURL:url fromViewController:self];
        }
            break;
        case 4: { // @"Jump-Push已注册的URL"
            [[HZURLJumpManager share] jumpToURLString:@"hzjump://go?url=Test&push=yes" fromController:self.navigationController];
        }
            break;
        case 5: { // @"Jump-Push未注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=TestNo&push=yes&key=value"];
            [[HZURLJumpManager share] jumpToURL:url fromController:self.navigationController];
        }
            break;
        case 6: { // @"Jump-Present已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=Test&push=no&key=value"];
            [[HZURLJumpManager share] jumpToURL:url fromController:self];
        }
            break;
        case 7: { // @"Jump-Present未注册的URL"
            [[HZURLJumpManager share] jumpToURLString:@"hzjump://go?url=TestNo&push=no&key=value" fromController:self];
        }
            break;
        default:
            break;
    }
}
@end
