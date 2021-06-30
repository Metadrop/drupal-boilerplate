// More info about configuration https://github.com/GoogleChrome/lighthouse-ci/blob/main/docs/configuration.md
module.exports = {
  ci: {
    collect: {
      // List of urls to test.
      url: ['http://nginx'],
      // Number of executions by url.
      numberOfRuns: 1,
      settings: {
        chromeFlags: "--headless --disable-gpu --no-sandbox"
      },
    },
    upload: {
      target: 'filesystem',
      reportFilenamePattern: "%%PATHNAME%%.report.%%EXTENSION%%"
    },
  },
};
