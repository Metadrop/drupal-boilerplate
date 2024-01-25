// https://github.com/GoogleChrome/lighthouse-ci/blob/main/docs/configuration.md
module.exports = {
    ci: {
      collect: {
        url: [
          'http://apache/'
        ],
        numberOfRuns: 2,
        settings: {
          chromeFlags: "--headless",
          // Don't run certain audits
          skipAudits: [
            // Best Practices:
            // Local boxes usually don't have SSL/TSL certificates so let's
            // skip these tests.
            "is-on-https",
            "uses-http2",
          ],
        },
      },
      assert: {
        assertions: {
          "categories:performance": ["error", {"minScore": 0.88}],
          "categories:accessibility": ["error", {"minScore": 0.9}],
          "categories:best-practices": ["error", {"minScore": 0.9}],
          "categories.seo": ["error", {"minScore": 0.9}],
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
