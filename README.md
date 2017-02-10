# README

# Unconflicted

Given a colletion of Posts that have and belong to many Categories:
Create a page that displays each category and the first 4 Posts in that category
*without* any duplicates.  Only show Posts with a published_at date >= `now`

This is a simplified version of a real problem we've solved
![](http://atmedia.imgix.net/e205142a5c2298026f587ac316661f9c97748538?auto=compress&w=800.0&fit=max)

We don't expect your version to be this pretty, just plain hypertext is fine

## Priors

This is a pretty basic Rails 5.0 / Ruby 2.4 Application.

### Database & Data
We expect you to be using Postgres. Setting up the sample data should be pretty
straight forward:
* Edit the config/database.yml file with usernames and passwords if you need
* `rake db:create:all`
* `rake db:migrate`
* `rake db:seed`
... and you should be all set

### Models

Only the minimum model code is included.
Feel free to add as you see fit

### Test Framework

There is none.  This is intentional.  Feel free to install and use whatever you like

## Other Instruction

Basically, treat this like you're writing a production piece of code.

![](https://media1.giphy.com/media/10FtVFXLwNBb2M/200w.gif#95)

Have Fun!
