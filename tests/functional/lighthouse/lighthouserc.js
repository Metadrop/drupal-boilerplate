// https://github.com/GoogleChrome/lighthouse-ci/blob/main/docs/configuration.md
module.exports = {
  ci: {
    collect: {
      url: [
        'http://apache'
      ],
      numberOfRuns: 2,
      settings: {
        chromeFlags: "--headless",
        // Don't run certain audits
        skipAudits: [
          //"redirects-http",
          // Best Practices:
          "is-on-https",
          "uses-http2",
          // Performance:
          //"largest-contentful-paint",
        ],
      },
    },
    assert: {
      assertions: {
        "categories:performance": ["error", { "minScore": 0.9 }],
        "categories:accessibility": ["error", { "minScore": 0.9 }],
        "categories:best-practices": ["error", { "minScore": 0.9 }],
        "categories.seo": ["error", { "minScore": 0.9 }],
        // "categories.pwa": ["error", {"minScore": 0.9}],
        "categories.pwa": "off",
      }
    },
    upload: {
      target: 'filesystem',
      reportFilenamePattern: "%%PATHNAME%%.report.%%EXTENSION%%"
    },
  },
};
