# Snapshot Manager

The Snapshot Manager is a tool that allows you to manage the retention of backup copies for a specific enterprise application instance based on predefined retention plans.

## Retention Plans

The library supports three different retention plans, each with specific rules:

### Beginner Plan

- **Starter Period:** 42 days
- **Snapshot Management:**
  - Retain each daily snapshot for 42 days.

### Pro Plan

- **Retention Period:** 42 days and 12 months
- **Snapshot Management:**
  - Retain each daily snapshot for 42 days.
  - Retain the last snapshot of each month for 12 months.

### Ultra Plan

- **Retention Period:** 42 days, 12 months, and 7 years
- **Snapshot Management:**
  - Retain each daily snapshot for 42 days.
  - Retain the last snapshot of each month for 12 months.
  - Retain the last snapshot of each year for 7 years.

## Features

### Retention Validation

The Snapshot Manager Retention Validation goal is to determine whether a snapshot created on a specific date should be retained or deleted according to the defined rules in the backup plan.

To use the Snapshot Manager Retention Validation, you can call the `SnapshotManager.should_retain` method with the retention plan and a specific date as inputs. The inputs should be in the format of strings, and date should be on the format "YYYY/MM/DD"

It will determine whether the snapshot for that date should be retained (returns true) or deleted (returns false) according to the rules of the selected backup plan.

Example Usage (let's pretend today is 2023/10/03):

```ruby
today = Date.today

SnapshotManager.should_retain("Beginner", "2023/01/23")
=> false

SnapshotManager.should_retain("Beginner", "2023/10/03")
=> true

SnapshotManager.should_retain("Pro", "2023/01/23")
=> false

SnapshotManager.should_retain("Pro", "2023/01/31")
=> true

SnapshotManager.should_retain("Pro", "2023/10/03")
=> true

SnapshotManager.should_retain("Ultra", "2000/01/23")
=> false

SnapshotManager.should_retain("Ultra", "2015/12/31")
=> false

SnapshotManager.should_retain("Ultra", "2016/12/30")
=> false

SnapshotManager.should_retain("Ultra", "2016/11/30")
=> false

SnapshotManager.should_retain("Ultra", "2023/01/23")
=> false

SnapshotManager.should_retain("Ultra", "2016/12/31")
=> true

SnapshotManager.should_retain("Ultra", "2023/01/31")
=> true

SnapshotManager.should_retain("Ultra", "2023/10/03")
=> true

SnapshotManager.should_retain("InvalidPlan", "2023/10/03")
=> "The plan InvalidPlan is not valid. Valid plans are: [:Pro, :Beginner, :Ultra]"

SnapshotManager.should_retain("Beginner", "invalid date format")
=> invalid date (Date::Error)
```
