//
//  NowViewController.m
//  Eventus_Redux
//
//  Created by Ross Tang Him on 6/10/14.
//  Copyright (c) 2014 Eventus. All rights reserved.
//

#import "NowViewController.h"
#import "Shared.h"

@interface NowViewController ()
@property NSMutableArray *events;
@end

@implementation NowViewController
@synthesize events;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add filter button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:nil];
    
    [self initDayNightSwitch];
    

    events = [NSMutableArray arrayWithObject:@"People"];

}

-(void) updateNavBar {

}

-(void) initDayNightSwitch {
//    UIButton *dnSwitch = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [dnSwitch setTitle:@"Day" forState:UIControlStateNormal];
//    [dnSwitch setTitle:@"Night" forState:UIControlStateHighlighted];
//    [dnSwitch setBackgroundColor:[UIColor blueColor]];
    
    UISegmentedControl *dnSwitch = [[UISegmentedControl alloc] initWithItems:@[@"Today", @"Tonight"]];
    
    //initialize to time of day
    if ([Shared isDay]) {
        dnSwitch.selectedSegmentIndex = 0;
    } else {
        dnSwitch.selectedSegmentIndex = 1;
    }
    
    self.navigationItem.titleView = dnSwitch;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"EventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }

    cell.textLabel.text = [events objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
