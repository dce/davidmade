title: "OneTimer"  
date: 2013-02-02

I've been taking a course on [Cryptography][1] and simultaneously working through [Learn C The Hard Way][2] with some coworkers. I've put together a small toolkit of C programs I'm calling [OneTimer][3] to help with encrypting and decrypting messages with the [one time pad][4]. Just being able to take a string of the hexadecimal representation of a message and turn it into a byte array has been super useful. Sample use:

  [1]: https://www.coursera.org/course/crypto 
  [2]: http://c.learncodethehardway.org/book/
  [3]: https://github.com/dce/one-timer
  [4]: http://en.wikipedia.org/wiki/One-time_pad

    > ./encrypt -k f00bd00b -p "Derp"
    b46ea27b

    > ./decrypt -k f00bd00b -c b46ea27b
    Derp

    > ./crack -p "Derp" -c b46ea27b
    f00bd00b

That's some serious spy shit, huh? Just like those guys in [Cryptonomicon][5].

  [5]: http://en.wikipedia.org/wiki/Cryptonomicon
