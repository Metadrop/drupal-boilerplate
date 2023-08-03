module.exports = async (page, scenario, vp) => {
  console.log('SCENARIO > ' + scenario.label);
  await require('/src/tests/common/backstopjs/engine_scripts/puppet/clickAndHoverHelper')(page, scenario);
  await require('/src/tests/common/backstopjs/engine_scripts/puppet/disable-lazyloading')(page);

  await page.evaluate(() => {
    var total_results_element = document.querySelector('.jobs-total-results');
    if (total_results_element != null) {
      total_results_element.textContent = '200 results(s)';
    }

    var selectors = [
      'job__title',
      'job__info__location',
      'job__info__family',
      'job__info__time',
    ];
    for (var selector in selectors) {
      let elements = Array.from(document.getElementsByClassName(selectors[selector]));
      for (var element in elements) {
        elements[element].textContent = 'Test';
      }
    }
  });

  // Wait for iframes generated using JS,
  if (scenario.scriptIframes) {
    for (const scriptIframesIndex of [].concat(scenario.scriptIframes)) {
      await page.waitForSelector(scriptIframesIndex + ' iframe');
    }
  }

};
