//
//  ApiViewController.m
//  SecureOn-SSO-iOS
//
//  Created by 성찬우 on 2020/04/06.
//  Copyright © 2020 성찬우. All rights reserved.
//

#import "ApiViewController.h"
#import "ApiTestViewController.h"

@interface ApiViewController ()

@end

@implementation ApiViewController

static CommonUtil *commonUtil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *array = [[NSArray alloc] initWithObjects:@"putValue()", @"getValue()", @"getAllValues()", @"userPwdInit()", @"userModifyPwd()", @"userSearch()", @"userView()", @"getUserRoleList()", @"getResourcePermission()", @"getResourceList()", nil];
    _ssoApiListData = array;
}

+ (void) setCommonUtil:(CommonUtil *)iCommonUtil {
    commonUtil = iCommonUtil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ssoApiListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableCellIdentitfier = @"ApiTableCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellIdentitfier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentitfier];
    }
    
    cell.textLabel.text = [self.ssoApiListData objectAtIndex:indexPath.row];

    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ApiTestSegue"]) {
        ApiTestViewController *apiTestViewController = segue.destinationViewController;
        UITableViewCell *selectedSsoApiTableCell = (UITableViewCell *)sender;
        [apiTestViewController setApiTestModeValue:selectedSsoApiTableCell.textLabel.text];
    }
}

@end
