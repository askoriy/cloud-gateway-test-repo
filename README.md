# cloud-gateway-test-repo

https://cloud.google.com/run/docs/authenticating/end-users?authuser=2

1. Create credential for Google Sign-in 
2. add URLs: http://gcp.qipeit.com
   redirect URL: http://gcp.qipeit.com & http://gcp.qipeit.com/index3.html
3. Oauth: User Type - External
          Application type - Public 
          Authorized domains  - qipeit.com
          Application Homepage link - http://gcp.qipeit.com

4. Add YOUR_CLIENT_ID into <meta name="google-signin-client_id" content="YOUR_CLIENT_ID.apps.googleusercontent.com"> (index3.html)


REDEPLOY SERVICE
