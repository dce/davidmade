title: "Look-&amp;-Feel Updates; Content Filtering"  
date: 2011-03-13

I spent some time working on the site this weekend, including
adding a new visual design and the ability to filter posts
by content type (see the little 'audio' and 'text' buttons above).
Visual updates include:

  * Webfonts! I grabbed [League Gothic][lgg] and [Sorts Mill
    Goudy][smg] from the [League of Movable Type][lmt] and
    converted them for the web using [FontSquirrel][fsq].

  [lgg]: http://www.theleagueofmoveabletype.com/fonts/7-league-gothic
  [smg]: http://www.theleagueofmoveabletype.com/fonts/6-sorts-mill-goudy
  [lmt]: http://www.theleagueofmoveabletype.com/
  [fsq]: http://www.fontsquirrel.com/fontface/generator

  * CSS3 techniques, including text-shadow for the header,
    border-radius for the category buttons, and RGBA all over
    the place.

  * Also, the whole thing's orange.

Adding the content type filtering turned out to be a little bit
tricky, just based on the way I set up the rendering system. I
think it will be cool, though -- I added per-type ATOM feeds, and
I'm hoping to be able to serve up the audio feed as a podcast once
I figure out the nuances of iTunes and get much better at playing
piano.

Having this whole site in a git repo has made both posting to and
customizing the site much more enjoyable than having to go through a web
interface. I WILL NEVER GO BACK.
