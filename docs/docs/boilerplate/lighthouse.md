# Lighthouse

[Pa11y](https://pa11y.org/) automates accessibility tests.

Check the official [repository](https://github.com/pa11y/pa11y).


## Configuration

The Lighthouse configuration is in `tests/functional/lighthouse/lighthouserc.js`. You can modify it to match your project requirements. Once modified, the lighthouse contanier needs to be restarted to apply the changes:


      docker compose restart lighthouse


## Simple usage

Run lighthouse tool using:

      make lighthouse
