library(DT)
library(reactlog)
library(rvest)

split_unique <- function(x) {
  x_split <- strsplit(x = x, split = ",")
  x_split <- lapply(x_split, trimws)
  new_x <- unlist(x_split)
  new_x <- sort(unique(new_x))
}

get_cheese_img <- function(url) {
  image_url <- page %>%
    html_element(".cheese-image-border")

  if (!is.null(html_element(image_url, "img"))) {
    image_url <- image_url |>
      html_element("img") |>
      html_attr("src")
  } else {
    image_url <- image_url |>
      html_attr("src")
  }

  full_image_url <- paste0(url, image_url)

  return(full_image_url)
}
