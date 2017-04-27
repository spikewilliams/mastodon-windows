Mastodon on Docker for Windows (MD4W)- A development environment

MD4W makes Rails/Mastodon development on Windows tolerable.

It consists of scripts that can be used to run the Mastodon Ruby on Rails app inside a Docker container, while making the code itself available and persisted on the Windows host. This means you can do all your code editing in Windows at the same time the code is running, on the same machine, under a Fedora environment inside a Docker container. Postgres and Redis also come installed on the container.

This container works on my machine, but should consider it an "alpha" release. There is much that is yet untested, and still quite a bit of cleanup and streamlining to be done.

Instructions:

The first thing you will need to do is get Docker for Windows installed and running on your Windows 10 computer. Good luck. - https://docs.docker.com/docker-for-windows/

You will need to go into Docker for Windows Settings to ensure that your current drive is shared. This enables the Docker container to install Ruby and Mastodon so that they are accessable on your host machine.

Now, open a cmd shell and clone the spikewilliams/mastodon-windows repository

    git clone https://github.com/spikewilliams/mastodon-windows

To install and run the Docker container:

    cd mastodon-windows
    run_container.bat

You now have a container running that has Ruby 2.4.1 and Postgres installed. Run this script to connect to it:

    connect_to_container.bat

You are on a bash shell running on the container. You will now need to run a script to install Mastodon. Its going to take a while (maybe 30 minutes) as the various package mangers want to download everything under the sun. This is the command to run the script:

    ./scripts/install_mastodon.sh

The above script will install Mastodon under the /railsapp/mastodon directory (soft link at /mastodon), which is actually a directory mounted on your host, under "railsapp" in your current Windows directory.

At this point there are a couple things you need to do that havn't been automated away yet:

    source ~/.bashrc    # this sets up PATH so that rails can be found
    sudo -u postgres pg_ctl -D /var/lib/pgsql/data -l /tmp/pg.log start  # this starts postgres

Now its time to run db:migrate

    rails db:migrate

You also want to precompile assets

    rails assets:precompile

Now, run the rails application

    rails server -b 0.0.0.0 -e development

Open a browser tab on your host machine and go to

    http://localhost:3000

et voila! There you have your Mastodon instance.

The first thing you should do on the about page is register an email, username, and password. 

















Deleting containers

At some point, when you are launching a container you may get an error that looks like this:

    docker: Error response from daemon: Conflict. The container name "/mastodon4wd-access" is already in use by container 0cb43c3b4e0d57674dda0a9e2972fa791517c412cf97f63232ffe4b30c5a3d1f. You have to remove (or rename) that container to be able to reuse that name..

See 'docker run --help'.

This means a container already exists. It may or may not be running. You can try to restart/connect to it if you want, or you can decide to delete it. If you ever decide to delete it, the best thing to do is make sure its stopped, and then run:

    docker rm 0cb43

Where "0cb43" is taken from the beginning of the container id - 0cb43c3b4e0d57674dda0a9e2972fa791517c412cf97f63232ffe4b30c5a3d1f.
