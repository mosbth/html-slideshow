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

The theme is set up from the stylesheet and combining with alternate stylesheets, or by editing the source. The sample `slideshow.html` has support for the original, dark and light theme. You can change the theme using your browser (Firefox) menu if you have a browser supporting alternate stylesheet.

You can create your own theme by adding your own stylesheet. Here is the default setup.

```html
<link href="css/mithril-slideshow.css" rel="stylesheet" />
<link href="css/theme-dark.css" rel="alternate stylesheet" title="Dark"/>
<link href="css/theme-light.css" rel="alternate stylesheet" title="Light" />
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



```                                                            
 .                                                             
..:  Copyright (c) 2015 Mikael Roos, me@mikaelroos.se   
```                                                            
