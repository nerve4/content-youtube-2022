# Cheatsheet: nextcloud-snap-install


Find the snap:
```
$ sudo snap find nextcloud
```

Install the Nextcloud application:
```
$ sudo snap install nextcloud
```

Create the Nextcloud administrator account:
```
$ sudo nextcloud.manual-install USERNAME PASSWORD
```

List Trusted Domain(s):
```
$ sudo nextcloud.occ config:system:get trusted_domains
```

Add your domain to the list of domains Nextcloud:
```
$ sudo nextcloud.occ config:system:set trusted_domains 1 --value=YOURDOMAINNAME
```

Check php memory limit:
```
$ sudo snap get nextcloud php.memory-limit
```

Setup / Update PHP memory limits:
```
$ snap set nextcloud php.memory-limit=512M
```