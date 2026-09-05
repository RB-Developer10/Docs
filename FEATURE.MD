# Features

[](#top)

## Table of Contents

- [1. Authentication & Authorization](#1-authentication--authorization)
- [2. User Management](#2-user-management)
- [3. Event Management](#3-event-management)
- [4. Bidder Management](#4-bidder-management)
- [5. Bidding Management](#5-bidding-management)

## 1. Authentication & Authorization

### Register

Allow user to create an account to be able request to bid on specific event. After register, User will be redirected to Login page.

Requirements:

| Field         | Required | Description |
| ------------- | -------- | --- |
| Email         | Yes      | must be valid & unique with OTP verification |
| First Name      | Yes      | must be more than 1 character |
| Last Name      | Yes      | must be more than 1 character |
| Password      | Yes      | must be more than 8 characters combine with _uppercase_, _lowercase_, _number_, and _symbol_.
| Profile Image | Optional | must be within extensions: _jpg_, _png_, and _jpeg_.

---

### Sign In

Allow user to log in into the account after registration completed using `email` and `password`. User will be automatically logout when they close the browser.

> [!NOTE]
> User able to Sign In multiple devices at a time.

---

### Logout

Allow user to logout from the system without closing the browser.

> [!NOTE]
> Logout on a device doesn't logout another.

---

### Forgot Password

Allow user to recover their lost `password` by verifying the `email` address with OTP. User will be redirected to Login page after the process completed.

---

### Reset Password

Allow Authenticated User to reset the `password` by confirming the `old password`.

[Back to top](#top)

---

## 2. User Management

### Edit Profile

Allow user to edit their profile informations: `first name`, `last name`, `profile image`.

---

### Change Email

Allow user to change `email` by confirming OTP code.

[Back to top](#top)

---

## 3. Event Management

### Register as Event Organizer

To register as `Event Organizer`, a person needs to contact `Website Owner`.

`Event Organizer` able to extract Bidding data during the event starts and after the event ends.

> [!IMPORTANT]
> Event will be automatically set to `end` on the `end date` but still visible on the website.

> [!NOTE]
> `Event Organizer` can not create an event. Only `Website Owner` able to perform this action.

Requirements:

| Field         | Required | Description |
| ------------- | -------- | --- |
| Email         | Yes      | must be valid & unique with OTP verification |
| First Name      | Yes      | must be more than 1 character |
| Last Name      | Yes      | must be more than 1 character |
| Password      | Yes      | must be more than 8 characters combine with _uppercase_, _lowercase_, _number_, and _symbol_.
| Profile Image | Optional | must be within extensions: _jpg_, _png_, and _jpeg_. |
| Event Name | Yes |
| Event Date | Yes | _start_ to _end date_ |
| Event Description | Optional |
| Contributors | Optional |
| Arts | Optional |

---

### Modify data

Any data modification during the event lives will be notify to `Bidders`.

[Back to top](#top)

---

## 4. Bidder Management

### Request

`Authenticated User` able to request `Event Organizer` for bidding permission.

---

### Approve

`Event Organizer` able to approve `Authenticated User` to become a `Bidder` on their own event.

---

### Remove

`Event Organizer` able to remove any `Bidder` from their event. After removing, all that `Bidder` records will be remove also.

[Back to top](#top)

---

## 5. Bidding Management

### Place Bids

A `Bidder` able to place bids on multiple items on the events but the amount must be more than minimum requirement.

---

`Bidder` still able to place a bid even the amount is lower than the highest price.

---

### Cancel Bids

A `Bidder` able to cancel bids on any items during the event lives.

---

### Notification

`Bidder` will get notification on the below cases:

- Outbid by other

- Become highest bids

- Become a Winner

[Back to top](#top)

---