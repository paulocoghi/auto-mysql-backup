# auto-mysql-backup
Shell script to create MySQL backups. Can be used manually or via cron jobs.
Created specially to my friend, Pasquale.

## Installation

```
$ wget https://raw.githubusercontent.com/paulocoghi/auto-mysql-backup/master/auto-mysql-backup.sh
$ chmod +x auto-mysql-backup.sh
$ sudo mv auto-mysql-backup.sh /usr/bin/auto-mysql-backup
```

## Instructions

### Local backup

```
$ auto-mysql-backup -d [database_name] -u [user_name] -p [password] -l [/path/to/backup/directory/]
```

### Local database with remote backup *(via scp/ssh)*

```
$ auto-mysql-backup -d [database_name] -u [user_name] -p [password] -i [/path/to/public/ssh/key] -l [username@hostname:/path/to/backup/directory/]
```

### Using cron jobs

First, define your frequency. You can use https://crontab.guru/ to create one. For example, every 1:00am, run:

```
$ crontab -e
```

And insert:

```
0 1 * * * auto-mysql-backup -d [database_name] -u [user_name] -p [password] -l [/path/to/backup/directory/] > /dev/null 2>&1
```

> *the first column is the **minute**, the second is the **hour**, the third is the **day***, the fourth is the **month** and the fifth is the **day of week** (0-6)

### Removing old backups

You can add another cron job to erase backups that are **X** days old, that can run before the backup *(for example, one hour before)*, with the line:

```
0 0 * * * find /path/to/backup/directory/ -mindepth 1 -type f -mtime +5 -delete
```

> *in this example, the **+5** is specifying that files older than **5 days** must be deleted*

## Thanks to

 - Pasquale
