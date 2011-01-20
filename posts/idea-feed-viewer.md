title: "Idea: Feed Viewer"  
date: 2011-01-19

In attempting to create an Atom feed for this site, it's become apparent that there's no great way to see what the contents of a feed will look like in a feed reader. Google Reader aggressively caches feed content, making it useless for debugging purposes. I'd like to create a simple web app that takes the URL of a feed, parses it, and displays the content roughly as it will look in a feed reader.

This seems like a good case for a [Node.js][njs] app written in [CoffeeScript][cfs]. Another alternative is a Ruby app using [Sinatra][sin], which would allow me to use a proven feed parsing library like [Feedzirra][fdz]. I'm concerned that most existing libraries are too permissive with regard to malformed feeds, when we're really attempting to highlight problems.

  [njs]: http://nodejs.org/
  [cfs]: http://jashkenas.github.com/coffee-script/
  [sin]: http://www.sinatrarb.com/
  [fdz]: https://github.com/pauldix/feedzirra

For version two, we could tie into the [W3C feed validator][w3c].

  [w3c]: http://validator.w3.org/feed