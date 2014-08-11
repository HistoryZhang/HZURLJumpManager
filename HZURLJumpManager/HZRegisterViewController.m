//
//  HZRegisterViewController.m
//  HZURLJumpManager
//
//  Created by History on 14-8-11.
//  Copyright (c) 2014年 History. All rights reserved.
//

#import "HZRegisterViewController.h"
#import "HZURLJumpManager.h"

@interface HZRegisterViewController ()
@property (nonatomic, strong) NSArray *tableDataSource;
@end

@implementation HZRegisterViewController

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
    
    _tableDataSource = @[@"Push已注册的URL", @"Push未注册的URL",
                         @"Jump-Push已注册的URL", @"Jump-Push未注册的URL",
                         @"Present已注册的URL", @"Present未注册的URL",
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
        case 0: { // @"Push已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=RegisterTest&title=Push"];
            [[HZURLJumpManager share] pushToURL:url fromNavigationController:self.navigationController];
        }
            break;
        case 1: { // @"Push未注册的URL"
            [[HZURLJumpManager share] pushToURLString:@"hzjump://go?url=RegisterTestNo&title=Push" fromNavigationController:self.navigationController];
        }
            break;
        case 2: { // @"Jump-Push已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=RegisterTest&push=yes&key=value&title=Push"];
            [[HZURLJumpManager share] jumpToURL:url fromController:self.navigationController];
        }
            break;
        case 3: { // @"Jump-Push未注册的URL"
            [[HZURLJumpManager share] jumpToURLString:@"hzjump://go?url=RegisterTestNo&push=yes&key=value&title=Push" fromController:self.navigationController];
        }
            break;
        case 4: { // @"Present已注册的URL"
            [[HZURLJumpManager share] presentToURLString:@"hzjump://go?url=RegisterTest&title=Present" fromViewController:self];
        }
            break;
        case 5: { // @"Present未注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=RegisterTestNo&title=Present"];
            [[HZURLJumpManager share] presentToURL:url fromViewController:self];
        }
            break;
        case 6: { // @"Jump-Present已注册的URL"
            NSURL *url = [NSURL URLWithString:@"hzjump://go?url=RegisterTest&push=no&key=value&title=Present"];
            [[HZURLJumpManager share] jumpToURL:url fromController:self];
        }
            break;
        case 7: { // @"Jump-Present未注册的URL"
            [[HZURLJumpManager share] jumpToURLString:@"hzjump://go?url=RegisterTestNo&push=no&key=value&title=Present" fromController:self];
        }
            break;
        default:
            break;
    }
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
