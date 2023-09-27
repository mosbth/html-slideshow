/**
 * Mithril HTML Slideshow
 *
 */

/* globals hljs, showdown, m */

/**
  * Namespace
  */
const app = {}

/**
 * Prepare all code blocks for syntax highlightning.
 */
app.initCodeBlocks = function () {
  const elements = document.querySelectorAll('[data-role="code"]')

  for (let i = 0; i < elements.length; ++i) {
    const item = elements[i]
    const language = item.dataset.language

    hljs.configure({
      languages: [language]
    })

    hljs.highlightBlock(item)
  }
}

/**
 * Prepare all code blocks for syntax highlightning.
 */
app.loadCodeBlocksIntoSlide = function () {
  const elements = document.querySelectorAll('[data-code]')

  for (let i = 0; i < elements.length; ++i) {
    const item = elements[i]
    const code = document.getElementById(item.dataset.code)

    item.innerHTML = code.innerHTML.substr(1) // Exclude first \n
  }
}

/**
 * Prepare all Markdown blocks.
 */
app.initMarkdown = function () {
  const elements = document.querySelectorAll('[data-markdown]')
  const converter = new showdown.Converter({ tables: true })

  for (let i = 0; i < elements.length; ++i) {
    const item = elements[i]

    item.innerHTML = converter.makeHtml(item.innerHTML)
  }
}

/**
 * Enter fullscreen.
 */
app.enterFullscreen = function (element) {
  element = document.body

  if (element.webkitRequestFullScreen && !document.webkitFullscreenElement) {
    element.webkitRequestFullScreen()
  } else if (element.mozRequestFullScreen && !document.mozFullScreenElement) {
    element.mozRequestFullScreen()
  } else if (element.msRequestFullscreen && !document.msFullscreenElement) {
    element.msRequestFullscreen()
  }
}

/**
 * Exit fullscreen.
 */
app.exitFullscreen = function () {
  if (document.webkitExitFullscreen) {
    document.webkitExitFullscreen()
  } else if (document.mozCancelFullScreen) {
    document.mozCancelFullScreen()
  } else if (document.msExitFullscreen) {
    document.msExitFullscreen()
  }
}

/**
 * Display next or previous slide.
 */
app.play = function (controller, reverse) {
  m.startComputation()
  controller.rotateSlide(reverse)
  m.endComputation()
}

/**
 * Change theme.
 */
app.useTheme = function (theme) {
  const element = document.getElementsByTagName('html').item(0)

  console.log(element)

  element.classList.remove('theme-1', 'theme-2', 'theme-3', 'theme-4', 'theme-5', 'theme-6', 'theme-7', 'theme-8', 'theme-9', 'theme-0')
  element.classList.add('theme-' + theme)
}

/**
 * Goto specific slide.
 */
app.goto = function () {
  // navigate to a specific slide
}

/**
 * Show help.
 */
app.showHelp = function () {
  // Show help
}

/**
 * Display all alises.
 */
app.showAll = function () {
  // Show all slides
}

/**
 * Prepare to print.
 */
app.print = function () {
  // Prepare to print the slides
  m.startComputation()
  controller.rotateSlide(reverse)
  m.endComputation()
}

/**
 * Navigate.
 */
const cp = {}

cp.navigate = function (controller, event) {
  console.log(event.keyCode)

  switch (event.keyCode) {
    case 0: // ContextMenu
    case 13: // Enter
    case 32: // Space
    case 39: // ArrowRight
    case 40: // ArrowDown
      app.play(controller)
      break
    case 8: // Backspace
    case 37: // ArrowLeft
    case 38: // ArrowUp
      app.play(controller, true)
      break
    case 65: // a
      app.showAll()
      break
    case 70: // f
      app.enterFullscreen()
      break
    case 72: // h
      app.showHelp()
      break
    case 80: // h
    case 187: // ?
      app.print()
      break
    case 190: // Period
      app.exitFullscreen()
      break

    case 49: // 1 Theme 1
    case 50: // 2 Theme 2
    case 51: // 3 Theme 3
    case 52: // 4 Theme 4
    case 53: // 5 Theme 5
    case 54: // 6 Theme 6
    case 55: // 7 Theme 7
    case 56: // 8 Theme 8
    case 57: // 9 Theme 9
    case 58: // 0 Theme 0?
      app.useTheme(event.keyCode - 48)
      break

    default:
      return
  }

  return false
}

/**
 * Config
 */
app.config = function (controller) {
  return function (element, isInitialized) {
    app.loadCodeBlocksIntoSlide()

    if (!isInitialized) {
      const navigate = function (event) {
        cp.navigate(controller, event)
      }

      window.onclick = navigate
      window.onkeydown = navigate
      window.ontouchend = navigate
      // window.oncontextmenu = function() { return false };
    }
  }
}

/**
 * Model
 */
app.slideList = function () {
  return document.querySelectorAll('[data-role="slide"]')
}

/**
 * Controller
 */
app.controller = function () {
  const slides = app.slideList()
  let current = 0

  return {

    currentSlide: function () {
      return slides.item(current)
    },

    rotateSlide: function (reverse) {
      if (reverse) {
        current = (current === 0) ? slides.length - 1 : current - 1
      } else {
        current = (current === slides.length - 1) ? 0 : current + 1
      }
    }
  }
}

/**
 * View
 */
app.view = function (controller) {
  const slide = controller.currentSlide()
  return m(
    'div#slide',
    {
      config: app.config(controller)
    },
    [
      m('div#objects',
        {
          class: slide.classList.toString()
        },
        m.trust(slide.innerHTML)
      )
    ]
  )
}

/**
 * Initialize
 */
window.addEventListener('load', function () {
  app.initCodeBlocks()
  app.initMarkdown()
  document.body = document.createElement('body')
  m.module(document.body, app)
})
