Milosolutions Cookiecutter Django
=================================

.. image:: https://pyup.io/repos/github/pydanny/cookiecutter-django/shield.svg
     :target: https://pyup.io/repos/github/pydanny/cookiecutter-django/
     :alt: Updates

.. image:: https://travis-ci.org/pydanny/cookiecutter-django.svg?branch=master
     :target: https://travis-ci.org/pydanny/cookiecutter-django?branch=master
     :alt: Build Status

.. image:: https://badges.gitter.im/Join Chat.svg
   :target: https://gitter.im/pydanny/cookiecutter-django?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge

Powered by Cookiecutter_, Milosolutions Cookiecutter Django is a framework for jumpstarting production-ready Django projects quickly. ( forked from Cookiecutter Django ).

* See Troubleshooting_ for common errors and obstacles

.. _cookiecutter: https://github.com/audreyr/cookiecutter

.. _Troubleshooting: https://cookiecutter-django.readthedocs.io/en/latest/troubleshooting.html

.. _528: https://github.com/pydanny/cookiecutter-django/issues/528#issuecomment-212650373
.. _issues: https://github.com/pydanny/cookiecutter-django/issues/new

Features
--------

* For Django 1.10
* Renders Django projects with 100% starting test coverage
* Twitter Bootstrap_ v4.0.0 - `alpha 4`_ (`maintained Foundation fork`_ also available)
* 12-Factor_ based settings via django-environ_
* Optimized development and production settings
* Registration via django-allauth_
* Comes with custom user model ready to go
* Grunt build for compass and livereload
* Send emails via Anymail_ (using Mailgun_ by default, but switchable)
* Works with Python 3.5.x
* Run tests with unittest or py.test

.. _`maintained Foundation fork`: https://github.com/Parbhat/cookiecutter-django-foundation


Optional Integrations
---------------------

*These features can be enabled during initial project setup.*

* Configuration for Celery_
* Integration with MailHog_ for local email testing
* Integration with Sentry_ for error logging

.. _`alpha 4`: http://blog.getbootstrap.com/2016/09/05/bootstrap-4-alpha-4/
.. _Bootstrap: https://github.com/twbs/bootstrap
.. _django-environ: https://github.com/joke2k/django-environ
.. _12-Factor: http://12factor.net/
.. _django-allauth: https://github.com/pennersr/django-allauth
.. _django-avatar: https://github.com/grantmcconnaughey/django-avatar
.. _Mailgun: http://www.mailgun.com/
.. _Celery: http://www.celeryproject.org/
.. _Anymail: https://github.com/anymail/django-anymail
.. _MailHog: https://github.com/mailhog/MailHog
.. _Sentry: https://sentry.io/welcome/
.. _Opbeat: https://opbeat.com/


Constraints
-----------

* Only maintained 3rd party libraries are used.
* Uses PostgreSQL everywhere (9.5+)
* Environment variables for configuration (This won't work with Apache/mod_wsgi).


Usage
-----

Let's pretend you want to create a Django project called "redditclone". Rather than using `startproject`
and then editing the results to include your name, email, and various configuration issues that always get forgotten until the worst possible moment, get cookiecutter_ to do all the work.

First, get Cookiecutter. Trust me, it's awesome::

    $ pip install "cookiecutter>=1.4.0"

Now run it against this repo::

    $ cookiecutter https://github.com/milosolutions/cookiecutter-django

You'll be prompted for some values. Provide them, then a Django project will be created for you.

**Warning**: After this point, change 'Michal Zyndul', etc to your own information.

Answer the prompts with your own desired options_. For example::

    Cloning into 'cookiecutter-django'...
    remote: Counting objects: 550, done.
    remote: Compressing objects: 100% (310/310), done.
    remote: Total 550 (delta 283), reused 479 (delta 222)
    Receiving objects: 100% (550/550), 127.66 KiB | 58 KiB/s, done.
    Resolving deltas: 100% (283/283), done.
    project_name [Project Name]: Reddit Clone
    project_slug [reddit_clone]: reddit
    author_name [Daniel Roy Greenfeld]: Daniel Greenfeld
    email [you@example.com]: pydanny@gmail.com
    description [A short description of the project.]: A reddit clone.
    domain_name [example.com]: myreddit.com
    version [0.1.0]: 0.0.1
    timezone [UTC]: America/Los_Angeles
    use_celery [n]: y
    use_mailhog [n]: n
    use_sentry_for_error_reporting [y]: y
    use_pycharm [n]: y
    windows [n]: n
    use_python3 [y]: y
    use_compressor [n]: y
    Select postgresql_version:
    1 - 9.5
    Choose from 1, 2 [1]: 1
    Select js_task_runner:
    1 - Gulp
    2 - Grunt
    4 - None
    Choose from 1, 2, 3 [1]: 1

Enter the project and take a look around::

    $ cd reddit/
    $ ls

Create a git repo and push it there::

    $ git init
    $ git add .
    $ git commit -m "first awesome commit"
    $ git remote add origin git@github.com:xxxxxx/xxxxxxxxx.git
    $ git push -u origin master

Now take a look at your repo. Don't forget to carefully look at the generated README. Awesome, right?

For local development, see the following:

* `Developing locally`_

TODO
----

- add memcache for default caching


Fork This
~~~~~~~~~

If you have differences in your preferred setup, I encourage you to fork this to create your own version.
Once you have your fork working, let me know and I'll add it to a '*Similar Cookiecutter Templates*' list here.
It's up to you whether or not to rename your fork.

If you do rename your fork, I encourage you to submit it to the following places:

* cookiecutter_ so it gets listed in the README as a template.
* The cookiecutter grid_ on Django Packages.

.. _cookiecutter: https://github.com/audreyr/cookiecutter
.. _grid: https://www.djangopackages.com/grids/g/cookiecutters/
