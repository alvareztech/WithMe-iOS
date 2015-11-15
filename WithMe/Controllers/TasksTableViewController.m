//
//  TasksTableViewController.m
//  WithMe
//
//  Created by Daniel Alvarez on 15/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "TasksTableViewController.h"

@interface TasksTableViewController () {
    NSMutableArray *movies;
}
@end

@implementation TasksTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor primaryColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestLoans)
                  forControlEvents:UIControlEventValueChanged];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    movies = [[NSMutableArray alloc] init];
    
    [self getTasksCurrentUser];
}

- (void) getTasksCurrentUser {
    PFQuery *query = [PFQuery queryWithClassName:@"Task"];
    [query whereKey:@"Owner" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %i scores.", (int) objects.count);
            // Do something with the found objects
            movies = [[NSMutableArray alloc] init];
            for (PFObject *object in objects) {
                Movie *movie = [[Movie alloc] init];
                NSLog(@"%@", object.objectId);
                NSLog(@"name: %@", object[@"ResourceName"]);
                movie.title = object[@"ResourceName"];
                movie.posterPath = object[@"ResourceImageUrl"];
                [movies addObject:movie];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.refreshControl endRefreshing];
            });
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Count %i", (int)[movies count]);
    return [movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
    
    Movie *movie = [movies objectAtIndex:indexPath.row];
    
    // Configure the cell...
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UIImageView *bannerImageView = (UIImageView *)[cell viewWithTag:2];

    
    titleLabel.text = movie.title;
    [bannerImageView sd_setImageWithURL:[WS getImageURL:movie.posterPath]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) getLatestLoans {
    NSLog(@"getLatestLoans");
    
    [self getTasksCurrentUser];
    

}


@end
