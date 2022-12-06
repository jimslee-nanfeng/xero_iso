# XeroLinux ISO Repo

<p align="center">
    <img width="300" src="https://i.imgur.com/QWqMIsr.png" alt="logo">
</p>

<h1 align="center">You must be on an *Arch* based Distro to build ISO.</h1>

![XeroLinux](https://i.imgur.com/h8vohe7.jpg)


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
sudo pacman -S git
```
**Grab Build Env.**
```
cd ~ && git clone https://github.com/xerolinux/xero_iso.git
```

### Step 3 - Building the Xero ISO :

Now that we have build environment on our system, it's time to build it.

**Build ISO :**
```
cd ~/xero_iso/ && abs Xero
```

Follow the prompts and you good to go...

I hope this helps.. In case of other issues kindly find me on [**Discord**](https://discord.gg/Xg6T78ahtK)

Happy building
