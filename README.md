Davidmade
=========

This is a simple app to generate a [Tumblr][tum]-style blog backed by a Git repo. It's what's powering <http://davidmade.com>. The site is automatically regenerated whenever I do a `git push`.

  [tum]: http://www.tumblr.com/

## Requirements

This whole thing's done with Ruby and Rake. You'll need the [Mustache][mus], [RDiscount][rds], and [Sass][sas] gems.

  [mus]: https://github.com/defunkt/mustache
  [rds]: https://github.com/rtomayko/rdiscount
  [sas]: http://sass-lang.com/

## Running Locally

Run `rake build` to generate the static HTML pages. To view your site, run `rake server`, then head to <http://localhost:8000> in your browser.

Any change you make to the content or site structure will require a new `rake build`.

## Deployment

To deploy your site to a remote server, follow [these instructions][git] to set up a remote repo, then copy the included `post-update-sample` to `.git/hooks/post-update` (and `chmod +x` it to make it executable). If you're interested, here's some [more info][rep] about what's going on with this hook.

  [git]: http://bulkan-evcimen.com/setting_up_git_repository_on_slicehost/
  [rep]: https://git.wiki.kernel.org/index.php/GitFaq#Why_won.27t_I_see_changes_in_the_remote_repo_after_.22git_push.22.3F

With that in place, your site will rebuild every time you do a `git push`.

--

Thanks for checking out my code, and don't hesitate to drop me a line if you have any questions or suggestions for improvement.

David Eisinger
