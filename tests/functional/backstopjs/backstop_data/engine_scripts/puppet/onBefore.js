module.exports = async(page, scenario, vp) => {
  await require('/src/tests/common/backstopjs/engine_scripts/puppet/loadCookies')(page, scenario);
  require('/src/tests/common/backstopjs/engine_scripts/puppet/disable-lazyloading')(page);
};
