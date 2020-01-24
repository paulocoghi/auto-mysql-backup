# auto-mysql-backup
Shell script to create MySQL backups. Can be used manually or via cron jobs

## Installation

```
$ wget https://raw.githubusercontent.com/paulocoghi/auto-mysql-backup/master/auto-mysql-backup.sh
$ chmod +x auto-mysql-backup.sh
$ mv auto-mysql-backup.sh /usr/bin/auto-mysql-backup
```

## Instructions

### Local backup

```
$ auto-mysql-backup -d [database_name] -u [user_name] -p [password] -l [/path/to/backup/directory/]
```

### Local database with remote backup

```
$ auto-mysql-backup -d [database_name] -u [user_name] -p [password] -i [/path/to/public/ssh/key] -l [username@hostname:/path/to/backup/directory/]
```
