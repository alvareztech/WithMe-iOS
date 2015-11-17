//
//  SearchTableViewController.m
//  WithMe
//
//  Created by Daniel Alvarez on 10/11/15.
//  Copyright © 2015 Daniel Alvarez. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController () {
    NSMutableArray *movies;
}

@end


@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *user = [PFUser currentUser];
    NSLog(@"Parse User: %@ %@ %@", user.username, user.password, user[@"phone"]);

//    [PFUser loginWithDigitsInBackground:^(PFUser *user, NSError *error) {
//        if(!error){
//            NSLog(@"User: %@", user);
//        } else {
//            NSLog(@"Error: %@", error);
//        }
//    }];

    
    DGTSession *session = [[Digits sharedInstance] session];
    NSLog(@"Digits Session: %@ %@ %@", session.authToken, session.authTokenSecret, session.phoneNumber);
    
    movies = [[NSMutableArray alloc] init];
    

    self.searchTextField.delegate = self;
    [self.searchTextField becomeFirstResponder];
    
//    [self.searchTextField becomeFirstResponder];
//    [self.searchTextField addTarget:self
//                             action:@selector(textFieldDidChange:)
//                   forControlEvents:UIControlEventEditingChanged];
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [movies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ObjectCell" forIndexPath:indexPath];
    
    Movie *movie = [movies objectAtIndex:indexPath.row];
    
    // Configure the cell...
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *descLabel = (UILabel *)[cell viewWithTag:2];
    UIImageView *bannerImageView = (UIImageView *)[cell viewWithTag:3];
    AddButton *addButton = (AddButton *)[cell viewWithTag:4];
    addButton.index = (int) indexPath.row;
    
    titleLabel.text = movie.title;
    descLabel.text = movie.desc;
    [bannerImageView sd_setImageWithURL:[WS getImageURL:movie.posterPath]
                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [addButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchDown];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"movieViewController"];
    viewController.movie = [movies objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
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


- (void) searchWS: (NSString *) text  {
    NSLog(@"searchWS");
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[WS getSearchURL:text] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@", json);
            
            [self parseJSON:json];
            NSLog(@"end todo");
        } else {
            NSLog(@"Error %@", error);
        }
        
    }];
    
    [dataTask resume];
}

- (void) parseJSON:(NSDictionary *) json {
    NSLog(@"parseJSON");
    
    NSArray *results = [json objectForKey:@"results"];
    
    movies = [[NSMutableArray alloc] init];
    for (int i = 0; i < [results count]; i++) {
        NSDictionary *movie = [results objectAtIndex:i];
        
        Movie *m = [[Movie alloc] init];
        m.ide = [movie objectForKey:@"id"];
        m.title = [movie objectForKey:@"title"];
        m.desc = [movie objectForKey:@"overview"];
        m.posterPath = [movie objectForKey:@"poster_path"];
        NSLog(@"> title: %@", m.title);
        [movies addObject:m];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];

    });
}


//- (void) textFieldDidChange: (id) sender {
//    NSLog(@"> %@", self.searchTextField.text);
//    
//    NSString *text = self.searchTextField.text;
//    
//    if (text.length > 0) {
//        [self searchWS:text];
//    }
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"textFieldShouldReturn");
    
    NSString *text = textField.text;
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    [self searchWS:text];
    
    
    [textField resignFirstResponder];
    
    return YES;
}



- (void) addTask:(AddButton *)sender {
    NSLog(@"addTask %i", sender.index);
    
    Movie *movie = [movies objectAtIndex:sender.index];
    
    PFObject *task = [PFObject objectWithClassName:@"Task"];
    task[@"Owner"] = [PFUser currentUser];
    task[@"ResourceId"] = [NSString stringWithFormat:@"%@", movie.ide];
    task[@"ResourceName"] = movie.title;
    task[@"ResourceImageUrl"] = movie.posterPath;
    [task saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"OK");
        } else {
            NSLog(@"Error %@", error);
        }
    }];
}






















@end
