library(reticulate)
library(rsconnect)
library(rgee)

# 1. Create the credentials file
ee_Initialize()

# 2. Copy credentials file to the project folder
file_credentials <- sprintf("%s/credentials", dirname(rgee::ee_get_earthengine_path()))
file.copy(file_credentials, to = ".")

# 3. Set ShinyApps account info
# FIRST MODIFY LOCAL .Renviron!!
error_on_missing_name <- function(name){
  var <- Sys.getenv(name, unset=NA)
  if(is.na(var)){
    stop(paste0("cannot find ",name),call. = FALSE)
  }
  gsub("\"", '',var)
}

setAccountInfo(name   = error_on_missing_name("SHINY_ACC_NAME"),
               token  = error_on_missing_name("TOKEN"),
               secret = error_on_missing_name("SECRET"))


# 4. Run the application
deployApp(
  appFiles = c("app.R", "utils.R", "credentials"),
  appTitle = "rgee_app_demo",
  lint = FALSE
)

# 5. Delete EE credentials file
file.remove("credentials")
