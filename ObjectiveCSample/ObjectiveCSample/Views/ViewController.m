//
//  ViewController.m
//  ObjectiveCSample
//
//  Created by Benoit PASQUIER on 23/05/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

#import "ViewController.h"
#import "ViewModel.h"
#import "SongTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) ViewModel * viewModel;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[ViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setDataSource:self];
    [self getData];
}

- (void)getData {
    __weak ViewController *weakSelf = self;
    [self.viewModel getSongsWithSuccess:^(NSArray<SongDisplay *> * _Nonnull displays) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
        // TODO display error
    }];
}

//MARK: - UITableViewDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfItems;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SongTableViewCell"];
    
    if (!cell) {
        assert(false);
    }
    
    [cell setDisplay:[self.viewModel itemAtIndexPath:indexPath]];
    return cell;
}

@end
