team <- fs::dir_ls("_data/team", regexp = "\\w+\\-\\w+\\.yml") |>
  purrr::map(yaml::read_yaml)

# Put Seb first (group leader)
#team <- c(
#  team[which(purrr::map(team, "name") == "Sebastian Funk")],
#  team[-which(purrr::map(team, "name") == "Sebastian Funk")]
#)

icon_link <- function(url, icon, label = NULL) {
  if (is.null(url) || !nzchar(url)) return("")
  sprintf(
    '<a href="%s"><i class="%s"></i>%s</a>',
    url, icon, ifelse(is.null(label), "", paste0(" ", label))
  )
}

## keep current team members
current_team <- team |>
  purrr::keep(\(x) {
    any(purrr::map_lgl(x$position, \(y) {
      is.null(y$end) || y$end > Sys.Date()
    }))
  })
