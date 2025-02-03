library(checkmate)
library(dplyr)

my_function <- function(df, at, add) {
  assert_data_frame(df)
  assert_string(at)
  assert_choice(at, colnames(df))
  assert_numeric(add)

  df |>
    mutate(across(all_of(at), ~ .x + add))
}

my_function(list(x = 1), "mpg", "a")
my_function(mtcars, "mpg", "a")
my_function(mtcars, "x", 1)
