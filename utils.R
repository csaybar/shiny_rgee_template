set_rgee_dependencies <- function() {
  # 1. Create a Python virtual env
  reticulate::virtualenv_create(
    envname = 'rgee_py',
    python = '/usr/bin/python3'
  )

  # 2. Install rgee and rgeeExtra Python dependencies
  reticulate::virtualenv_install(
    envname = "rgee_py",
    packages = c('numpy', "earthengine-api", "jsbeautifier", "regex")
  )


  # 3. Set a Python Env to use with R
  reticulate::use_virtualenv('rgee_py', required = TRUE)
  system(
    sprintf(
      "echo $'EARTHENGINE_INIT_MESSAGE=\"TRUE\"\nEARTHENGINE_PYTHON=%s' > $HOME/.Renviron",
      path.expand("~/.virtualenvs/rgee_py/bin/python")
    )
  )

  # 4. Copy credentials file to the project folder
  oauth_func_path <- system.file("python/ee_utils.py", package = "rgee")
  utils_py <- rgee:::ee_source_python(oauth_func_path)
  ee_path <- sprintf("%s/ndef", ee_utils_py_to_r(utils_py$ee_path()))
  dir.create(ee_path, showWarnings = FALSE, recursive = TRUE)
  file.copy(from = "credentials", to = ee_path, overwrite = TRUE)


  # 5. Initialize Earth Engine
  ee_Initialize()
}
