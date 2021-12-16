# Deploying an rgee app to shinyapps.io

https://cesar-aybar.shinyapps.io/rgee_app_demo/

Based on: [**testshiny**](https://github.com/RMHogervorst/testshiny) by [**RMHogervorst**](https://github.com/RMHogervorst).

This template will help you to deploy shiny apps that required rgee. You must proceed as follows:

1)  Modify the .Renviron file. Go to <https://www.shinyapps.io/admin/#/tokens> to get this information.

```
    SHINY_ACC_NAME="your_account_name"
    TOKEN="a_token_you_got_from_shinyapps.io"
    SECRET="a_secret_you_recieved_fromshinyapps.io"
    MASTERNAME="name_of_the_shiny_app"
```

2)  Change section 3 in app.R with your own shiny app.

![image](https://user-images.githubusercontent.com/16768318/146459136-bcf32237-6f79-4164-9cbf-77af2335c129.png)


3)  Run deploy.R
