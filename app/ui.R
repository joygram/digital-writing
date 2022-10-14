# 마크다운 콘텐츠 변환
# https://stackoverflow.com/questions/56860382/r-shinyace-non-reactive-checkboxinput

markdown_text <- ""

title_panel <- titlePanel(
    fluidRow(
        column(
            1,
            align = "center",
            img(height = 57, width = 57, src = "dw_logo.png"),
        ),
        column(
            6,
            align = "left",
            h1("디지털 글쓰기")
        )
    )
)

footer <- div(
    class = "footer",
    includeHTML("www/footer.html")
)

selector <-
    selectInput("curriculum",
        "글쓰기 분야를 선택 하세요.",
        choices = c("분야를 골라주세요." = "", "확률통계" = "stat", "수학" = "math", "국어" = "korean")
    )

mark_editor <- aceEditor(
    outputId = "rmd",
    mode = "markdown",
    tabSize = 4,
    autoComplete = "live",
    autoCompleters = c("keyword", "text"),
    useSoftTabs = TRUE,
    fontSize = 14,
    debounce = 1000,
    wordWrap = TRUE,
    autoScrollEditorIntoView = TRUE,
    showInvisibles = FALSE,
    height = "800px",
    theme = "solarized_light",
    value = markdown_text
)
mark_preview <- htmlOutput("knit_doc")

markdown_fluid_row <- fluidRow(
    column(
        6,
        h3("에디터"),
        hr(),
        downloadButton("report", "보고서"),
        mark_editor
    ),
    column(
        6,
        h3("미리보기"),
        hr(),
        mark_preview
    )
)

fluid_page <- fluidPage(
    title = "디지털 글쓰기",
    shinyjs::useShinyjs(),
    #    includeCSS("www/editor.css"),
    title_panel,
    selector,
    markdown_fluid_row,
    footer
)

ui <- shinyUI(
    fluid_page
)
