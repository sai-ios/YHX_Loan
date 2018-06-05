//
//  PersonTableViewController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/25.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "PersonTableViewController.h"
#import "OliveStartController.h"
#import "ESInfoViewController.h"
#import "JobInfoViewController.h"
#import "SPLoginViewController.h"
@interface PersonTableViewController ()

@property(nonatomic, strong) UserModel *user;
@end

@implementation PersonTableViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([DataManage share].userModel != nil){
         _user = [DataManage share].userModel;
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setbackItem];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setbackItem{
    
    // 设置返回键内容
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}

-(void)finishViewController{
    NSMutableArray *marr = [[NSMutableArray alloc]initWithArray:self.navigationController.viewControllers];
    for (UIViewController *vc in marr) {
        if ([vc isKindOfClass:[PersonTableViewController class]]) {
            [marr removeObject:vc];
            break;
        }
    }
    self.navigationController.viewControllers = marr;
}

#pragma mark tableView 代理方法 选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{//实名认证
            if([DataManage share].userModel.realNameState == false){
            LogDebug(@"实名认证");
            OliveStartController *oliveVc = [[OliveStartController alloc]init];
            [self.navigationController pushViewController:oliveVc animated:YES];
            }else{
                // cancel button
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"实名认证已完成" message:@"您已完成人脸识别及实名认证操作，无需重复操作！" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSLog(@">>> Click the cancel button.");
                }];
                [alertController addAction:cancelAction];
                
                //show alert controller
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
            break;
        case 1:{//基本信息
           LogDebug(@"基本信息");
            ESInfoViewController *esInfoVc = [[ESInfoViewController alloc]init];
            [self.navigationController pushViewController:esInfoVc animated:YES];
            
        }
            break;
        case 2:{//工作信息
            LogDebug(@"工作信息");
            JobInfoViewController *jobInfoVc = [[JobInfoViewController alloc]init];
            [self.navigationController pushViewController:jobInfoVc animated:YES];
        }
            break;
       
        default:
            break;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//显示几条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:  UITableViewCellStyleDefault reuseIdentifier:nil];
     NSInteger row =  indexPath.row;//:表示当前是第几行
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//这个只能设置指定图标
    if(row == 0){
        //实名认证
        [cell.imageView setImage:[UIImage imageNamed:@"icon_tel_name"]];
        cell.textLabel.text = @"实名认证";
        if(_user.realNameState){
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_success.png"]];
        }
    }
    
    if(row == 1){
        [cell.imageView setImage:[UIImage imageNamed:@"icon_information_basic"]];
        cell.textLabel.text = @"基本信息";
        if(_user.basicInfoState){
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_success.png"]];
        }
    }
    
    if(row == 2){
        [cell.imageView setImage:[UIImage imageNamed:@"icon_information_profession"]];
        cell.textLabel.text = @"职业信息";
        if(_user.workState){
            cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_information_success.png"]];
        }
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
