# Heroku

```
heroku addons:create heroku-postgresql:hobby-dev

git push heroku master

heroku run rake db:migrate

heroku run rails console

g=Group.new(:name => "admin")
g.save

u=User.new({:username => "admin", :password => "admin", :password_confirmation => "admin", :group => g, :admin => true })
u.save
```
