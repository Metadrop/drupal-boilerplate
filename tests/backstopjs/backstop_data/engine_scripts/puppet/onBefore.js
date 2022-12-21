module.exports = async(page, scenario, vp) => {
  await require('./loadCookies')(page, scenario);

  page.waitForSelector('body')
    .then(() => {
      // Avoid lazy load to images.
      page.$$eval('img[loading="lazy"]', (images) => {
          images.map((elem) => {
            elem.loading = 'eager';
          })
        }
      );
    });
};
