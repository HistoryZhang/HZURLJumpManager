//
//  HZViewController.m
//  HZURLJumpManager
//
//  Created by History on 14-8-10.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZPushViewController.h"
#import "HZURLJumpManager.h"

@interface HZPushViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *tableDataSource;
@end

@implementation HZPushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _tableDataSource = @[@"Push已注册的URL", @"Push未注册的URL",
                         @"Jump-Push已注册的URL", @"Jump-Push未注册的URL"];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: { // @"Push已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=PlistTest&title=Push"];
            [[HZURLJumpManager share] pushToURL:url fromNavigationController:self.navigationController];
        }
            break;
        case 1: { // @"Push未注册的URL"
            [[HZURLJumpManager share] pushToURLString:@"hzjump://go?url=TestNo&title=Push" fromNavigationController:self.navigationController];
        }
            break;
        case 2: { // @"Jump-Push已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=PlistTest&push=yes&key=value&title=Push"];
            [[HZURLJumpManager share] jumpToURL:url fromController:self.navigationController];
        }
            break;
        case 3: { // @"Jump-Push未注册的URL"
            [[HZURLJumpManager share] jumpToURLString:@"hzjump://go?url=TestNo&push=yes&key=value&title=Push" fromController:self.navigationController];
        }
            break;
        default:
            break;
    }
}
@end
