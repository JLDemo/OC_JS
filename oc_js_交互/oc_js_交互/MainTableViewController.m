//
//  MainTableViewController.m
//  oc_js_交互
//
//  Created by kfz on 16/6/1.
//  Copyright © 2016年 kongfz. All rights reserved.
//

#import "MainTableViewController.h"
#import "ViewController.h"
#import "JSContextViewController.h"
#import "SCXTestViewController.h"
#import "WKTestViewController.h"
#import "WKKFZMViewController.h"


@interface MainTableViewController ()

@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:@"UIWebView -- js修改html页面"];
    [self.dataSource addObject:@"UIWebView -- oc js交互"];
    [self.dataSource addObject:@"UIWebView -- 春祥 同学 页面"];

    [self.dataSource addObject:@"WKWebView -- 加载html页面,oc js交互"];
    [self.dataSource addObject:@"WKWebView -- 加载孔网M站"];
//    WKWebView
//    UIWebView
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_+ID'";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = nil;
    if (indexPath.row == 0) { // js修改html页面
        [self performSegueWithIdentifier:@"oc_js" sender:nil];
        return;
    }else if (indexPath.row == 1 ) {  // jscontext
        vc = [[JSContextViewController alloc] init];
    } else if (indexPath.row == 2 ) { // 春祥 同学 页面
        vc = [[SCXTestViewController alloc] init];
    }else if (indexPath.row == 3 ) { // WKWebView -- 加载html页面,oc js交互
        vc = [[WKTestViewController alloc] init];
    }else if (indexPath.row == 4 ) { // WKWebView -- 加载孔网M站
        vc = [[WKKFZMViewController alloc] init];
        self.navigationController.navigationBarHidden = YES;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
