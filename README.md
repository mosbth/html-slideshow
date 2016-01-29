Mithril HTML Slideshow
============================

I wanted a simple way to create a slideshow using pure HTML and I found the nice implementation of [mithril-slides](https://github.com/wulab/mithril-slides) which uses a JSON-configfile to create the slides.

I took mithril-slides and enabled to write each slide inside a `<script>` element to make it easier to write custom HTML for the slides. I also made it standalone to make it work without a local webserver. Any other features are explained below.

But, apart from my minor changes, the "kernel" and idea has its origin in Weera Wu's mithril-slides.



Getting started
----------------------------

1. Open the file `slideshow.html` in your browser to see the sample slideshow.

2. To add or edit slides, make changes to the `slideshow.html` file and reload your browser.

3. To make a new slideshow, copy `slideshow.html` to another file and edit it.



Keyboard shortcuts
----------------------------

Shortcuts for navigating slides are listed below

| Action                    | Shortcut                                      |
|---------------------------| ----------------------------------------------|
| Next slide                | Right Arrow, Down Arrow, Space bar or Return  |
| Previous slide            | Left Arrow, Up Arrow or Backspace             |
| Enter presentation mode   | f (as in fullscreen)                          |
| 1, 2, 3, 4, 5             | Change theme                                  |
| Quit presentation mode    | Period                                        |



How to write a slide
----------------------------

Create the slides with pure HTML and wrap them in a `<script>` element. Like the following three slides.

```html
<script data-role="slide" type="text/html">
<h1>Lorem Ipsum Dolor</h1>
<h3>Duis aute irure</h3>
<img src="http://placehold.it/770x578">
</script>

<script data-role="slide" type="text/html">
<h1>Lorem Ipsum Dolor</h1>
</script>

<script data-role="slide" type="text/html">
<h1>Lorem Ipsum Dolor</h1>
<ul>
    <li>Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua</li>
    <li>Ut enim ad minim veniam</li>
    <li>Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur</li>
</ul>
</script>
```



How to change the theme
----------------------------

There are three default themes. You can switch between the themes using keys 1 to 5.

You can edit the stylesheet `css/mithril-slideshow.less` to customize your own theme.

Use `make` to generate CSS from the LESS code.
```
$ make build
```



How to add syntax highlighting on sourceode
----------------------------

Syntax highlightning is enabled by default by using [`highlight.js`](https://highlightjs.org/). But you need to separate the code from the slide since creating a slide with sourcecode is a two step rocket.

First create the slide with a placeholder for the code.

```html
<script data-role="slide" type="text/html">
<pre data-code="hello"></pre>
</script>
```

Then create a script element holding the code.

```html
<script id="hello" data-role="code" data-language="php" type="text/html">
<?php
echo "Hello World";
</script>
```

Done. When the slide is created, it will take the code matching `data-code="hello"` with `id="hello"` and run it through the syntax higligther.

Check `slideshow-code.html` for examples.



Use Markdown to write slides
----------------------------

You can write the slides using Markdown. This is enabled by default using [`showdown.js`](https://github.com/showdownjs/showdown). You create a markdown slide using data attribute `data-markdown` like this.

```html
<script data-role="slide" data-markdown type="text/html">
#header 1
##header 2

paragraf 1
</script>
```

Check `slideshow-markdown.html` for examples.



Other HTML slideshow projects
----------------------------

* [mithril-slides](https://github.com/wulab/mithril-slides)
* [HTML Presentation Framework reveal.js](https://github.com/hakimel/reveal.js/)



```                                                            
 .                                                             
..:  Copyright (c) 2015 Mikael Roos, me@mikaelroos.se   
```                                                            
