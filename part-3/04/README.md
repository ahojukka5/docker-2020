# Exercise 3.4

Image sizes:

```text
  Container     Repository     Tag       Image Id       Size  
--------------------------------------------------------------
04_backend_1    04_backend    latest   50e8b46fed1e   605.9 MB
04_frontend_1   04_frontend   latest   ce87f1608a3b   1.027 GB
```

On backend:

```text
16:42 $ docker exec -it 04_backend_1 /bin/bash
node@ffce6b367b13:~$ pwd
/app
node@ffce6b367b13:~$ ls -la
total 116
drwxr-xr-x 1 node node  4096 Jan  5 11:15 .
drwxr-xr-x 1 root root  4096 Jan  5 11:15 ..
drwx------ 3 node node  4096 Jan  5 11:15 .config
drwxr-xr-x 1 node node  4096 Jan  5 11:07 .git
-rw-r--r-- 1 node node   982 Jan  5 11:07 .gitignore
-rw-r--r-- 1 node node  1368 Jan  5 11:07 README.md
-rw-r--r-- 1 node node   518 Jan  5 11:07 config.js
-rw-r--r-- 1 node node    46 Jan  5 11:07 index.js
-rw-r--r-- 1 node node     1 Jan  5 11:07 logs.txt
drwxr-xr-x 1 node node  4096 Jan  5 11:07 node_modules
-rw-r--r-- 1 node node 64147 Jan  5 11:07 package-lock.json
-rw-r--r-- 1 node node   706 Jan  5 11:07 package.json
-rw-r--r-- 1 node node    80 Jan  5 11:07 prettier.config.js
drwxr-xr-x 1 node node  4096 Jan  5 11:07 server
node@ffce6b367b13:~$ ps x
    PID TTY      STAT   TIME COMMAND
      1 ?        Ssl    0:00 npm
     16 ?        S      0:00 sh -c node index.js
     17 ?        Sl     0:00 node index.js
     24 pts/0    Ss     0:00 /bin/bash
     32 pts/0    R+     0:00 ps x
```

On frontend:

```text
16:43 $ docker exec -it 04_frontend_1 /bin/bash
node@b046f7e99fe0:~$ pwd
/app
node@b046f7e99fe0:~$ ls -la
total 580
drwxr-xr-x 1 node node   4096 Jan  5 11:10 .
drwxr-xr-x 1 root root   4096 Jan  5 11:15 ..
drwxr-xr-x 1 node node   4096 Jan  5 11:08 .git
-rw-r--r-- 1 node node    978 Jan  5 11:08 .gitignore
-rw-r--r-- 1 node node   1329 Jan  5 11:08 README.md
-rw-r--r-- 1 node node    139 Jan  5 11:08 config.js
drwxr-xr-x 1 node node   4096 Jan  5 11:10 dist
drwxr-xr-x 1 node node  20480 Jan  5 11:10 node_modules
-rw-r--r-- 1 node node 526113 Jan  5 11:08 package-lock.json
-rw-r--r-- 1 node node   1695 Jan  5 11:08 package.json
drwxr-xr-x 1 node node   4096 Jan  5 11:08 src
drwxr-xr-x 1 node node   4096 Jan  5 11:08 util
-rw-r--r-- 1 node node   1728 Jan  5 11:08 webpack.config.js
node@b046f7e99fe0:~$ ps x
    PID TTY      STAT   TIME COMMAND
      1 ?        Ssl    0:00 node /usr/local/bin/serve -n -s -l 5000 dist
     17 pts/0    Ss     0:00 /bin/bash
     24 pts/0    R+     0:00 ps x
```
