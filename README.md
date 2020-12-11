HTML Slideshow
============================

[![npm version](https://badge.fury.io/js/html-slideshow.svg)](https://badge.fury.io/js/html-slideshow)
[![Join the chat at https://gitter.im/mosbth/html-slideshow](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/mosbth/html-slideshow?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Build Status](https://travis-ci.com/mosbth/html-slideshow.svg?branch=master)](https://travis-ci.com/mosbth/html-slideshow)

Create slideshows using HTML and Markdown and view them in a single HTML page.

You write all your slides in one html file. Each slide is written in its own `<script>` tag and you can use html, markdown and show programming code with syntax higlighted.

Here is how a markdown slide can be created, as part of a web page.

```
<script data-role="slide" data-markdown type="text/html">
# Here is a bullet list

* bullet
* bullet
* another bullet

</script>
```

When you open the html file in a browser, each `<script>` tag is rendered to be displayed as a slide.

It can look like this.

![Slide with a bullet list](htdocs/img/slide-bullet-list.png)

Read on to learn more on how to use HTML Slideshow.



Main features
----------------------------

1. Create and display a HTML slideshow in a browser in full screen.
1. Write Markdown, HTML, show images and source code in your slideshow. You can show any HTML/Markdown construct.
1. Build themes for the slideshow and style each slide individually using LESS/CSS.
1. Create a permanent slideshow and select the theme to be used.
1. Install the source as a npm package.
1. Use by linking to a CDN or install the js/css locally to enabe offline usage.

<!--
1. Link directly to a specific slide.
1. Render a markdown dokument to a slideshow.
1. Print a slideshow to pdf document
1. Add notes to each slide, enable to view the notes.
-->



Try it out on your own
----------------------------

You can download the source to the file [`htdocs/cdn_v1.0.0.html`](htdocs/cdn_v1.0.0.html) and open it locally in your browser.

Or you can create your own `slide.html` and put the following code in it.

```html
<!doctype html>
<meta charset="utf-8" />
<link href="https://dbwebb.se/cdn/css/html-slideshow_v1.0.0.bundle.min.css" rel="stylesheet" />
<script src="https://dbwebb.se/cdn/js/html-slideshow_v1.0.0.bundle.min.js"></script>

<title>html-slides</title>

<script data-role="slide" data-markdown type="text/html">

This slideshow is created using Markdown and uses the CDN to load the css/js files needed.
</script>

<script data-role="slide" data-markdown type="text/html">
# Here is a bullet list

* bullet
* another bullet
* the third bullet
</script>
```

When you open it in a browser, you will see the slide and you can navigate through the slides using the keyboard arrow keys.



Try it out by examples
----------------------------

This repo contains some sample presentations, published onto GitHub pages, that you can review to get an understanding on how it works. Try them out through the link below and review their source code to see how the slides are built.

Start with these general examples.

| Presentation             | Explained                                     |
|--------------------------|-----------------------------------------------|
| [markdown.html](https://mosbth.github.io/mithril-slideshow/htdocs/markdown.html) | Slides created by writing markdown in a html page. |
| [html.html](https://mosbth.github.io/mithril-slideshow/htdocs/html.html) | Slides created by writing HTML in a html page. |

Here are more specific examples to create customized slides.

| Presentation             | Explained                                     |
|--------------------------|-----------------------------------------------|
| [class.html](https://mosbth.github.io/mithril-slideshow/htdocs/class.html) | Using the class attribute to select starting theme and style slides individually. |
| [code.html](https://mosbth.github.io/mithril-slideshow/htdocs/code.html) | Sample slides displaying code with or without syntax higlightning. |
| [iframe.html](https://mosbth.github.io/mithril-slideshow/htdocs/iframe.html) | Sample slides displaying how to use iframe in a slide. |
| [image.html](https://mosbth.github.io/mithril-slideshow/htdocs/image.html) | How to use images in slides. |

<!--
video
improve syntax higligtning
    add python and c
-->



Keyboard shortcuts
----------------------------

Shortcuts for navigating in the slideshow.

| Action                    | Shortcut                                      |
|---------------------------| ----------------------------------------------|
| Next slide                | Right Arrow, Down Arrow, Space bar or Return  |
| Previous slide            | Left Arrow, Up Arrow or Backspace             |
| Enter presentation mode   | f (as in fullscreen)                          |
| 1, 2, 3, 4, 5             | Change theme                                  |
| Quit presentation mode    | Period or ESC                                 |

<!--
Add overlay with "help"
-->



How to write a slideshow, slide by slide
----------------------------

Here is how you can create a slideshow, slide by slide with the different settings available.



### The base

The slideshow needs HTML-document and access to the files `html-slideshow.js` and `html-slideshow.css`. A sample start of an slideshow with an empty slide can look like this.

```html
<!doctype html>
<meta charset="utf-8" />
<link href="css/html-slideshow.bundle.min.css" rel="stylesheet" />
<script src="js/html-slideshow.bundle.min.js"></script>
<title>html-slides</title>

<script data-role="slide" type="text/html">
</script>
```

You can then add slide by slide within each own script element.



### A HTML slide

This is how a plain HTML slide can look like.

```html
<script data-role="slide" type="text/html">
<h1>Here is a bullet list</h1>

<ul>
    <li>bullet</li>
    <li>another bullet</li>
    <li>the third bullet</li>
</ul>

</script>
```

Check [`htdocs/html.html`](htdocs/html.html) for examples.



### A Markdown slide

By adding the attribute `data-markdown` the slide can contain Markdown as well as HTML. This is enabled using [`showdown.js`](https://github.com/showdownjs/showdown).

```html
<script data-role="slide" type="text/html" data-markdown>
# Here is a bullet list

* bullet
* another bullet
* the third bullet

</script>
```

Check [`htdocs/markdown.html`](htdocs/markdown.html) for examples.



### Syntax highlighting on source code

Syntax highlighting is enabled by default by using [`highlight.js`](https://highlightjs.org/). You need to separate the code from the slide since creating a slide is currently implemented as a two step rocket in the source code.

First create the slide with a placeholder for the code where `data-code="placeholder-id"` is used to link to the placeholder.

```html
<script data-role="slide" type="text/html">
<pre data-code="placeholder-id"></pre>
</script>
```

Then create a script element holding the code and using the same id as `id="placeholder-id"`. Also add the `data-role="code"` to make the placeholder rendered as syntax highlighted code and use `data-language="php"` to set the language.

```html
<script id="placeholder-id" data-role="code" data-language="php" type="text/html">
<?php
echo "Hello World";
</script>
```

When the slide is created, it will take the code matching `data-code="placeholder-id"` with `id="placeholder-id"` and run it through the syntax higligther.

Check [`htdocs/code.html`](htdocs/code.html) for examples.



### Individually style a slide

By adding the class attribute you can apply individual style to the slide using CSS classes.

Here is an example with `class="center"` that alignes the items in the slide to be centered.

The stylesheet contains the following class `.center`.

```less
.center {
    h1,
    h2,
    h3,
    p,
    figure {
        text-align: center;
    }
}
```

This is how the class is used in the slide.

```html
<script data-role="slide" type="text/html" data-markdown class="center">
<figure>
    <img src="http://placehold.it/1024x768">
<figcaption>This is a image caption.</figcaption>
</figure>
</script>
```

Check [`htdocs/class.html`](htdocs/class.html) for examples.



### Set default theme of a slideshow

You can choose any theme as the default theme by adding its css class as part of the html element.

```html
<html class="theme-3">
```

Check [`htdocs/class.html`](htdocs/class.html) for examples.



How to change the style
----------------------------

You can add your own style by creating CSS inline as part of the slideshow html document or by adding an external css file.

You can also add your changes to the source code and built a new target. This is explained below.



How to change the theme
----------------------------

There are a set of default themes. You can switch between the themes using keys 1 to 5.

Review the source [`src/less/html-slideshow.less`](src/less/html-slideshow.less) to see how to create your own theme.



How to build you own customizations
----------------------------

You can clone this repo and build your own customizations into it.

```bash
git clone https://github.com/mosbth/html-slideshow.git
cd html-slideshow
make install
make # to show what can be done
```

The source code is available in `src/` in the following files.

* `src/js/html-slideshow.js` as JavaScript source code.
* `src/less/html-slideshow.less` compiles down to `html-slideshow.css`.

The external libraries are stored in `src/js/lib` and `src/css/lib`.

Make updates to the source and build a new distribution like this.

```bash
make test      # Run all tests
make build     # Build and compile
make bundle    # Bundle the new build with external libs
```

Build files are generated to `build/`.

When successfully builts they are copied to `htdocs/` where the example files `*.html` can be used to verify that the new budnle works as expected.



Libraries used
----------------------------

These are the libraries used to create html-slideshow and these are included in the html-slideshow bundle.

* [Mithril](https://mithril.js.org/) as a small SPA framework
* [highlight.js](https://highlightjs.org/) to highlight the source code
* [showdown.js](https://github.com/showdownjs/showdown) as JavaScript Markdown to HTMl converter

Version v1.0 and v1.1.0 of html-slideshow bundle includes the following versions of external libraries.

* Mithril: v0.2.0
* Highlight.js (unknown version from 2016-01-29)
* Showdown.js: 2015-10-19



Other HTML slideshow projects
----------------------------

There are other projects looking like this, review them and compare.

* [mithril-slides](https://github.com/wulab/mithril-slides)
* [HTML Presentation Framework reveal.js](https://github.com/hakimel/reveal.js/)



History
----------------------------

I wanted a simple way to create a slideshow using pure HTML and I found the nice implementation of [mithril-slides](https://github.com/wulab/mithril-slides) which uses a JSON-config file to create the slides.

I took mithril-slides and enabled to write each slide inside a `<script>` element to make it easier to write custom HTML for the slides. I also made it standalone to make it work without a local webserver. Other additional features are explained in this README.

Apart from my feature updates, the "kernel" and idea has its origin in Weera Wu's mithril-slides.

The version 1.0 was used for a couple of years in our techer team doing education.

The version 1.1 was built when I needed an improved version with regards to styling, themes and production, presentation and archiving of slideshows used for educational purpose. It was to prepare for a larger v2 update by structuring the code a bit better.



```                                                            
 .                                                             
..:  Copyright (c) 2015 - 2020 Mikael Roos, me@mikaelroos.se   
```                                                            
