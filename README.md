# XeroLinux ISO Repo

Repo for **XeroLinux** ISO. Feel free to go through files and learn how it's all done. To build ISO follow the guide below...


![XeroLinux-Calamares](https://i.imgur.com/9sjGFSN.png)


### Step 1 - Get Repo in to build :

Before we get started we will need to get the ABS repo in, that's where the new build tool is located. To do so need to edit the "pacman.conf" :

```
sudo nano /etc/pacman.conf
```

Now we need to add the repo at the end of the file, so add this,
```
# Valen Repository
[valen_repo]
SigLevel = Never
Server = https://keyaedisa.github.io/$repo/$arch
```
Now install the tool via,
```
sudo pacman -S abs
```
### Step 2 - Clone Build Repo :

Once you got Repos in, time to grab the build environment that you will be building from. Just note that you will need Git installed in order to do that.

**Install Git with :**
```
sudo pacman -S git[/code]
```
**Grab Build Env.**
```
cd ~ && git clone https://github.com/xerolinux/xero_iso.git
```

### Step 3 - Building the Xero ISO :

Now that we have build environment on our system, it's time to build it.

** Build ISO :**
```
cd ~/xero_iso/ && abs Xero
```

**Build Issue :**

Sometimes a "proc" folder stays mounted, in case you interrupt build process or it hangs...

To fix issue, wait a couple of minutes, then unmount it with this command :
```
sudo umount /home/{username}/ followed by tab key...

Replace {username} with yours of course...
```

Press "Tab" key on keyboard to auto-complete, followed by "Enter" key.. If you get "Busy" message wait a bit longer then repeat until it works ;)

I hope this helps.. In case of other issues kindly find me on [**Discord**] (https://discord.gg/Xg6T78ahtK)

Happy building
