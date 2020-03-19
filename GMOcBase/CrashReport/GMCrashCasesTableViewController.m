//
//  GMCrashCasesTableViewController.m
//  GMOcBase
//
//  Created by liu zhuzhai on 2020/3/11.
//

#import "GMCrashCasesTableViewController.h"
#include "cpp_exception_throw.hpp"

@interface GMCrashCasesTableViewController ()
@property (nonatomic) NSArray * cases;
@end

@implementation GMCrashCasesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CrashReport-Cases-reuseIdentifier"];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.cases = @[@"0 NSException", @"1 bad access", @"2 bad access on non-main thread", @"3 exception on othre thread", @"4 signal 5 breakpoint", @"5:deadlock", @"6:cpp exception", @"7:stack overflow"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cases.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CrashReport-Cases-reuseIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CrashReport-Cases-reuseIdentifier"];
    }
    // Configure the cell...
    cell.textLabel.text = self.cases[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSMutableArray * array = [[NSMutableArray alloc] init];
            id as = array[2];
        }
            break;
        case 1:
        {
            NSInteger i = 10;
            NSString * iformat = [NSString stringWithFormat:@"skdjf%@",i];
            NSLog(@"%@",iformat);
        }
            break;
        case 2:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSInteger i = 10;
                NSString * iformat = [NSString stringWithFormat:@"skdjf%@",i];
                NSLog(@"%@",iformat);
            });
        }
            break;
        case 3:
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSLog(@"here we create a exception in other thread");
                NSMutableArray * array = [[NSMutableArray alloc] init];
                id as = array[2];
                
            });
        }
            break;
        case 4:
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    NSLog(@"express signal 5");
                });
            }
                          break;
        case 5:
        {
            
            [self tryDeadLock];
        }
            break;
        case 6:
        {
            throw_a_cpp_exception();
        }
            break;
        case 7:
        {
            [self tryStackOverFlow];
            
        }
            break;
        default:
            break;
    }
    
}

- (void)tryDeadLock{
    [self performSelectorInBackground:@selector(tryDeadLock2) withObject:self];
}

- (void)tryDeadLock2{
    @synchronized (self) {
        NSLog(@"will it reach here");
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self tryDeadLock3];
        });
    }
}


- (void)tryDeadLock3{
    @synchronized (self) {
        NSLog(@"never reach here");
    }
}

- (void)tryStackOverFlow {
    
    int64_t sd[1000];
    sd[0] = [NSDate timeIntervalSinceReferenceDate];
    sd[999] = [NSDate timeIntervalSinceReferenceDate];
    static int64_t once = 0;
    NSLog(@"once:%@",@(once));
    once++;
    [self tryStackOverFlow];
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
