module.exports = async(page, scenario, vp) => {
  console.log('SCENARIO > ' + scenario.label);
  await require('/src/tests/common/backstopjs/engine_scripts/puppet/clickAndHoverHelper')(page, scenario);
};
