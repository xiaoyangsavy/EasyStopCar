//
//  ViewController.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "ViewController.h"
#import "SearchPartMapController.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.view.backgroundColor = [UIColor redColor];
    
    SearchPartMapController *searchPartMapController = [[SearchPartMapController alloc]init];
    [self.navigationController pushViewController:searchPartMapController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
