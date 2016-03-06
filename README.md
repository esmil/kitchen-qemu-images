kitchen-qemu-images Cookbook
============================

This cookbook creates bootable qcow2 images for use
with [kitchen-qemu][driver].


Requirements
------------

See [kitchen-qemu][driver] for installation instructions and
download pre-built images from [here][images].


Usage
-----

Here is the list of OS images that can be built:

| Target    | OS
|-----------|-------------------|
| jessie    | Debian 8          |
| wheezy    | Debian 7          |
| trusty    | Ubuntu 14.04 LTS  |
| freebsd10 | FreeBSD 10        |

For your convenience the repo has a Makefile so you simply type
```
$ make <target>
```

Development
-----------

* Source hosted at [GitHub][repo]
* Report issues/questions/feature requests on [GitHub Issues][issues]

Pull requests are very welcome! Make sure your patches are well tested.
Ideally create a topic branch for every separate change you make. For
example:

1. Fork the repo
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


Authors
-------
Emil Renner Berthing <<esmil@esmil.dk>>


License
-------
GPLv3 or later (see [LICENSE][license]).


[driver]:   https://github.com/esmil/kitchen-qemu
[images]:   http://esmil.dk/kitchen-qemu/
[repo]:     https://github.com/esmil/kitchen-qemu-images
[issues]:   https://github.com/esmil/kitchen-qemu-images/issues
[license]:  https://github.com/esmil/kitchen-qemu-images/blob/master/LICENSE
