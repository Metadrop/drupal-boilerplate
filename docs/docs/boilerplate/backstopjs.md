# Backstopjs

[BackstopJS](https://github.com/garris/BackstopJS) automates visual regression testing of your responsive web UI by comparing DOM screenshots over time.

Check the official [documentation](https://github.com/garris/BackstopJS#using-backstopjs).


## Configuration

Configuration is done in the `tests/backstopjs/backstop.json` file. Check [BackstopJS documentation](https://github.com/garris/BackstopJS#using-backstopjs) for more information.

Intially, BackstopJS is configured to test the homepage. You will have to add any other tests you need.


## Simple usage

First, generate references. This process generates the images of tested URLs:

      make backstopjs-reference

Those images are what the tests expect to see when run.

To run tests use:

      make backstopjs-test

To regenerate the reference images use `make backstopjs-reference` again.
