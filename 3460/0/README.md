= Neo Ruby Koans

The Ruby Koans walk you along the path to enlightenment in order to learn Ruby.
The goal is to learn the Ruby language, syntax, structure, and some common
functions and libraries. We also teach you culture by basing the koans on tests.
Testing is not just something we pay lip service to, but something we
live.  Testing is essential in your quest to learn and do great things in Ruby.

== The Structure

The koans are broken out into areas by file, hashes are covered in +about_hashes.rb+,
modules are introduced in +about_modules.rb+, <em>etc</em>.  They are presented in
order in the +path_to_enlightenment.rb+ file.

Each koan builds up your knowledge of Ruby and builds upon itself. It will stop at
the first place you need to correct.

Some koans simply need to have the correct answer substituted for an incorrect one.
Some, however, require you to supply your own answer.  If you see the method +__+ (a
double underscore) listed, it is a hint to you to supply your own code in order to
make it work correctly.

== The Path To Enlightenment

You can run the tests through +rake+ or by calling the file itself (+rake+ is the
recommended way to run them as we might build more functionality into this task).

*nix platforms, from the +ruby_koans+ directory

    [ruby_koans] $ rake                           # runs the default target :walk_the_path
    [ruby_koans] $ ruby path_to_enlightenment.rb  # simply call the file directly

=== Red, Green, Refactor

In test-driven development the mantra has always been <em>red, green, refactor</em>.
Write a failing test and run it (<em>red</em>), make the test pass (<em>green</em>),
then look at the code and consider if you can make it any better (<em>refactor</em>).

While walking the path to Ruby enlightenment you will need to run the koan and
see it fail (<em>red</em>), make the test pass (<em>green</em>), then take a moment
and reflect upon the test to see what it is teaching you and improve the code to
better communicate its intent (<em>refactor</em>).

The very first time you run the koans you will see the following output:

    [ ruby_koans ] $ rake
    (in /Users/person/dev/ruby_koans)
    /usr/bin/ruby1.8 path_to_enlightenment.rb

    AboutAsserts#test_assert_truth has damaged your karma.

    The Master says:
    You have not yet reached enlightenment.

    The answers you seek...
    <false> is not true.

    Please meditate on the following code:
    ./about_asserts.rb:10:in `test_assert_truth'
    path_to_enlightenment.rb:38:in `each_with_index'
    path_to_enlightenment.rb:38

    mountains are merely mountains
    your path thus far [X_________________________________________________] 0/280

You have come to your first stage. Notice it is telling you where to look for
the first solution:

    Please meditate on the following code:
    ./about_asserts.rb:10:in `test_assert_truth'
    path_to_enlightenment.rb:38:in `each_with_index'
    path_to_enlightenment.rb:38

Open the +about_asserts.rb+ file and look at the first test:

    # We shall contemplate truth by testing reality, via asserts.
    def test_assert_truth
      assert false                # This should be true
    end

Change the +false+ to +true+ and re-run the test.  After you are
done, think about what you are learning.  In this case, ignore everything except
the method name (+test_assert_truth+) and the parts inside the method (everything
before the +end+).

In this case the goal is for you to see that if you pass a value to the +assert+
method, it will either ensure it is +true+ and continue on, or fail if
the statement is +false+.

=== Running the Koans automatically

<em>This section is optional.</em>

Normally the path to enlightenment looks like this:

    cd ruby_koans
    rake
    # edit
    rake
    # edit
    rake
    # etc

If you prefer, you can keep the koans running in the background so that after you
make a change in your editor, the koans will immediately run again. This will
hopefully keep your focus on learning Ruby instead of on the command line.

Install the Ruby gem (library) called +observr+ and then ask it to
"watch" the koans for changes:

    cd ruby_koans
    rake
    # decide to run rake automatically from now on as you edit
    gem install observr
    observr koans.watchr

== Inspiration

A special thanks to Mike Clark and Ara Howard for inspiring this
project.  Mike Clark wrote an excellent blog post about learning Ruby
through unit testing. This sparked an idea that has taken a bit to
solidify, that of bringing new rubyists into the community through
testing. Ara Howard then gave us the idea for the Koans in his ruby
quiz entry on Meta Koans (a must for any rubyist wanting to improve
their skills).  Also, "The Little Lisper" taught us all the value of
the short questions/simple answers style of learning.

Mike Clark's post ::  http://www.clarkware.com/cgi/blosxom/2005/03/18
Meta Koans        ::  http://rubyquiz.com/quiz67.html
The Little Lisper ::  http://www.amazon.com/Little-LISPer-Third-Daniel-Friedman/dp/0023397632

== Other Resources

The Ruby Language               ::  http://ruby-lang.org
Try Ruby in your browser        ::  http://tryruby.org

Dave Thomas' introduction to Ruby Programming Ruby (the Pick Axe) ::  http://pragprog.com/titles/ruby/programming-ruby

Brian Marick's fantastic guide for beginners Everyday Scripting with Ruby    ::  http://pragprog.com/titles/bmsft/everyday-scripting-with-ruby

= Other stuff

Author         :: Jim Weirich <jim@neo.org>
Author         :: Joe O'Brien <joe@objo.com>
Issue Tracker  :: http://www.pivotaltracker.com/projects/48111
Requires       :: Ruby 1.8.x or later and Rake (any recent version)

= License

http://i.creativecommons.org/l/by-nc-sa/3.0/88x31.png

RubyKoans is released under a Creative Commons,
Attribution-NonCommercial-ShareAlike, Version 3.0
(http://creativecommons.org/licenses/by-nc-sa/3.0/) License.
