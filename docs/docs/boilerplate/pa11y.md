# Pa11y

[Pa11y](https://pa11y.org/) automates accessibility tests.

Check the official [repository](https://github.com/pa11y/pa11y).


## Configuration

There is not tailored configuration provided by the boilerplate so it uses default values.

Check the [configuration](https://github.com/pa11y/pa11y#configuration) section if you wan tto personalize pa11y runs.


## Simple usage

Run pa11y test using:

      make pa11y <url to check>

Remember that pa11y is run inside the Dockers's container infrastructure, so you must use the internal name for web server. In the default configuration with Apache as web server the name is just apache. In this case, to check the homepage just run:

      make pa11y <url to check>
