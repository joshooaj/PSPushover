# PSPushover

## Overview

The PSPushover PowerShell module makes it a breeze to send notifications to any device using the
[Pushover](https://pushover.net) service. You can send push notifications to Android, iOS, and
desktop devices.

Each notification is associated with an "application", and can be sent to an individual user, or
to a group of users. Get notified...

- when backups fail
- when cron jobs run
- when servers restart
- when your GitHub Actions / Azure DevOps / Jenkins / GitLab pipelines fail
- when your home automation detects a leak
- __whenever and for whatever you want!__

## Try it out

When this GitHub repository receives a new star, it triggers a GitHub Action [workflow](https://github.com/joshooaj/PSPushover/blob/main/.github/workflows/NotifyOnStarred.yml) which uses PSPushover to send a notification to anyone who subscribes using the link below.

[Subscribe to Star Notifications](https://pushover.net/subscribe/PSPushover-2hw5raj6uqr5dsw)

Pushover will generate a random user token for you and add it to a distribution group. You can unsubscribe from your Pushover dashboard at any time, and your real user token is never exposed. So go ahead and try it out! If you already had the repo starred before subscribing to notifications, you can unstar and star it again.

## Getting started

All Pushover notifications are sent from an __application__ to a __user__ or __group__. To send
your first push notification, you need an __application token__ and a __user key__. To receive
notifications, you need the Pushover app installed on a mobile device, or at least have the website
open with notifications enabled in a [compatible browser](https://pushover.net/clients/desktop).

### Create an application

Notifications need to come from _something_, and with Pushover, that something is an "application".
The application can be named anything you like. Naming things is hard though, so if you can't
decide on a name, use "PSPushover".

1. Register and/or login at [pushover.net](https://pushover.net/login).
2. Take note of your __user key__. It looks like `ygzttgcfpab5wyrtstnxlrqllpr0et`.
3. Under __Your Applications__, click __Create an Application/API Token__, fill out the required
   fields, and take note of the api key.

### Install PSPushover

```powershell
Install-Module joshooaj.PSPushover -Scope CurrentUser -Repository PSGallery
```

### Set default tokens

You can choose to enter your app and user tokens each time you call `Send-Pushover`, but you
can also save them securely using `Set-PushoverConfig` and then they'll become the default values
when no alternate tokens are provided.

```powershell
$appToken = Read-Host -Prompt 'Application token' -AsSecureString
$usrToken = Read-Host -Prompt 'User token' -AsSecureString
Set-PushoverConfig -Token $appToken -User $usrToken
```

### Send a message

It's time to send your first push notification!

```powershell
Send-Pushover -Message 'Hello from PSPushover!'
```
