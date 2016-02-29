//
//  SearchPartMapController.m
//  EasyStopCar
//
//  Created by savvy on 16/2/29.
//  Copyright © 2016年 Savvy. All rights reserved.
//

#import "SearchPartMapController.h"

@interface SearchPartMapController ()

@property(nonatomic,strong) BMKMapView* mapView;

@end

@implementation SearchPartMapController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = _mapView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

@end
