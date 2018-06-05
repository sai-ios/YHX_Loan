//
//  BankManageController.m
//  YHX_Loan
//
//  Created by 张磊 on 2018/4/26.
//  Copyright © 2018年 niusaibing. All rights reserved.
//

#import "BankManageController.h"
#import "AddBankController.h"
#import "BankCardCell.h"
@interface BankManageController ()
// 数据
@property(nonatomic, strong) NSMutableArray *bankCardArray;
@end

@implementation BankManageController


-(NSMutableArray*)bankCardArray{
    if(!_bankCardArray){
        //创建一个可变Array，用来存放cargroup对象
        NSMutableArray *arrayList = [NSMutableArray array];
        //循环遍历出每个字典，再把字典转模型存储
        for (NSDictionary *dict in [DataManage share].userModel.bankCardArray) {
//            LogError(@"---->%@",dict);
            BankCard *bank = [BankCard bankWithDic:dict];
            [arrayList addObject:bank];
        }
        _bankCardArray = arrayList;
    }
    return  _bankCardArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackView];
   // 给导航条上添加一个加 “+” ，并且有一个点击事件
    UIBarButtonItem *addBtnItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addBankClick:)];
     self.navigationItem.rightBarButtonItem = addBtnItem;
    
}

-(void)addBankClick:(id)sender{
    NSLog(@"add bank acitivity");
    if([DataManage share].userModel.realNameState){
        AddBankController *addBankVc = [[AddBankController alloc]init];
        [self.navigationController pushViewController:addBankVc animated:YES];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未实名" message:@"绑定银行卡请先进行实名操作！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) { }];

        [alertController addAction:yesAction];
        //show alert controller
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setBackView{
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"home_icon_back.png"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"home_icon_back.png"]];
    // 设置返回键内容
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem.backBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}

#pragma mark - Table view data source

// 每组显示几条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankCardArray.count;
}

// 组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// 高度
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    return 130.f;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row =  indexPath.row;//:表示当前是第几行
    BankCard *bankcard = self.bankCardArray[row];
    BankCardCell *cell = [BankCardCell bankCellWithTableView:tableView];
    [cell setCellBankInfo:bankcard];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.bankCardArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        [self.bankCardArray insertObject:self.bankCardArray[indexPath.row] atIndex:[self.bankCardArray count]];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    [self.tableView reloadData];
    
}

//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row == [self.bankCardArray count]){
//       return UITableViewCellEditingStyleInsert;
//    }else{
//        return UITableViewCellEditingStyleDelete;
//    }
//}

@end
