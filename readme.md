# Libreduca

Web gradebook to share notes, grades and comments between members in an educational community

#### Build Status [<img src="https://secure.travis-ci.org/cirope/libreduca.png"/>](http://travis-ci.org/cirope/libreduca)

#### Dependency Status [<img src="https://gemnasium.com/cirope/libreduca.png?travis"/>](https://gemnasium.com/cirope/libreduca)

## Instalation guide
1) Clone the repository to a folder in your system
```
git clone git@github.com:cirope/libreduca.git
```
2) Install Ruby 2.3.1
3) Install bundler gem
4) Install PostgreSQL
```
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib
```
5) Create an user in Postgres with the following info:
Username: libreduca
Password: libreduca

5.1) Open the terminal in the folder where libreduca was cloned
5.2) Open postgres terminal typing
```
sudo -i -u postgres
psql
```
or
```
sudo -u postgres psql
```
5.3) Create the user
```
CREATE USER libreduca WITH PASSWORD 'libreduca';
ALTER ROLE libreduca CREATEROLE CREATEDB;
```
Here you will have to enter the username and password. If you are prompeted to
choose between superuser or no, choose by yourself. Since is development I always
opt for super cow.

6) Setup the project.
Again in the folder where libreduca was cloned, type the following
```
cp config/app_config.example.yml config/app_config.yml
bundle exec rake db:setup
bundle exec rake db:migrate (just in case)
bundle exec rake db:seed
```
7) Run the project!
```
bundle exec unicorn -p 3000
```



## (The MIT License)

Copyright (c) 2012-2014 Cirope S.A.

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
