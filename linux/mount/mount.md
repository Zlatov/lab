On the 'server' add an entry into your /etc/exports to share the directory e.g.

```
/directory/with/data secondserver.tld(rw)
```

which allows secondserver read/write access to the directory/with/data

then use exportfs to share the directory

```
exportfs -r
```

and you can verify your export with

```
exportfs
/directory/with/data    secondserver.tld
```

You can now mount your directory on secondserver

```
mount server:/directory/with/data /mnt
```

and you can verify the mount

```
mount -t nfs
server:/directory/with/data on /mnt type nfs (rw,addr=192.168.254.196)
```

You may want to add an entry to your ___fstab___ to have it mount on boot too

```
server:/directory/with/data /mnt    nfs rw 0 0
```

You'll probably want to read the various man pages I linked to too.
