# Lighthouse

[Lighthouse](https://developer.chrome.com/docs/lighthouse) has audits for performance, accessibility, progressive web apps, SEO, and more.

Check the official [documentation](https://developer.chrome.com/docs/lighthouse/overview).


## Configuration

The Lighthouse configuration is in `tests/functional/lighthouse/lighthouserc.js`. You can modify it to match your project requirements. Once modified, the lighthouse contanier needs to be restarted to apply the changes:


      docker compose restart lighthouse


## Simple usage

Run lighthouse tool using:

      make lighthouse
