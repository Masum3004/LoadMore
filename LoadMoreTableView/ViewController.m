//
//  ViewController.m
//  LoadMoreTableView
//
//  Created by webmyne on 01/03/17.
//  Copyright © 2017 Webmyne. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+DynamicCell.h"
#import "MyTableViewCell.h"

#define DEFAULT_ROWS 15
#define MAX_ROW 30

@interface ViewController () <UITableViewDynamicDelegate>
{
    int numberOfRows;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    numberOfRows = 10;
    _tableView.delegate = (id)self;
    _tableView.dataSource = (id)self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _tableView.refreshDelegate = self;
    _tableView.enabledLoadMore = YES;
    _tableView.enabledRefresh = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return numberOfRows;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyTableViewCell *cell = (MyTableViewCell *)[_tableView dequeueReusableCellWithIdentifier:@"Cell"];

       cell.lbltitle.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80.0f;
}

#pragma mark - methods required

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_tableView scrollViewDidScroll:scrollView];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.tableView checkToReload];
}
-(void)refreshData:(UITableView *)tableView completion:(RefreshCompletion)completion{
    
    //TODO:do some task needs many time to finish. After finish it, call completion block
    
    //Some codes below is an example
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        numberOfRows=DEFAULT_ROWS;
        [_tableView reloadData];
        completion();
    });
}
-(void)loadMoreData:(UITableView *)tableView completion:(RefreshCompletion)completion{
    
    //TODO:do some task needs many time to finish. After finish it, call completion block
    
    //Some codes below is an example
    
   
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             if (numberOfRows < MAX_ROW) {
            numberOfRows+=10;
            [_tableView reloadData];
             }
             else {
                 NSLog(@"End");
             }
            completion();
        });
    
    
}


@end
