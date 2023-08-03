module.exports = async (page, scenario, vp) => {
  await require('/src/tests/common/backstopjs/engine_scripts/puppet/loadCookies')(page, scenario);

  // Custom Timeout
  await page.setDefaultNavigationTimeout(300000);

};
