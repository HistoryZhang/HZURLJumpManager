//
//  HZPresentViewController.m
//  HZURLJumpManager
//
//  Created by History on 14-8-11.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZPresentViewController.h"
#import "HZURLJumpManager.h"

@interface HZPresentViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *tableDataSource;
@end

@implementation HZPresentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _tableDataSource = @[@"Present已注册的URL", @"Present未注册的URL",
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0: { // @"Present已注册的URL"
            [[HZURLJumpManager share] presentToURLString:@"hzjump://go?url=PlistTest&title=Present" fromViewController:self];
        }
            break;
        case 1: { // @"Present未注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=TestNo&title=Present"];
            [[HZURLJumpManager share] presentToURL:url fromViewController:self];
        }
            break;
        case 2: { // @"Jump-Present已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=PlistTest&push=no&key=value&title=Present"];
            [[HZURLJumpManager share] jumpToURL:url fromController:self];
        }
            break;
        case 3: { // @"Jump-Present未注册的URL"
            [[HZURLJumpManager share] jumpToURLString:@"hzjump://go?url=TestNo&push=no&key=value&title=Present" fromController:self];
        }
            break;
        default:
            break;
    }
}

@end
