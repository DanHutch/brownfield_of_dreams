## **GitHub Oauth for a Rails API**

by Norm Schultz and Dan Hutchinson

*While working on our Brownfield of Dreams Turing project, we noticed that the documentation on setting up and testing Oauth Github access ranged from sorely lacking to contradictory and outdated. So we decided to write this step-by-step guide both for our own clarity and to, possibly, help others.*

**SETUP**

<u>A) Register your app.</u>

1. Login to Github
2. Go to your settings
3. Click on "Developer Settings"
4. Click on "New Oauth App"
5. Fill in all the info. Hint: Be careful choosing your authorization callback url.   

After completing these GitHub will redirect you to a page with your client ID and secret. We recommend saving these and keeping that page open while you continue your setup.

<u>B) Create or edit omniauth.rb</u>

1. Open config/initializers/omniauth.rb

2. Add your new client ID and secret. 

   Ex: `provider :github, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_SECRET'], scope: "user,repo"`

   Note: "scope" limits the key's access. Look at GitHub's page "Understanding scopes for OAuth Apps" for more details.

C) Write a feature test

1. 